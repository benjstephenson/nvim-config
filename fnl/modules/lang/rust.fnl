(import-macros {: lazy : map! : set! : augroup! : autocmd! : clear!} :macros)
(local on-attach (require :modules.tools.lsp.on-attach))

(lazy :simrat39/rust-tools.nvim {:dependencies [:nvim-lua/plenary.nvim
                                                :mfussenegger/nvim-dap
                                                :neovim/nvim-lspconfig]
                                 :ft [:rust]})
