return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local colors = {
            blue = "#80a0ff",
            cyan = "#79dac8",
            black = "#080808",
            white = "#c6c6c6",
            red = "#ff5189",
            violet = "#d183e8",
            grey = "#303030",
        }

        local bubbles_theme = {
            normal = {
                a = { fg = colors.black, bg = colors.violet },
                b = { fg = colors.white, bg = colors.grey },
                c = { fg = colors.white },
            },

            insert = { a = { fg = colors.black, bg = colors.blue } },
            visual = { a = { fg = colors.black, bg = colors.cyan } },
            replace = { a = { fg = colors.black, bg = colors.red } },

            inactive = {
                a = { fg = colors.white, bg = colors.black },
                b = { fg = colors.white, bg = colors.black },
                c = { fg = colors.white },
            },
        }

        require("lualine").setup({
            options = {
                -- theme = bubbles_theme,
                component_separators = "",
                section_separators = { left = "", right = "" },
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
                lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
                lualine_b = { "branch", "diff", "diagnostics", "searchcount" },
                lualine_c = {
                    "%=",
                    {
                        "filename",
                        path = 1
                    }--[[ add your center compoentnts here in place of this comment ]],
                },
                lualine_x = {},
                lualine_y = { "filetype", "progress" },
                lualine_z = {
                    { "location", separator = { right = "" }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = { {"filename", path = 1 }},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location" },
            },
            extensions = {},
        })
        --require("lualine").setup({
        --    options = {
        --        globalstatus = true,
        --        theme = "auto",
        --        icons_enabled = true,
        --        always_divide_middle = true,
        --        disabled_filetypes = { winbar = { "qf", "neotest-summary" } },
        --        --component_separators = { left = " ", right = " " },
        --        component_separators = { left = "", right = "" },
        --        section_separators = { left = "", right = "" },
        --    },
        --    winbar = {
        --        lualine_a = {},
        --        lualine_b = {},
        --        lualine_c = {}
        --    },
        --    inactive_winbar = {
        --        lualine_a = {},
        --        lualine_b = {},
        --        lualine_c = {}
        --    },
        --    tabline = {
        --        lualine_a = {},
        --        lualine_b = { "buffers" },
        --        lualine_c = {},
        --        lualine_x = {},
        --        lualine_y = {},
        --        lualine_z = { "tabs" },
        --    },
        --    sections = {
        --        lualine_a = { "mode" },
        --        lualine_b = { "branch", "diff", "diagnostics" },
        --        lualine_c = { "filename", "searchcount" },
        --        lualine_x = {},
        --        lualine_y = { "filetype", "fileformat", "encoding" },
        --        lualine_z = { "progress", "location" },
        --    },
        --})
    end,
}
