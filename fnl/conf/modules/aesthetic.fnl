(import-macros {: pack} :themis.pack.lazy)

[;; Better UI
 :stevearc/dressing.nvim
 ;; Better notifications
 (pack :rcarriga/nvim-notify {:config #(set vim.notify (require :notify))})
 ;; Preview substitution
 ; (pack :markonm/traces.vim
 ;       {:config #(do
 ;                   (import-macros {: let!} :themis.var)
 ;                   (let! traces_abolish_integration 1))})
 ;; Highlight color-codes
 ; (pack :NvChad/nvim-colorizer.lua
 ;       {:config {:user_default_options {:mode :virtualtext :names false}}})
 ;; Indent lines
 (pack :lukas-reineke/indent-blankline.nvim
       {:config {:char "▏"
                 :filetype_exclude [:terminal
                                    :help
                                    :NvimTree
                                    :markdown
                                    :text
                                    :TelescopePrompt
                                    :TelescopeResults
                                    (unpack conf.lisp-filetypes)]
                 :buftype_exclude [:terminal :nofile]}})
 (pack :echasnovski/mini.indentscope
       {:config #((. (require :mini.indentscope) :setup) {:draw {:delay 50}})})]
