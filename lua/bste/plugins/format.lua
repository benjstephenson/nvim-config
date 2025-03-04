return {
    "stevearc/conform.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                json = { "jq" },
                yaml = { "yamlfmt" },
                markdown = { "markdownfmt" },
                lua = { "stylua" },
                python = { "isort", "black" },
                scala = { "scalafmt" },
                sql = { "sql-formatter" }
            },
            -- format_on_save = {
            --     lsp_fallback = true,
            --     async = false,
            --     timeout_ms = 500,
            -- },
        })


        vim.keymap.set("n", "<leader>bf", function() conform.format() end,
            { silent = true, buffer = 0, desc = "format buffer" })
    end,
}
