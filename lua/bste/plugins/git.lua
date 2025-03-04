return {
    {
        "lewis6991/gitsigns.nvim",
        config = true,
        event = "VeryLazy",
    },
    {
        "f-person/git-blame.nvim",
        config = true,
        event = "VeryLazy",
    },
    {
        "TimUntersberger/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
        opts = {
            graph_style = "unicode",
            integrations = {
                diffview = true
            }
        },
        config = true,
        event = "VeryLazy",
    },
}
