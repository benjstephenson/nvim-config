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
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
        opts = {
            name = { "venv", ".venv" },
        },
        event = "VeryLazy",
    },
}
