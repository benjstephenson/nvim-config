return {
    "nvim-lua/plenary.nvim",
    {
        "nyoom-engineering/oxocarbon.nvim",
        config = function()
            vim.cmd.colorscheme("oxocarbon")
        end,
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "nvim-tree/nvim-web-devicons" },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            --wk.setup({})

            wk.register({
                b = { name = "+buffer" },
                c = { name = "+code" },
                f = { name = "+file" },
                g = { name = "+git" },
                h = { name = "+help" },
            })
        end,
    },
}
