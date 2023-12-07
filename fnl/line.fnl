(import-macros {: set! : vlua } :macros)
(local {: kind-icons} (require :constants))

(local modes {:n :RW
              :no :RO
              :v "**"
              :V "**"
              "\022" "**"
              :s :S
              :S :SL
              "\019" :SB
              :i "**"
              :ic "**"
              :R :RA
              :Rv :RV
              :c :VIEX
              :cv :VIEX
              :ce :EX
              :r :r
              :rm :r
              :r? :r
              :! "!"
              :t ""})

(fn get-filetype [filename]
  (local devicons (require :nvim-web-devicons))
  (var icon (devicons.get_icon filename (vim.fn.expand "%:e")))
  (when (not icon) (set icon ""))
  (.. "%#NormalNC#" icon " " vim.bo.filetype))

(fn get-bufnr []
  (.. " %#Comment#" (vim.api.nvim_get_current_buf)))

(fn color []
  (let [mode (. (vim.api.nvim_get_mode) :mode)]
    (var mode-color "%#Normal#")
    (if (= mode :n) (set mode-color "%#StatusNormal#")
        (or (= mode :i) (= mode :ic)) (set mode-color "%#StatusInsert#")
        (= mode :v) (set mode-color "%#StatusReplace#")
        (= mode :c) (set mode-color "%#StatusCommand#")
        (= mode :t) (set mode-color "%#StatusTerminal#"))
    mode-color))

(fn get-filename []
  (var filename (or (and (= (vim.fn.expand "%") "") "") (vim.fn.expand "%:t")))
  (set filename (.. " " filename))
  (.. "%#Normal#" filename "%#NormalNC#"))

(fn get-git-status []
  (let [branch (or vim.b.gitsigns_status_dict {:head ""})
        is-head-empty (not= branch.head "")]
    (or (and is-head-empty
             (string.format (.. " %%#Normal#(" kind-icons.Branch
                                " • #%s)")
                            (or branch.head ""))) "")))

(fn get-lsp-diagnostic []
  (when (not (rawget vim :lsp))
    (lua "return \"\""))

  (fn get-severity [s]
    (length (vim.diagnostic.get 0 {:severity s})))

  (local result
         {:errors (get-severity vim.diagnostic.severity.ERROR)
          :warnings (get-severity vim.diagnostic.severity.WARN)
          :info (get-severity vim.diagnostic.severity.INFO)
          :hints (get-severity vim.diagnostic.severity.HINT)})
  (string.format " %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s "
                 (or (. result :warnings) 0) (or (. result :errors) 0)))

(fn lsp-status []
  (fn filter-null-ls [iter]
    (icollect [_ v (ipairs iter)]
      (if (not= v :null-ls) v)))

  (fn render [names]
    (if (= (length names) 0) " Server Inactive "
        (.. "  " (table.concat names ", ") " ")))

  (->> (icollect [_ client (pairs (vim.lsp.buf_get_clients))]
         client.name)
       (filter-null-ls) ; (fun.filter #(not= $1 :null-ls))
       (render)
       (.. "%#Normal#")))

; (fn get-navic-loc []
;   (let [(ok? navic) (pcall require :nvim-navic)]
;     (if ok?
;         (navic.get_location) "")))

(fn get-scroll-pos []
  (let [cur (vim.fn.line ".")
        total (vim.fn.line "$")]
    (->> (if (= cur 1)
             :Top
             (= cur total)
             :Bot
             (.. (string.format "%2d%%%%" (math.floor (* (/ cur total) 100)))
                 " "))
         (.. " %#Comment#"))))

(fn get-searchcount []
  (when (= vim.v.hlsearch 0)
    (lua "return \"%#Normal# %l:%c \""))
  (local (ok count) (pcall vim.fn.searchcount {:recompute true}))
  (when (or (or (not ok) (= count.current nil)) (= count.total 0))
    (lua "return \"\""))
  (when (= count.incomplete 1)
    (lua "return \"?/?\""))
  (local too-many (: ">%d" :format count.maxcount))
  (local total (or (and (> count.total count.maxcount) too-many) count.total))
  (.. "%#Normal#" (: " %s matches " :format total)))

(global Statusline {})
(set Statusline.statusline
     (fn []
       (local file-name (get-filename))
       (table.concat [(color)
                      (: (string.format " %s "
                                        (. modes
                                           (. (vim.api.nvim_get_mode) :mode)))
                         :upper)
                      file-name
                      (get-bufnr)
                      (get-git-status)
                      ; (get-navic-loc)
                      ; right-align the rest
                      "%="
                      (get-lsp-diagnostic)
                      (lsp-status)
                      (get-filetype file-name)
                      (get-scroll-pos)
                      (get-searchcount)])))

(set! laststatus 3)
(set! cmdheight 0)
(set! statusline (.. "%!" (vlua Statusline.statusline)))
