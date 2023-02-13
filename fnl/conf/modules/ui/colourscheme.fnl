(import-macros {: pack} :themis.pack.lazy)

[(pack :AlexvZyl/nordic.nvim)
 (pack :folke/tokyonight.nvim)
 (pack :shaunsingh/nord.nvim)
 (pack :catppuccin/nvim {:name :catppuccin})
 (pack :nyoom-engineering/oxocarbon.nvim)
 (pack :rebelot/kanagawa.nvim {:config #(vim.cmd.colorscheme :kanagawa)})]
