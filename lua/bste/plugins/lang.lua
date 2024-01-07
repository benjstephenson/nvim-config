return {
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        setup = function()
            vim.g.mkdp_filetypes = { "markdown", "plantuml" }
        end,
        ft = { "markdown", "plantuml" },
    },
    {
        "simrat39/rust-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
            "neovim/nvim-lspconfig",
        },
        ft = { "rust" },
    },
}
