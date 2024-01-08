return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                globalstatus = true,
                theme = "auto",
                icons_enabled = true,
                always_divide_middle = true,
                disabled_filetypes = { winbar = { "qf", "neotest-summary" } },
                --component_separators = { left = " ", right = " " },
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {}
            },
            tabline = {
                lualine_a = {},
                lualine_b = { "buffers" },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "tabs" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename", "searchcount" },
                lualine_x = {},
                lualine_y = { "filetype", "fileformat", "encoding" },
                lualine_z = { "progress", "location" },
            },
        })
    end,
}
