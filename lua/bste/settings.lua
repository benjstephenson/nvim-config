---
--- Editor configuration
---
vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

-- Characters configuration
-- Show whitespace characters
vim.opt.list = true
-- Define characters to show
vim.opt.listchars = { trail = "·", tab = "→ ", nbsp = "·" }

-- Fold configuration
-- Enable folding
vim.opt.foldenable = true
-- Display column for folds
vim.opt.foldcolumn = "1"
-- Fold column characters
vim.opt.fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "",
}

-- Diff-mode
vim.opt.diffopt:append("linematch:60")

-- Timeout for mappings
vim.opt.timeoutlen = 400

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

--
-- Diagnostics
--
local icons = require("bste.constants").diagnostic_icons

vim.diagnostic.config({
    underline = {
        severity = { min = vim.diagnostic.severity.INFO },
    },
    signs = {
        severity = { min = vim.diagnostic.severity.HINT },
    },
    virtual_text = true,
    float = { show_header = true, source = true },
    update_in_insert = false,
    severity_sort = true,
})

vim.fn.sign_define("DiagnosticSignError", { text = icons.error, texthl = "DiagnosticSignError" })

vim.fn.sign_define("DiagnosticSignWarn", { text = icons.warn, texthl = "DiagnosticSignWarn" })

vim.fn.sign_define("DiagnosticSignInfo", { text = icons.info, texthl = "DiagnosticSignInfo" })

vim.fn.sign_define("DiagnosticSignHint", { text = icons.hint, texthl = "DiagnosticSignHint" })
