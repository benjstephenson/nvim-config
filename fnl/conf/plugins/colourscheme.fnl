(import-macros {: pack} :themis.pack.lazy)

(pack "rebelot/kanagawa.nvim" {
                               :config #(vim.cmd.colorscheme "kanagawa")})
