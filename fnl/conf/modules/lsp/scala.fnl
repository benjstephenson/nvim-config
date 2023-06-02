(import-macros {: pack} :themis.pack.lazy)
(import-macros {: nil?} :themis.lib.types)
(import-macros {: map!} :themis.keybind)
(import-macros {: augroup! : clear! : autocmd!} :themis.event)

(fn initialise []
  (let [metals (require :metals)
        (cmp-ok? cmp) (pcall require :cmp_nvim_lsp)
        (telescope-ok? telescope) (pcall require :telescope)
        metals-config (metals.bare_config)]
    (tset metals-config :settings
          {:showImplicitArguments true
           :showInferredType true
           :showImplicitConversionsAndClasses true
           :enableSemanticHighlighting true
           :superMethodLensesEnabled true})
    (print (vim.inspect metals-config))
    (if cmp-ok?
        (tset metals-config :capabilities (cmp.default_capabilities)))
    (metals.initialize_or_attach metals-config)
    (if telescope-ok?
        (map! [n] :<localleader>m telescope.extensions.metals.commands
              {:desc "Metals commands"}))))

(augroup! nvim-metals (clear!)
          (autocmd! FileType [scala sbt java] `(initialise)))

(pack :scalameta/nvim-metals {:dependencies [:nvim-lua/plenary.nvim]})
