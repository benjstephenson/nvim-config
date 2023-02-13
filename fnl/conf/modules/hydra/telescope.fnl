(local Hydra (require :hydra))

(do
  (local telescope-hint "
           _o_: old files   _g_: live grep
           _p_: projects    _/_: search in file
           _r_: resume      _f_: find files
   ▁
           _h_: vim help    _c_: execute command
           _k_: keymaps     _;_: commands history  
           _O_: options     _?_: search history
  ^
  _<Esc>_         _<Enter>_: NvimTree
    ")
  (Hydra {:name :+file
          :hint telescope-hint
          :config {:color :teal
                   :invoke_on_body true
                   :hint {:position :middle :border :solid}}
          :mode :n
          :body :<leader>tt
          :heads [[:f
                   (fn []
                     (vim.cmd.Telescope :find_files))]
                  [:g
                   (fn []
                     (vim.cmd.Telescope :live_grep))]
                  [:o
                   (fn []
                     (vim.cmd.Telescope :oldfiles))
                   {:desc "recently opened files"}]
                  [:h
                   (fn []
                     (vim.cmd.Telescope :help_tags))
                   {:desc "vim help"}]
                  [:k
                   (fn []
                     (vim.cmd.Telescope :keymaps))]
                  [:O
                   (fn []
                     (vim.cmd.Telescope :vim_options))]
                  [:r
                   (fn []
                     (vim.cmd.Telescope :resume))]
                  [:p
                   (fn []
                     ((. (. (. (require :telescope) :extensions) :project)
                         :project) {:display_type :full}))
                   {:desc :projects}]
                  ["/"
                   (fn []
                     (vim.cmd.Telescope :current_buffer_fuzzy_find))
                   {:desc "search in file"}]
                  ["?"
                   (fn []
                     (vim.cmd.Telescope :search_history))
                   {:desc "search history"}]
                  [";"
                   (fn []
                     (vim.cmd.Telescope :command_history))
                   {:desc "command-line history"}]
                  [:c
                   (fn []
                     (vim.cmd.Telescope :commands))
                   {:desc "execute command"}]
                  [:<Enter>
                   (fn []
                     (vim.cmd :NvimTreeToggle))
                   {:exit true :desc :NvimTree}]
                  [:<Esc> nil {:exit true :nowait true}]]}))
