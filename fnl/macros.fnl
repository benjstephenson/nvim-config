;; fennel-ls: macro-file

(local {: nil?
        : str?
        : bool?
        : num?
        : ->str
        : begins-with?
        : all
        : crypt
        : car} (require :core.lib))

(lambda expr->str [expr]
  `(-> (macrodebug ,expr nil (string.gsub "{}" "[]")
                   (string.gsub "_%d+_auto" "#"))))

(lambda extend-fn [fn-name args & body]
  (assert-compile (sym? fn-name) "expected symbol for fn-name" fn-name)
  (assert-compile (sequence? args) "expected list for args" args)
  (assert-compile (> (length body) 0) "expected at least one statement" body)
  (table.insert body `(values (unpack result#)))
  `(let [old# ,fn-name]
     (set ,fn-name (fn [...]
                     (local result# [(old# ...)])
                     (local [,(unpack args)] result#)
                     ,(unpack body)))
     ,fn-name))

(lambda fn? [x]
  "Checks if `x` is a function definition.
  Cannot check if a symbol is a function in compile time."
  (and (list? x) (or (= `fn (car x)) (= `hashfn (car x)) (= `lambda (car x))
                     (= `partial (car x)))))

(lambda quoted? [x]
  "Check if `x` is a list that begins with `quote`."
  (and (list? x) (= `quote (car x))))

(lambda quoted->fn [expr]
  "Converts an expression like `(quote (+ 1 1))` into `(fn [] (+ 1 1))`."
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (. expr 2)]
    `(fn []
       ,non-quoted)))

(lambda quoted->str [expr]
  "Converts a quoted expression like `(quote (+ 1 1))` into an string with its shorthand form."
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (. expr 2)]
    (.. "'" (view non-quoted))))

(lambda expand-exprs [exprs]
  "Converts a list of expressions into either an expression - if only one
  expression is in the list - or a do-expression containing the expressions."
  (if (> (length exprs) 1)
      `(do
         ,(unpack exprs))
      (car exprs)))

(lambda gensym-checksum [x ?options]
  "Generates a new symbol from the checksum of the object passed as a parameter
  after it is casted into an string using the `view` function.
  You can also pass a prefix or a suffix into the options optional table.
  This function depends on the djb2 hash function."
  (let [options (or ?options {})
        prefix (or options.prefix "")
        suffix (or options.suffix "")]
    (sym (.. prefix (crypt.djb2 (view x)) suffix))))

(lambda vlua [x]
  "Return a symbol mapped to `v:lua.%s()` where `%s` is the symbol."
  (assert-compile (sym? x) "expected symbol for x" x)
  (string.format "v:lua.%s()" (->str x)))

(lambda colorscheme [scheme]
  "Set a colorscheme using the vim.api.nvim_cmd API.
  Accepts the following arguements:
  scheme -> a symbol.
  Example of use:
  ```fennel
  (colorscheme carbon)
  ```"
  (assert-compile (sym? scheme) "expected symbol for name" scheme)
  (let [scheme (->str scheme)]
    `(vim.api.nvim_cmd {:cmd :colorscheme :args [,scheme]} {})))

(lambda custom-set-face! [name attributes colors]
  "Sets a highlight group globally using the vim.api.nvim_set_hl API.
  Accepts the following arguments:
  name -> a string.
  attributes -> a list of boolean attributes:
    - bold
    - italic
    - reverse
    - inverse
    - standout
    - underline
    - underlineline
    - undercurl
    - underdot
    - underdash
    - strikethrough
    - default
  colors -> a table of colors:
    - fg
    - bg
    - ctermfg
    - ctermbg
  Example of use:
  ```fennel
  (custom-set-face! Error [:bold] {:fg \"#ff0000\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_set_hl 0 \"Error\" {:fg \"#ff0000\"
                                    :bold true})
  ```"
  (assert-compile (str? name) "expected string for name" name)
  (assert-compile (table? attributes) "expected table for attributes"
                  attributes)
  (assert-compile (table? colors) "expected colors for colors" colors)
  (let [definition (collect [_ attr (ipairs attributes) &into colors]
                     (->str attr)
                     true)]
    `(vim.api.nvim_set_hl 0 ,name ,definition)))

