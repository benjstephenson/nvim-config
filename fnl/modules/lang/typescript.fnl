(import-macros {: lazy} :macros)
(local on-attach (require :modules.tools.lsp.on-attach))
(local { : default-capabilities } (require :modules.tools.lsp.capabilities))

(fn typescript-setup []
  (let [typescript (require :typescript)
        inlay-hints-config {:includeInlayParameterNameHints "all"
                            :includeInlayParameterNameHintsWhenArgumentMatchesName false
                            :includeInlayFunctionParameterTypeHints true
                            :includeInlayVariableTypeHints true
                            :includeInlayVariableTypeHintsWhenTypeMatchesName false
                            :includeInlayPropertyDeclarationTypeHints true
                            :includeInlayFunctionLikeReturnTypeHints true
                            :includeInlayEnumMemberValueHints true}]
    (typescript.setup {:server {:on_attach on-attach :capabilities (default-capabilities)
                                :settings {:typescript {:inlayHints inlay-hints-config}
                                           :javascript {:inlayHints inlay-hints-config}}}}))  
  )

(lazy :jose-elias-alvarez/typescript.nvim {:config typescript-setup}) ; :ft [:typescript :javascript]})
