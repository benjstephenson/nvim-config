(import-macros {: lazy : map!} :macros)

(fn register-keymaps! []
  (let [{:lsp_implementations open-impl-float!
         :lsp_references open-ref-float!
         :lsp_document_symbols open-local-symbol-float!
         :current_buffer_fuzzy_find fuzzy-find-float!
         :diagnostics open-diag-float!
         :lsp_workspace_symbols open-workspace-symbol-float!} (require :telescope.builtin)
        themes (require :telescope.themes)]
    (do
      (map! [n] :<leader>ci open-impl-float! {:desc "LSP Find implementations"})
      (map! [n] :<leader>cD #(open-ref-float! (themes.get_ivy))
            {:desc "LSP Jump to references"})
      (map! [n] :<leader>cs open-local-symbol-float!
            {:desc "LSP Jump to symbol in file"})
      (map! [n] :<leader>cS open-workspace-symbol-float!
            {:desc "LSP Jump to symbol in workspace"})
      (map! [n] :<leader>* #(fuzzy-find-float! (themes.get_ivy)) {:desc :Swoop})
      (map! [n] :<leader>cx `(open-diag-float! {:bufnr 0})
            {:desc "Local diagnostics"})
      (map! [n] :<leader>cX open-diag-float! {:desc "Project diagnostics"}))))

(fn telescope-setup []
  (local telescope (require :telescope))
  (local themes (require :telescope.themes))
  (telescope.setup {:defaults {:prompt_prefix "   "
                               :selection_caret "  "
                               :entry_prefix "  "
                               :sorting_strategy :ascending
                               :layout_strategy :flex
                               :layout_config {:horizontal {:prompt_position :top}}
                               :set_env {:COLORTERM :truecolor}
                               :dynamic_preview_title :layout_config
                               {:height 0.8
                                 :horizontal {:preview_width 0.55
                                              :prompt_position :top}
                                 :preview_cutoff 120
                                 :vertical {:mirror false}
                                 :width 0.87} true}
                    :pickers {:oldfiles {:prompt_title "Recent files"}}
                    :extensions {:ui-select [themes.get_dropdown]}})
  (telescope.load_extension :ui-select)
  (telescope.load_extension :file_browser)
  (telescope.load_extension :smart_history) ;  (telescope.load_extension :notify)
  ;(telescope.load_extension :projects)
  (local extensions (. (require :telescope) :extensions))
  (register-keymaps!))

(lazy :nvim-lua/telescope.nvim
      {:config telescope-setup
       :dependencies [(lazy :nvim-telescope/telescope-fzf-native.nvim
                            {:lazy true :run :make})
                      (lazy :nvim-telescope/telescope-ui-select.nvim
                            {:lazy true})
                      (lazy :nvim-telescope/telescope-file-browser.nvim
                            {:lazy true})
                      (lazy :nvim-telescope/telescope-media-files.nvim
                            {:lazy true})
                      (lazy :nvim-telescope/telescope-project.nvim)
                      (lazy :nvim-telescope/telescope-smart-history.nvim
                            {:dependencies :tami5/sqlite.lua})
                      (lazy :LukasPietzschmann/telescope-tabs {:lazy true})
                      (lazy :jvgrootveld/telescope-zoxide {:lazy true})]})
