(import-macros {: lazy} :macros)

[(lazy :TimUntersberger/neogit {:dependencies [:nvim-lua/plenary.nvim]})
 (lazy :f-person/git-blame.nvim)
 (lazy :akinsho/git-conflict.nvim {:opts {:disable_diagnostics true}})]
