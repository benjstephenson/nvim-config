(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (local treesitter (require :nvim-treesitter.configs))
  (treesitter.setup {:ensure_installed [:c_sharp
                                        :haskell
                                        :jsonc
                                        :lua
                                        :python
                                        :rust
                                        :scala
                                        :typescript
                                        :vim]
                     :highlight {:enable true}
                     :context_commentstring {:enable true}
                     :indent {:enable true}
                     ; :yati {:enable true}
                     :refactor {:smart_rename {:enable true
                                               :keymaps {:smart_rename :<localleader>rn}}}
                     :playground {:enable true}
                     :textobjects {:lsp_interop {:enable true
                                                 :border :none
                                                 :floating_preview_opts {}
                                                 :peek_definition_code {:<localleader>df "@function.outer"
                                                                        :<localleader>dF "@class.outer"}}}
                     :query_linter {:enable true
                                    :use_virtual_text true
                                    :lint_events [:BufWrite :CursorHold]}
                     :swap {:enable true
                            :swap_next {:<localleader>sa "@parameter.inner"}
                            :swap_previous {:<localleader>sA "@parameter.inner"}}
                     :select {:enable true
                              :lookahead true
                              :keymaps {:af "@function.outer"
                                        :if "@function.inner"
                                        :ac "@class.outer"
                                        :ic "@class.inner"
                                        :as "@scope"}}
                     :move {:enable true
                            :set_jumps true
                            :goto_next_start {"]m" "@function.outer"
                                              "]]" {:query "@class.outer"
                                                    :desc "Next class start"}
                                              "]o" "@loop.*"
                                              "]s" {:query "@scope"
                                                    :query_group :locals
                                                    :desc "Next scope"}
                                              "]z" {:query "@fold"
                                                    :query_group :locals
                                                    :desc "Next fold"}}
                            :goto_next_end {"]M" "@function.outer"}
                            :goto_previous_start {"[m" "@function.outer"
                                                  "[[" "@class.outer"}
                            :goto_previous_end {"[M" "@function.outer"
                                                "[]" "@class.outer"}
                            :goto_next {"]d" "@conditional.outer"}
                            :goto_previous {"[d" "@conditional.outer"}}}))

(pack :nvim-treesitter/nvim-treesitter
      {:build ":TSUpdate"
       :dependencies [:JoosepAlviste/nvim-ts-context-commentstring
                      ; "yioneko/nvim-yati"
                      :nvim-treesitter/nvim-treesitter-refactor
                      :nvim-treesitter/playground
                      :nvim-treesitter/nvim-treesitter-textobjects]
       : config})
