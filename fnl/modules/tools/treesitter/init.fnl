(import-macros {: lazy} :macros)

(local treesitter-filetypes [:bash
                             :c_sharp
                             :clojure
                             :commonlisp
                             :fennel
                             :fish
                             :git_rebase
                             :gitattributes
                             :gitcommit
                             :haskell
                             :http
                             :javascript
                             :json
                             :kotlin
                             :lua
                             :markdown
                             :markdown_inline
                             :php
                             :python
                             :query
                             :regex
                             :rust
                             :scala
                             :typescript
                             :toml
                             :vim
                             :vimdoc])

(fn configure-treesitter []
  (local treesitter (require :nvim-treesitter.configs))
  (treesitter.setup {:ensure_installed treesitter-filetypes
                     :highlight {:enable true :use_languagetree true}
                     :indent {:enable true}
                     :context_commentstring {:enable true}
                     :refactor {:enable true
                                :keymaps {:smart_rename :<localleader>rn}}
                     :query_linter {:enable true
                                    :use_virtual_text true
                                    :lint_events [:BufWrite :CursorHold]}
                     :rainbow {:enable true
                               :query {1 :rainbow-parens
                                       :html :rainbow-tags
                                       :latex :rainbow-blocks
                                       :tsx :rainbow-tags
                                       :vue :rainbow-tags}}
                     :incremental_selection {:enable true
                                             :keymaps {:init_selection :gnn
                                                       :node_incremental :grn
                                                       :scope_incremental :grc
                                                       :node_decremental :grm}}
                     :textobjects {:select {:enable true}
                                   :lookahead true
                                   :keymaps {:af "@function.outer"
                                             :if "@function.inner"
                                             :ac "@class.outer"
                                             :ic "@class.inner"}
                                   :swap {:enable true
                                          :swap_next {:<localleader>sp "@parameter.inner"
                                                      :<localleader>sf "@function.outer"
                                                      :<localleader>sc "@class.outer"}
                                          :swap_previous {:<localleader>sP "@parameter.inner"
                                                          :<localleader>sF "@function.outer"
                                                          :<localleader>sC "@class.outer"}}
                                   :move {:enable true
                                          :set_jumps true
                                          :goto_next_start {"]m" "@function.outer"
                                                            "]]" "@class.outer"}
                                          :goto_next_end {"]M" "@function.outer"
                                                          "][" "@class.outer"}
                                          :goto_previous_start {"[m" "@function.outer"
                                                                "[[" "@class.outer"}
                                          :goto_previous_end {"[M" "@function.outer"
                                                              "[]" "@class.outer"}}}}))

(lazy :nvim-treesitter/nvim-treesitter
      {:build ":TSUpdate"
       :depends [(lazy :JoosepAlviste/nvim-ts-context-commentstring)
                 (lazy :nvim-treesitter/nvim-treesitter-refactor)
                 (lazy :nvim-treesitter/nvim-treesitter-textobjects)]
       :config configure-treesitter})
