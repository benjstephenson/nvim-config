(import-macros {: lazy : buf-map!} :macros)
(local on-attach (require :modules.tools.lsp.on-attach))

(fn setup-metals []
  (local metals (require :metals))
  (local metals-config (metals.bare_config))
  (local telescope (_G.autoload :telescope))
  (tset metals-config :settings {:showImplicitArguments true})
  (tset metals-config :on_attach on-attach)
  (metals.initialize_or_attach metals-config)
  (buf-map! [n] :<localleader>m telescope.extensions.metals.commands
            {:desc :metals}))

(lazy :scalameta/nvim-metals
      {:config setup-metals
       :ft [:scala]
       :dependencies [:nvim-lua/plenary.nvim]})
