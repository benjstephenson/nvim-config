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
        },
        opts = {
            graph_style = "unicode"
        },
        config = true,
        event = "VeryLazy",
    },
}
