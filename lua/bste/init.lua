vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup({ { import = "bste.plugins" } })
require("bste.settings")
require("bste.keybind")
