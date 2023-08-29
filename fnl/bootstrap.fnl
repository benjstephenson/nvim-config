(import-macros {: let! : set! : lazy} :macros)
(local stdlib (require :core.lib))

(local modules {:completion [:cmp :telescope]
                :config [:bindings :whichkey]
                :diagnostics [:null-ls :trouble]
                :editor [:folding :hotpot :parinfer]
                :lang [:lisp :markdown :plantuml :typescript :scala :haskell]
                :tools [:lsp :mason :git :treesitter :test :http ]
                :ui [:colourscheme
                     :dashboard
                     :gutter
                     :indent-guides
                     :line
                     :noice
                     :tabs
                     :quickfix]})

(fn disable-vim-plugins []
  (local default-plugins [:2html_plugin
                          :bugreport
                          :compiler
                          :ftplugin
                          :getscript
                          :getscriptPlugin
                          :gzip
                          :logipat
                          :matchit
                          :netrw
                          :netrwFileHandlers
                          :netrwPlugin
                          :netrwSettings
                          :optwin
                          :rplugin
                          :rrhelper
                          :spellfile_plugin
                          :synmenu
                          :syntax
                          :tar
                          :tarPlugin
                          :tutor
                          :vimball
                          :vimballPlugin
                          :zip
                          :zipPlugin])
  (local default-providers [:node :perl :ruby])
  (each [_ plugin (pairs default-plugins)] (tset vim.g (.. :loaded_ plugin) 1))
  (each [_ provider (ipairs default-providers)]
    (tset vim.g (.. :loaded_ provider :_provider) 0)))

(fn pre-setup []
  (disable-vim-plugins)
  (each [name fun (pairs stdlib)]
    (tset _G name fun)))

(fn post-setup []
  ;; add python provider and mason binaries
  (set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))
  (set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :config) :/bin))
  (let! python3_host_prog
        (if (stdlib.executable? :python) (vim.fn.exepath :python)
            (stdlib.executable? :python3) (vim.fn.exepath :python3)
            nil))
  (require :settings)
  (require :events))

{: modules : pre-setup : post-setup}
