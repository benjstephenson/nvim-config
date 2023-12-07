(import-macros {: lazy } :macros)

(lazy :nvim-lua/telescope.nvim
      {:dependencies [(lazy :nvim-telescope/telescope-fzf-native.nvim
                           {:lazy true :run :make})
                      (lazy :nvim-telescope/telescope-ui-select.nvim
                            {:lazy true})
                      (lazy :nvim-telescope/telescope-project.nvim)
                      (lazy :nvim-telescope/telescope-file-browser.nvim
                            {:lazy true})]})
