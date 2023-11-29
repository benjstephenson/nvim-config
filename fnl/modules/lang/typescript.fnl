(import-macros {: lazy : map!} :macros)
;(local on-attach (require :modules.tools.lsp.on-attach))
(local {: default-capabilities} (require :modules.tools.lsp.capabilities))

(fn set-keymaps! []
  (let [typescript (require :typescript)]
    (map! [n] :<localleader>co typescript.actions.organizeImports
          {:desc "organise imports"})
    (map! [n] :<localleader>ci typescript.actions.addMissingImports
          {:desc "add missing imports"})
    (map! [n] :<localleader>cu typescript.actions.removeUnused
          {:desc "remove unused variables"})))

(fn typescript-setup []
  (let [typescript (require :typescript)
        inlay-hints-config {:includeInlayParameterNameHints :all
                            :includeInlayParameterNameHintsWhenArgumentMatchesName false
                            :includeInlayFunctionParameterTypeHints true
                            :includeInlayVariableTypeHints false
                            :includeInlayVariableTypeHintsWhenTypeMatchesName false
                            :includeInlayPropertyDeclarationTypeHints true
                            :includeInlayFunctionLikeReturnTypeHints true
                            :includeInlayEnumMemberValueHints true}]
    (typescript.setup {:server {:on_attach set-keymaps!
                                :capabilities (default-capabilities)
                                :settings {:typescript {:inlayHints inlay-hints-config}
                                           :javascript {:inlayHints inlay-hints-config}}}})))

(lazy :jose-elias-alvarez/typescript.nvim
      {:ft [:typescript :typescriptreact :javascript] :config typescript-setup})
