(import-macros {: pack} :themis.pack.lazy)

(fn configure [lsp on-attach capabilities]
  (lsp.omnisharp.setup {:on_attach on-attach
                        : capabilities
                        :enable_editorconfig_support true
                        :organise_imports_on_format true
                        :enable_import_completion true}))
