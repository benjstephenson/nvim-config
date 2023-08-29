(import-macros {: lazy : map! : if-loaded!} :macros)

(vim.diagnostic.config {:underline {:severity {:min vim.diagnostic.severity.INFO}}
                        :signs {:severity {:min vim.diagnostic.severity.HINT}}
                        :virtual_text false
                        :float {:show_header false :source true}
                        :update_in_insert false
                        :severity_sort true})

(vim.fn.sign_define :DiagnosticSignError
                    {:text _G.shared.diagnostic-icons.error
                     :texthl :DiagnosticSignError})

(vim.fn.sign_define :DiagnosticSignWarn
                    {:text _G.shared.diagnostic-icons.warn
                     :texthl :DiagnosticSignWarn})

(vim.fn.sign_define :DiagnosticSignInfo
                    {:text _G.shared.diagnostic-icons.info
                     :texthl :DiagnosticSignInfo})

(vim.fn.sign_define :DiagnosticSignHint
                    {:text _G.shared.diagnostic-icons.hint
                     :texthl :DiagnosticSignHint})

;; Show line diagnostics
(map! [n] :<localleader>d vim.diagnostic.open_float)
;; Go to diagnostic
(map! [n] "[d" vim.diagnostic.goto_prev)
(map! [n] "]d" vim.diagnostic.goto_next)

(fn build-sources [null-ls]
  (local null-ls-sources {})
  ;;Formatting
  (table.insert null-ls-sources null-ls.builtins.formatting.fnlfmt)
  (table.insert null-ls-sources null-ls.builtins.formatting.clang_format)
  ;(table.insert null-ls-sources null-ls.builtins.formatting.zprint)
  (table.insert null-ls-sources null-ls.builtins.formatting.google_java_format)
  (table.insert null-ls-sources null-ls.builtins.formatting.ktlint)
  (table.insert null-ls-sources null-ls.builtins.formatting.stylua)
  (table.insert null-ls-sources null-ls.builtins.formatting.markdownlint)
  (table.insert null-ls-sources null-ls.builtins.formatting.black)
  (table.insert null-ls-sources null-ls.builtins.formatting.isort)
  (table.insert null-ls-sources null-ls.builtins.formatting.rustfmt)
  (table.insert null-ls-sources null-ls.builtins.formatting.shfmt)
  (table.insert null-ls-sources null-ls.builtins.formatting.zigfmt)
  (if-loaded! :lang.typescript
              (table.insert null-ls-sources
                            (require :typescript.extensions.null-ls.code-actions)))
  ;; Diagnostics
  (table.insert null-ls-sources null-ls.builtins.diagnostics.selene)
  (table.insert null-ls-sources null-ls.builtins.code_actions.gitsigns)
  null-ls-sources)

(fn null-setup []
  ;(local on-attach (require :modules.tools.lsp.on-attach))
  (local null (require :null-ls))
  (null.setup {:sources (build-sources null)
   ;            :on_attach on-attach
               :debug true
               ;; #{m}: message
               ;; #{s}: source name (defaults to null-ls if not specified)
               ;; #{c}: code (if available
               :diagnostics_format "[#{c}] #{m} (#{s})"}))

(lazy :jose-elias-alvarez/null-ls.nvim
      {:config null-setup
       :dependencies [:nvim-lspconfig :nvim-lua/plenary.nvim]})
