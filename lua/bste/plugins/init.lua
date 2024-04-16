return {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    {
        "nyoom-engineering/oxocarbon.nvim",
        --config = function()
        --    vim.cmd.colorscheme("oxocarbon")
        --    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        --    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        --end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            --require("rose-pine").setup({
            --    disable_background = true,
            --})
            --vim.cmd.colorscheme("rose-pine")
        end,
    },
    { "rebelot/kanagawa.nvim" },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "nvim-tree/nvim-web-devicons" },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<localleader>u", ":UndotreeToggle<CR>", { desc = "toggle undotree" })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({ layout = { align = "center" } })

            wk.register({
                b = { name = "+buffer" },
                c = { name = "+code" },
                f = { name = "+file" },
                g = { name = "+git" },
                h = { name = "+help" },
            }, { mode = "n", prefix = "<leader>" })

            wk.register({
                h = { name = "+harpoon" },
            }, { mode = "n", prefix = "<localleader>" })
        end,
    },
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")
            harpoon.setup({})
            vim.keymap.set("n", "<leader>bh", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "toggle harpoon menu" })
            vim.keymap.set("n", "<localleader>ha", function()
                harpoon:list():append()
            end, { desc = "add to harpoon" })
            vim.keymap.set("n", "<localleader>hn", function()
                harpoon:list():next()
            end, { desc = "next" })
            vim.keymap.set("n", "<localleader>hp", function()
                harpoon:list():prev()
            end, { desc = "prev" })
            vim.keymap.set("n", "<localleader>h1", function()
                harpoon:list():select(1)
            end, { desc = "prev" })
            vim.keymap.set("n", "<localleader>h2", function()
                harpoon:list():select(2)
            end, { desc = "prev" })
            vim.keymap.set("n", "<localleader>h3", function()
                harpoon:list():select(3)
            end, { desc = "prev" })
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
}
