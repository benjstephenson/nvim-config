(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (local treesitter (require :nvim-treesitter.configs))
  (treesitter.setup {:ensure_installed [:c_sharp
                                        :haskell
                                        :http
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
                                                 :peek_definition_code {:<localleader>pp "@parameter.outer"
                                                                        :<localleader>pf "@function.outer"
                                                                        :<localleader>pc "@class.outer"}}
                                   :swap {:enable true
                                          :swap_next {:<localleader>sp "@parameter.inner"
                                                      :<localleader>sf "@function.outer"
                                                      :<localleader>sc "@class.outer"}
                                          :swap_previous {:<localleader>sP "@parameter.inner"
                                                          :<localleader>sF "@function.outer"
                                                          :<localleader>sC "@class.outer"}}
                                   :move {:enable true
                                          :set_jumps true
                                          :goto_next_start {"]f" "@function.outer"
                                                            "]c" {:query "@class.outer"
                                                                  :desc "Next class start"}
                                                            "]o" "@loop.*"
                                                            "]s" {:query "@scope"
                                                                  :query_group :locals
                                                                  :desc "Next scope"}
                                                            "]z" {:query "@fold"
                                                                  :query_group :locals
                                                                  :desc "Next fold"}}
                                          :goto_next_end {"]F" "@function.outer"
                                                          "]C" "@class.outer"}
                                          :goto_previous_start {"[f" "@function.outer"
                                                                "[c" "@class.outer"}
                                          :goto_previous_end {"[F" "@function.outer"
                                                              "[C" "@class.outer"}
                                          :goto_next {"]i" "@conditional.outer"}
                                          :goto_previous {"[i" "@conditional.outer"}}
                                   :select {:enable true
                                            :lookahead true
                                            :keymaps {:af "@function.outer"
                                                      :if "@function.inner"
                                                      :ap "@parameter.outer"
                                                      :ip "@paramter.inner"
                                                      :ac "@class.outer"
                                                      :ic "@class.inner"
                                                      :as "@scope"}}}
                     :query_linter {:enable true
                                    :use_virtual_text true
                                    :lint_events [:BufWrite :CursorHold]}}))

(pack :nvim-treesitter/nvim-treesitter
      {:build ":TSUpdate"
       :dependencies [:JoosepAlviste/nvim-ts-context-commentstring
                      ; "yioneko/nvim-yati"
                      :nvim-treesitter/nvim-treesitter-refactor
                      :nvim-treesitter/playground
                      :nvim-treesitter/nvim-treesitter-textobjects]
       : config})
