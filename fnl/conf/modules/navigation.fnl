(import-macros {: pack} :themis.pack.lazy)

(fn telescope-file-browser-config []
  {:theme :ivy :hijack_netrw true})

(fn telescope-config []
  (import-macros {: map!} :themis.keybind)
  (local telescope (require :telescope))
  (local themes (require :telescope.themes))
  (local builtin (require :telescope.builtin))
  (local actions (require :telescope.actions))
  (local keybinds {:<C-h> actions.which_key
                   :<ESC> actions.close
                   :<C-q> actions.smart_send_to_qflist
                   :<C-k> actions.smart_send_to_loclist
                   :<C-Up> actions.cycle_history_prev
                   :<C-Down> actions.cycle_history_next})
  ;; default to git_files, but if no .git dir exists, then fall back to find_files

  (fn find-project-files [])

  ;;; =============
  ;;; Configuration
  ;;; =============
  (local history-database
         (.. conf.databases-folder :/telescope_history.sqlite3))
  (telescope.setup {:defaults {:mappings {:i keybinds}
                               :history {:path history-database :limit 100}
                               :prompt_prefix "   "
                               :selection_caret "  "
                               :layout_strategy :flex
                               :layout_config {:horizontal {:prompt_position :top
                                                            :preview_width 0.55}
                                               :vertical {:mirror false}
                                               :width 0.87
                                               :height 0.8
                                               :preview_cutoff 120}
                               :sorting_strategy :ascending}
                    :extensions {:file_browser (telescope-file-browser-config)
                                 :project {:hidden_files true
                                           :sync_with_nvim_tree true}
                                 :ui-select [themes.get_dropdown]}})
  ;;; ==========
  ;;; Extensions
  ;;; ========== ; (telescope.load_extension :fzf)
  (telescope.load_extension :ui-select)
  (telescope.load_extension :file_browser)
  (telescope.load_extension :smart_history)
  (telescope.load_extension :notify)
  (telescope.load_extension :project)
  (local extensions (. (require :telescope) :extensions))
  ;;; ========
  ;;; Mappings
  ;;; ========
  (do
    (map! [n] :<leader>fb extensions.file_browser.file_browser {:desc :browser})
    (map! [n] :<leader>ff builtin.find_files {:desc :find})
    (map! [n] :<leader>fF #(builtin.find_files {:hidden true})
          {:desc "find all files"})
    (map! [n] :<leader>fg builtin.live_grep {:desc "live grep"})
    (map! [n] :<leader>bb builtin.buffers {:desc :buffers})
    (map! [n] :<leader>sh builtin.help_tags {:desc "help tags"})
    (map! [n] :<leader>fq builtin.quickfix)
    (map! [n] :<leader>fk builtin.loclist)
    (map! [n] :<leader>sc builtin.colorscheme {:desc :colourscheme})
    (map! [n] :<leader>sb
          #(builtin.current_buffer_fuzzy_find {:theme :get_ivy})
          {:desc "search in buffer"})
    (map! [n] :<leader>sh builtin.help_tags {:desc "find Help"})
    (map! [n] :<leader>sM builtin.man_pages {:desc "man Pages"})
    (map! [n] :<leader>sr builtin.oldfiles {:desc "open Recent File"})
    (map! [n] :<leader>sR builtin.registers {:desc :registers})
    (map! [n] :<leader>st builtin.live_grep {:desc :text})
    (map! [n] :<leader>sk builtin.keymaps {:desc :keymaps})
    (map! [n] :<leader>sC builtin.commands {:desc :commands})
    (map! [n] :<leader>sp #(builtin.colorscheme {:enable_preview true})
          {:desc "colorscheme with preview"})
    ;; Git
    (map! [n] :<leader>gC builtin.git_bcommits
          {:desc "checkout commit(for current file)"})
    (map! [n] :<leader>gb builtin.git_branches {:desc "checkout branch"})
    (map! [n] :<leader>gc builtin.git_commits {:desc "checkout commit"})
    (map! [n] :<leader>go builtin.git_status {:desc "open changed file"})))

(pack :nvim-telescope/telescope.nvim
      {:dependencies [:nvim-lua/plenary.nvim
                      (pack :nvim-telescope/telescope-ui-select.nvim)
                      (pack :nvim-telescope/telescope-file-browser.nvim)
                      (pack :nvim-telescope/telescope-project.nvim)
                      (pack :nvim-telescope/telescope-fzf-native.nvim
                            {:build :make})
                      (pack :nvim-telescope/telescope-smart-history.nvim
                            {:dependencies :tami5/sqlite.lua})]
       :config telescope-config})
