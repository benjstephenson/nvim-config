local function register_keymaps()
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")

    vim.keymap.set("n", "<leader>ci", builtin.lsp_implementations, { desc = "find implementations" })
    vim.keymap.set("n", "gr", function()
        builtin.lsp_references(themes.get_ivy())
    end, { desc = "find references" })

    vim.keymap.set("n", "<leader>cs", builtin.lsp_document_symbols, { desc = "document symbol" })
    vim.keymap.set("n", "<leader>cS", builtin.lsp_workspace_symbols, { desc = "workspace symbol" })

    vim.keymap.set("n", "<leader>8", function()
        local opts = themes.get_ivy()
        opts.default_text = vim.fn.expand("<cword>")
        builtin.current_buffer_fuzzy_find(opts)
    end, { desc = "swoop" })

    vim.keymap.set("n", "<leader>*", function()
        local opts = themes.get_ivy()
        opts.default_text = vim.fn.expand("<cword>")
        builtin.live_grep(opts)
    end, { desc = "swoop workspace" })

    vim.keymap.set("n", "<leader>cx", function()
        builtin.diagnostics({ bufnr = 0 })
    end, { desc = "local diagnostics" })

    vim.keymap.set("n", "<leader>cX", builtin.diagnostics, { desc = "workspace diagnostics" })
end

local function setup()
    local telescope = require("telescope")
    local themes = require("telescope.themes")

    telescope.setup({
        defaults = {
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = "  ",
            sorting_strategy = "ascending",
            layout_strategy = "flex",
            layout_config = { horizontal = { prompt_position = "top" } },
            set_env = { COLORTERM = "truecolor" },
            dynamic_preview_title = "layout_config",
        },
        pickers = {
            oldfiles = { prompt_title = "Recent files" },
        },
        extensions = {
            ["ui-select"] = themes.get_cursor(),
        },
    })

    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")
    register_keymaps()
end

return {
    "nvim-lua/telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
    },
    config = setup,
}
