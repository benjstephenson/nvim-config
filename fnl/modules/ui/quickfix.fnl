(import-macros {: lazy} :macros)

(lazy :kevinhwang91/nvim-bqf
      {:config true
       :ft :qf
       :dependencies [:junegunn/fzf :nvim-treesitter/nvim-treesitter]})
