--(import-macros {: map!} :macros)
--
--(print "loading haskell")
--
--(set vim.g.haskell_tools
--     {:hls {:on_attach (fn [client bufnr ht]
--                         (let [telescope-themes (require :telescope.themes)]
--                           (map! [n] :<leader>cR vim.lsp.codelens.run
--                                 {:desc "Run code lens"})
--                           (map! [n] :<localleader>hh
--                                 #(ht.hoogle.hoogle_signature (telescope-themes.get_ivy))
--                                 {:desc "Hoogle search"})
--                           (map! [n] :<localleader>hr
--                                 #(ht.repl.toggle (vim.api.nvim_buf_get_name 0))
--                                 {:desc "REPL for current buffer"})
--                           (map! [n] :<localleader>hq ht.repl.quit
--                                 {:desc "quit REPL"})))}
--      :tools {:hover {:border _G.shared.border}}})
--

vim.g.haskell_tools = {
    hls = {
        on_attach = function(client, buf, ht)
            local telescope_themes = require("telescope.themes")
            vim.kemap.set("n", "<localleader>cR", vim.lsp.codelens.run, { desc = "run lens" })
            vim.kemap.set("n", "<localleader>ch", function()
                ht.hoogle.hoogle_signature(telescope_themes.get_ivy())
            end, { desc = "Hoogle search" })
            vim.kemap.set("n", "<localleader>cr", function()
                ht.repl.toggle(vim.api.nvim_buf_get_name(0))
            end, { desc = "toggle REPL" })
            vim.kemap.set("n", "<localleader>cq", ht.repl.quit, { desc = "quit REPL" })
        end,
    },
    tools = {
        hover = {
            border = require("bste.constants").border,
        },
    },
}
