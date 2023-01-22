(import-macros {: pack} :themis.pack.lazy)

[(pack :nyoom-engineering/oxocarbon.nvim)
 (pack "rebelot/kanagawa.nvim" {
                                :config #(vim.cmd.colorscheme "kanagawa")})]
