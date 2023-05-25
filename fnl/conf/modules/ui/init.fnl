(import-macros {: pack} :themis.pack.lazy)

[(require :conf.modules.ui.colourscheme)
 (require :conf.modules.ui.lualine)
 (require :conf.modules.ui.bufferline)
 (require :conf.modules.ui.windows)
 (require :conf.modules.ui.quickfix)
 (require :conf.modules.ui.noice)
 ;; Better UI
 :stevearc/dressing.nvim
 ;; Better notifications
 (pack :rcarriga/nvim-notify {:config #(set vim.notify (require :notify))})
 ;; Indent lines
 (pack :lukas-reineke/indent-blankline.nvim
       {:opts {:char "▏"
               :filetype_exclude [:terminal
                                  :help
                                  :NvimTree
                                  :markdown
                                  :text
                                  :TelescopePrompt
                                  :TelescopeResults
                                  (unpack conf.lisp-filetypes)]
               :buftype_exclude [:terminal :nofile]}})
 (pack :echasnovski/mini.indentscope {:opts {:draw {:delay 50}}})]
