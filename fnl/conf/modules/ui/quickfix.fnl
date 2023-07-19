(import-macros {: pack} :themis.pack.lazy)

[(pack :folke/trouble.nvim {:dependencies [:nvim-tree/nvim-web-devicons]})
 (pack :kevinhwang91/nvim-bqf
       {:ft :qf :dependencies [:junegunn/fzf :nvim-treesitter/nvim-treesitter]})]
