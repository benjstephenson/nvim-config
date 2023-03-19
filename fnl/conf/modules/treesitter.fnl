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
                     :query_linter {:enable true
                                    :use_virtual_text true
                                    :lint_events [:BufWrite :CursorHold]}}))

(pack :nvim-treesitter/nvim-treesitter
      {:build ":TSUpdate"
       :dependencies [:JoosepAlviste/nvim-ts-context-commentstring
                      ; "yioneko/nvim-yati"
                      :nvim-treesitter/nvim-treesitter-refactor
                      :nvim-treesitter/playground
                      :nvim-treesitter/nvim-treesitter-textobjects
                      {:config true}]
       : config})
