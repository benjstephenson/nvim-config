return {
    "nvim-lua/plenary.nvim",
    {
        "nyoom-engineering/oxocarbon.nvim",
        config = function()
            vim.cmd.colorscheme("oxocarbon")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = true,
            })
        end,
    },
    { "rebelot/kanagawa.nvim" },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "nvim-tree/nvim-web-devicons" },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<localleader>u", ":UndotreeToggle<CR>", { desc = "toggle undotree" })
        end
    },
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
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")
            harpoon.setup({})
            vim.keymap.set("n", "<localleader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "toggle harpoon menu" })
            vim.keymap.set("n", "<localleader>ha", function() harpoon:list():append() end)
            vim.keymap.set("n", "<localleader>hn", function() harpoon:list():next() end)
            vim.keymap.set("n", "<localleader>hp", function() harpoon:list():prev() end)
        end,
    },
}