(lambda set! [name ?value]
  "Set a vim option using the vim.opt.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                  (quoted->fn value)
                  value)
        name (if (and (nil? ?value) (begins-with? :no name))
                 (name:match "^no(.+)$")
                 name)
        exprs (if (fn? value) [`(tset _G
                                      ,(->str (gensym-checksum value
                                                               {:prefix "__"}))
                                      ,value)] [])
        value (if (fn? value)
                  (vlua (gensym-checksum value {:prefix "__"}))
                  value)
        exprs (doto exprs
                (table.insert (match (name:sub -1)
                                "+" `(: (. vim.opt ,(name:sub 1 -2)) :append
                                        ,value)
                                "-" `(: (. vim.opt ,(name:sub 1 -2)) :remove
                                        ,value)
                                "^" `(: (. vim.opt ,(name:sub 1 -2)) :prepend
                                        ,value)
                                _ `(tset vim.opt ,name ,value))))]
    (expand-exprs exprs)))

(lambda local-set! [name ?value]
  "Set a vim option using the vim.opt_local.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                  (quoted->fn value)
                  value)
        name (if (and (nil? ?value) (begins-with? :no name))
                 (name:match "^no(.+)$")
                 name)
        exprs (if (fn? value) [`(tset _G
                                      ,(->str (gensym-checksum value
                                                               {:prefix "__"}))
                                      ,value)] [])
        value (if (fn? value)
                  (vlua (gensym-checksum value {:prefix "__"}))
                  value)
        exprs (doto exprs
                (table.insert (match (name:sub -1)
                                "+" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :append ,value)
                                "-" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :remove ,value)
                                "^" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :prepend ,value)
                                _ `(tset vim.opt_local ,name ,value))))]
    (expand-exprs exprs)))

(lambda shared-command! [api-function name command ?options]
  (assert-compile (sym? api-function) "expected symbol for api-function"
                  api-function)
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (or (str? command) (sym? command) (fn? command)
                      (quoted? command))
                  "expected string, symbol, function or quoted expression for command"
                  command)
  (assert-compile (or (nil? ?options) (table? ?options))
                  "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? command) (quoted->str command)
                                (str? command) command
                                (view command))))
                    options)
        command (if (quoted? command) (quoted->fn command) command)]
    `(,api-function ,name ,command ,options)))

