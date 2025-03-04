vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup({
 spec = { import = "bste.plugins" },
    rocks = {
        hererocks = true
    }
})
require("bste.settings")
require("bste.keybind")
require("bste.events")
