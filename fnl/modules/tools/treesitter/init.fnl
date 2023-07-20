(import-macros {: lazy} :macros)

(local treesitter-filetypes [:bash
                             :c
                             :c_sharp
                             :clojure
                             :commonlisp
                             :cpp
                             :fennel
                             :fish
                             :git_rebase
                             :gitattributes
                             :gitcommit
                             :http
                             :java
                             :json
                             :kotlin
                             :latex
                             :lua
                             :markdown
                             :markdown_inline
                             :python
                             :query
                             :racket
                             :regex
                             :rust
                             :scala
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
       :event :UIEnter
       ;:cmd [:TSInstall
       ;      :TSUpdate
       ;      :TSInstallSync
       ;      :TSUpdateSync
       ;      :TSBufEnable
       ;      :TSBufDisable
       ;      :TSEnable
       ;      :TSDisable
       ;      :TSModuleInfo]
       ;:depends [(lazy :nvim-treesitter/playground {:cmd :TSPlayground})
       :depends [(lazy :HiPhish/nvim-ts-rainbow2 {:lazy true})
                 (lazy :JoosepAlviste/nvim-ts-context-commentstring
                       {:lazy true})
                 (lazy :nvim-treesitter/nvim-treesitter-refactor {:lay true})
                 (lazy :nvim-treesitter/nvim-treesitter-textobjects
                       {:lazy true})]
       :config configure-treesitter})
