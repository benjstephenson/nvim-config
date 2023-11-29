(import-macros {: lazy : map!} :macros)

(map! [n] :<leader>gg :<cmd>Neogit<cr> {:desc :Neogit})

[(lazy :TimUntersberger/neogit
       {:config true
        :dependencies [:sindrets/diffview.nvim :nvim-lua/plenary.nvim]})
 (lazy :f-person/git-blame.nvim)
 (lazy :akinsho/git-conflict.nvim {:opts {:disable_diagnostics true}})]
