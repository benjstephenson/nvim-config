(import-macros {: lazy : map!} :macros)
(local on-attach (require :modules.tools.lsp.on-attach))
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
                            :includeInlayVariableTypeHints true
                            :includeInlayVariableTypeHintsWhenTypeMatchesName false
                            :includeInlayPropertyDeclarationTypeHints true
                            :includeInlayFunctionLikeReturnTypeHints true
                            :includeInlayEnumMemberValueHints true}]
    (typescript.setup {:server {:on_attach on-attach
                                :capabilities (default-capabilities)
                                :settings {:typescript {:inlayHints inlay-hints-config}
                                           :javascript {:inlayHints inlay-hints-config}}}}))
  (set-keymaps!))

(lazy :jose-elias-alvarez/typescript.nvim
      {:ft [:typescript :javascript] :config typescript-setup})
