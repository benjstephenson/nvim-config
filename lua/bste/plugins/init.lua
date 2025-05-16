return {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    -- {
    --     "nyoom-engineering/oxocarbon.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     -- config = function()
    --     --    vim.cmd.colorscheme("oxocarbon")
    --     --    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --     --    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    --     -- end,
    -- },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },
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
        config = {
            preset = "helix",
            layout = { align = "center" },
            spec = {
                { "<leader>b",      group = "buffer" },
                { "<leader>c",      group = "code" },
                { "<leader>d",      group = "debug" },
                { "<leader>f",      group = "file" },
                { "<leader>g",      group = "git" },
                { "<leader>h",      group = "help" },
                { "<leader>t",      group = "test" },
                { "<leader>x",      group = "diagnostic" },
                { "<localleader>h", group = "harpoon" },
                { "<localleader>n", group = "swap next" },
                { "<localleader>p", group = "swap prev" },
                { "<localleader>t", group = "tests" },
            },
        },
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
                harpoon:list():add()
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
