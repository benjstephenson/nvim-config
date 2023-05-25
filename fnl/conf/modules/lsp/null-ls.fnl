(import-macros {: pack} :themis.pack.lazy)

(fn null-config []
  (local on-attach (require :conf.modules.lsp.on-attach))
  (local null (require :null-ls))
  ;;; =======
  ;;; Sources
  ;;; =======
  (local sources
         (let [{: formatting
                : diagnostics
                : hover
                : completion
                :code_actions actions} null.builtins
               typescript-actions (require :typescript.extensions.null-ls.code-actions)]
           [;formatting.stylua
            (formatting.prettierd.with {:condition (fn [utils]
                                                     (not (utils.root_has_file [:deno.json
                                                                                :deno.jsonc])))})
            formatting.markdownlint
            formatting.black
            formatting.isort
            formatting.fnlfmt
            actions.gitsigns
            ;(diagnostics.pylint.with {:prefer_local :.venv/bin})
            ;(diagnostics.mypy.with {:prefer_local :.venv/bin})
            (typescript-actions.with {:condition (fn [utils]
                                                   (not (utils.root_has_file [:deno.json
                                                                              :deno.jsonc])))})]))
  ;;; =====
  ;;; Setup
  ;;; =====
  (null.setup {: sources :on_attach on-attach}))

(pack :jose-elias-alvarez/null-ls.nvim
      {:config null-config :dependencies [:nvim-lua/plenary.nvim]})
