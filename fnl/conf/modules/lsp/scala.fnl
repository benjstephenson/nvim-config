(import-macros {: pack} :themis.pack.lazy)
(import-macros {: nil?} :themis.lib.types)
(import-macros {: augroup! : clear! : autocmd!} :themis.event)

(fn config []
  (local metals (require :metals))
  (local metals-config (metals.bare_config))
  (print (vim.inspect metals-config))
  (metals.initialize_or_attach metals-config))

(augroup! nvim-metals (clear!) (autocmd! FileType [scala sbt java] `(config)))

(pack :scalameta/nvim-metals {:dependencies [:nvim-lua/plenary.nvim]})
