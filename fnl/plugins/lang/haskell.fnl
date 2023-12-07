(import-macros {: lazy} :macros)

(lazy :MrcJkb/haskell-tools.nvim
      {:dependencies [:nvim-lua/plenary.nvim :nvim-lua/telescope.nvim]
       :version :^2
       :ft [:haskell :lhaskell :cabal :cabalproject]})