(lambda command! [name command ?options]
  "Create a new user command using the vim.api.nvim_create_user_command API.

  Accepts the following arguments:
  name -> must be a symbol.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (command! Salute '(print \"Hello World\")
            {:bang true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_user_command \"Salute\" (fn [] (print \"Hello World\"))
                                    {:bang true
                                     :desc \"This is a description\"})
  ```"
  (shared-command! `vim.api.nvim_create_user_command name command ?options))

(lambda local-command! [name command ?options]
  "Create a new user command using the vim.api.nvim_buf_create_user_command API.

  Accepts the following arguments:
  name -> must be a symbol.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (local-command! Salute '(print \"Hello World\")
                  {:bang true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_buf_create_user_command \"Salute\" (fn [] (print \"Hello World\"))
                                        {:bang true
                                         :desc \"This is a description\"})
  ```"
  (shared-command! `vim.api.nvim_buf_create_user_command name command ?options))

(lambda autocmd! [event pattern command ?options]
  "Create an autocommand using the nvim_create_autocmd API.

  Accepts the following arguments:
  event -> can be either a symbol or a list of symbols.
  pattern -> can be either a symbol or a list of symbols. If it's <buffer> the
             buffer option is set to 0. If the buffer option is set this value
             is ignored.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (autocmd! VimEnter *.py '(print \"Hello World\")
            {:once true :group \"custom\" :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_autocmd :VimEnter
                               {:pattern \"*.py\"
                                :callback (fn [] (print \"Hello World\"))
                                :once true
                                :group \"custom\"
                                :desc \"This is a description\"})
  ```"
  (assert-compile (or (sym? event) (and (table? event) (all #(sym? $) event))
                      "expected symbol or list of symbols for event" event))
  (assert-compile (or (sym? pattern)
                      (and (table? pattern) (all #(sym? $) pattern))
                      "expected symbol or list of symbols for pattern" pattern))
  (assert-compile (or (str? command) (sym? command) (fn? command)
                      (quoted? command))
                  "expected string, symbol, function or quoted expression for command"
                  command)
  (assert-compile (or (nil? ?options) (table? ?options))
                  "expected table for options" ?options)
  (let [event (if (and (table? event) (not (sym? event)))
                  (icollect [_ v (ipairs event)]
                    (->str v))
                  (->str event))
        pattern (if (and (table? pattern) (not (sym? pattern)))
                    (icollect [_ v (ipairs pattern)]
                      (->str v))
                    (->str pattern))
        options (or ?options {})
        options (if (nil? options.buffer)
                    (if (= :<buffer> pattern)
                        (doto options
                          (tset :buffer 0))
                        (doto options
                          (tset :pattern pattern)))
                    options)
        options (if (str? command)
                    (doto options
                      (tset :command command))
                    (doto options
                      (tset :callback
                            (if (quoted? command)
                                (quoted->fn command)
                                command))))
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? command) (quoted->str command)
                                (str? command) command
                                (view command))))
                    options)]
    `(vim.api.nvim_create_autocmd ,event ,options)))

(lambda augroup! [name ...]
  "Create an augroup using the nvim_create_augroup API.
  Accepts either a name or a name and a list of autocmd statements.

  Example of use:
  ```fennel
  (augroup! a-nice-group
    (autocmd! Filetype *.py '(print \"Hello World\"))
    (autocmd! Filetype *.sh '(print \"Hello World\")))
  ```
  That compiles to:
  ```fennel
  (do
    (vim.api.nvim_create_augroup \"a-nice-group\" {:clear false})
    (autocmd! Filetype *.py '(print \"Hello World\") {:group \"a-nice-group\"})
    (autocmd! Filetype *.sh '(print \"Hello World\") {:group \"a-nice-group\"}))
  ```"
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (assert-compile (all #(and (list? $)
                             (or (= `clear! (car $)) (= `autocmd! (car $))))
                       [...])
                  "expected autocmd exprs for body" ...)
  (expand-exprs (let [name (->str name)]
                  (icollect [_ expr (ipairs [...])
                             &into [`(vim.api.nvim_create_augroup ,name
                                                                  {:clear false})]]
                    (if (= `autocmd! (car expr))
                        (let [[_ event pattern command ?options] expr
                              options (or ?options {})
                              options (doto options
                                        (tset :group name))]
                          `(autocmd! ,event ,pattern ,command ,options))
                        (let [[_ ?options] expr]
                          `(clear! ,name ,?options)))))))

(lambda clear! [name ?options]
  "Clears an augroup using the nvim_clear_autocmds API.

  Example of use:
  ```fennel
  (clear! some-group)
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_clear_autocmds {:group \"some-group\"})
  ```"
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (assert-compile (or (nil? ?options) (table? ?options))
                  "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (doto options
                  (tset :group name))]
    `(vim.api.nvim_clear_autocmds ,options)))

(lambda lazy [identifier ?options]
  "A workaround around the lack of mixed tables in Fennel.
  Has special `options` keys for enhanced utility.
  See `:help core.lazy.pack` for information about how to use it."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (table? ?options))
                  "expected table for options" ?options)
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (match k
                    :require* (values :config `#(require ,v))
                    _ (values k v)))]
    (doto options (tset 1 identifier))))

(lambda if-loaded! [mod value]
  (assert-compile (str? mod) "expected string for module name" mod)
  (if (. _G.pack mod)
      `,value))

(lambda map! [[modes] lhs rhs ?options]
  "Add a new mapping using the vim.keymap.set API.

  Accepts the following arguments:
  modes -> is a sequence containing a symbol, each character of the symbol is
           a mode.
  lhs -> must be an string.
  rhs -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (map! [nv] \"<leader>lr\" vim.lsp.references
        {:silent true :buffer 0 :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.keymap.set [:n :v] \"<leader>lr\" vim.lsp.references
                  {:silent true
                   :buffer 0
                   :desc \"This is a description\"})
  ```"
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (sym? rhs) (fn? rhs) (quoted? rhs))
                  "expected string, symbol, function or quoted expression for rhs"
                  rhs)
  (assert-compile (or (nil? ?options) (table? ?options))
                  "expected table for options" ?options)
  (let [modes (icollect [char (string.gmatch (->str modes) ".")]
                char)
        options (or ?options {})
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? rhs) (quoted->str rhs)
                                (str? rhs) rhs
                                (view rhs))))
                    options)
        rhs (if (quoted? rhs) (quoted->fn rhs) rhs)]
    `(vim.keymap.set ,modes ,lhs ,rhs ,options)))

(lambda buf-map! [[modes] lhs rhs ?options]
  "Add a new mapping using the vim.keymap.set API.
  Sets by default the buffer option.

  Accepts the following arguments:
  modes -> is a sequence containing a symbol, each character of the symbol is
           a mode.
  lhs -> must be an string.
  rhs -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (map! [nv] \"<leader>lr\" vim.lsp.references
        {:silent true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.keymap.set [:n :v] \"<leader>lr\" vim.lsp.references
                  {:silent true
                   :buffer 0
                   :desc \"This is a description\"})
  ```"
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (sym? rhs) (fn? rhs) (quoted? rhs))
                  "expected string, symbol, function or quoted expression for rhs"
                  rhs)
  (assert-compile (or (nil? ?options) (table? ?options))
                  "expected table for options" ?options)
  (let [options (or ?options {})
        options (doto options
                  (tset :buffer 0))]
    (map! [modes] lhs rhs options)))

