(import-macros {: lazy : map!} :macros)
(local {: diagnostic-icons} (require :constants))

(vim.diagnostic.config {:underline {:severity {:min vim.diagnostic.severity.INFO}}
                        :signs {:severity {:min vim.diagnostic.severity.HINT}}
                        :virtual_text true
                        :float {:show_header true :source true}
                        :update_in_insert false
                        :severity_sort true})
(vim.fn.sign_define :DiagnosticSignError
                    {:text diagnostic-icons.error
                     :texthl :DiagnosticSignError})
(vim.fn.sign_define :DiagnosticSignWarn
                    {:text diagnostic-icons.warn
                     :texthl :DiagnosticSignWarn})
(vim.fn.sign_define :DiagnosticSignInfo
                    {:text diagnostic-icons.info
                     :texthl :DiagnosticSignInfo})
(vim.fn.sign_define :DiagnosticSignHint
                    {:text diagnostic-icons.hint
                     :texthl :DiagnosticSignHint})
;; Show line diagnostics
(map! [n] :<localleader>d vim.diagnostic.open_float
      {:desc "diagnostic float"})
;; Go to diagnostic
(map! [n] "[d" vim.diagnostic.goto_prev)
(map! [n] "]d" vim.diagnostic.goto_next)

(lazy :folke/trouble.nvim {:dependencies [:nvim-tree/nvim-web-devicons]})
