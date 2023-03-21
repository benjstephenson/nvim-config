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
  ;;; ==========
  (telescope.load_extension :fzf)
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
    (map! [n] :<leader>fk builtin.loclist)))

(fn fern-config []
  ;;; ========
  ;;; Keybinds
  ;;; ========
  (import-macros {: map!} :themis.keybind)
  (map! [n] :<C-n> "<cmd>Fern . -reveal=% -drawer -toggle<cr>")
  ;;; =============
  ;;; Configuration
  ;;; =============
  (import-macros {: let!} :themis.var)
  (local fr-web-icons (require :fr-web-icons))
  (let! fern#renderer :nvim-web-devicons)
  (let! glyph_palette#palette (fr-web-icons.palette))
  ;;; ======
  ;;; Events
  ;;; ======
  (import-macros {: augroup! : clear! : autocmd!} :themis.event)
  (augroup! add-colors-to-fern-buffer (clear!)
            (autocmd! FileType fern `(vim.fn.glyph_palette#apply))))

[;; Fuzzy-finding
 (pack :nvim-telescope/telescope.nvim
       {:dependencies [:nvim-lua/plenary.nvim
                       (pack :nvim-telescope/telescope-ui-select.nvim)
                       (pack :nvim-telescope/telescope-file-browser.nvim)
                       (pack :nvim-telescope/telescope-project.nvim)
                       (pack :nvim-telescope/telescope-fzf-native.nvim
                             {:build :make})
                       (pack :nvim-telescope/telescope-smart-history.nvim
                             {:dependencies :tami5/sqlite.lua})]
        :config telescope-config})]

;; File-tree
; (pack :lambdalisue/fern.vim {:dependencies [:lambdalisue/fern-git-status.vim
;                                             :lambdalisue/fern-renderer-nerdfont.vim
;                                             :TheLeoP/fern-renderer-web-devicons.nvim
;                                             :lambdalisue/glyph-palette.vim]
;                              :config fern-config})]