(lambda let-with-scope! [[scope] name value]
  (assert-compile (or (str? scope) (sym? scope))
                  "expected string or symbol for scope" scope)
  (assert-compile (or (= :b (->str scope)) (= :w (->str scope))
                      (= :t (->str scope)) (= :g (->str scope)))
                  "expected scope to be either b, w, t or g" scope)
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)
        scope (->str scope)]
    `(tset ,(match scope
              :b `vim.b
              :w `vim.w
              :t `vim.t
              :g `vim.g) ,name ,value)))

(lambda let-global! [name value]
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)]
    `(tset vim.g ,name ,value)))

(lambda let! [...]
  "Set a vim variable using the vim.<scope>.name API.
  Accepts the following arguments:
  [scope] -> optional. Can be either [g], [w], [t] or [b]. It's either a symbol
             or a string surrounded by square brackets.
  name -> either a symbol or a string.
  value -> anything.
  Example of use:
  ```fennel
  (let! hello :world)
  (let! [w] hello :world)
  ```
  That compiles to:
  ```fennel
  (tset vim.g :hello :world)
  (tset vim.w :hello :world)
  ```"
  (match [...]
    [[scope] name value] (let-with-scope! [scope] name value)
    [name value] (let-global! name value)
    _ (error "expected let! to have at least two arguments: name value")))

(lambda verify-dependencies! [dependencies]
  "Uses the vim.notify API to print a warning for every dependecy that is no
   available and then executes an early return from the module."
  `(let [dependencies# ,dependencies
         info# (debug.getinfo 1 :S)
         module-name# info#.source
         module-name# (module-name#:match "@(.*)")
         not-available# (icollect [_# dependency# (ipairs dependencies#)]
                          (when (not (pcall require dependency#))
                            dependency#))]
     (when (> (length not-available#) 0)
       (each [_# dependency# (ipairs not-available#)]
         (vim.notify (string.format "Could not load '%s' as '%s' is not available."
                                    module-name# dependency#)
                     vim.log.levels.WARN))
       (lua "return nil"))))

(lambda sh [...]
  "simple macro to run shell commands inside fennel"
  `(let [str# ,(accumulate [str# "" _ v# (ipairs [...])]
                 (if (in-scope? v#) `(.. ,str# " " ,v#)
                     (or (list? v#) (sym? v#)) (.. str# " " (tostring v#))
                     (= (type v#) :string) (.. str# " " (string.format "%q" v#))))
         fd# (io.popen str#)
         d# (fd#:read :*a)]
     (fd#:close)
     (string.sub d# 1 (- (length d#) 1))))

{: expr->str
 : extend-fn
 : vlua
 : colorscheme
 : sh
 : custom-set-face!
 : set!
 : local-set!
 : map!
 : buf-map!
 : let!
 : command!
 : local-command!
 : autocmd!
 : augroup!
 : clear!
 : lazy
 : if-loaded!}
