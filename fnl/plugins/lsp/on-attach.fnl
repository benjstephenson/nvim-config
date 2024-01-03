(import-macros {: autocmd! : augroup! : clear! : buf-map!} :macros)

(augroup! user-lsp-config (clear!)
          (autocmd! LspAttach *
                    (fn [args]
                      (let [bufnr args.bbf
                            client (vim.lsp.get_client_by_id args.data.client_id)]
                        ;; Keybindings
                        (local {:hover open-doc-float!
                                :declaration goto-declaration!
                                :definition goto-definition!
                                :signature_help signature-help!
                                :type_definition goto-type-definition!
                                :references goto-references!}
                               vim.lsp.buf)
                        (buf-map! [n] :<C-k> signature-help!
                                  {:desc "doc under cursor"})
                        (buf-map! [n] :K open-doc-float!
                                  {:desc "doc under cursor"})
                        (buf-map! [n] :gD goto-declaration!
                                  {:desc "goto declaration"})
                        (buf-map! [n] :gd goto-definition!
                                  {:desc "goto definition"})
                        (buf-map! [n] :gt goto-type-definition!
                                  {:desc "goto type definition"})
                        (buf-map! [n] :gr goto-references!
                                  {:desc "goto references"})
                        (when (client.supports_method :textDocument/inlayHint)
                          (vim.lsp.inlay_hint.enable bufnr true))
                        ;;Enable lsp formatting if available
                        (when (client.supports_method :textDocument/formatting)
                          (augroup! format-before-saving
                                    (clear! {:buffer bufnr})
                                    (autocmd! BufWritePre <buffer>
                                              #(when (not vim.g.lsp_autoformat_disable)
                                                 (vim.lsp.buf.format {: bufnr}
                                                                     :filter
                                                                     #(not (contains? [:jsonls
                                                                                       :tsserver]
                                                                                      $.name))))
                                              {:buffer bufnr})))))))

;;(fn on-attach [client bufnr]
;;  ;; Keybindings
;;  (local {:hover open-doc-float!
;;          :declaration goto-declaration!
;;          :definition goto-definition!
;;          :type_definition goto-type-definition!
;;          :references goto-references!} vim.lsp.buf)
;;  (buf-map! [n] :K open-doc-float! {:desc "doc under cursor"})
;;  (buf-map! [n] :gD goto-declaration! {:desc "goto declaration"})
;;  (buf-map! [n] :gd goto-definition! {:desc "goto definition"})
;;  (buf-map! [n] :gt goto-type-definition! {:desc "goto type definition"})
;;  (buf-map! [n] :gr goto-references! {:desc "goto references"})
;;  (when (client.supports_method :textDocument/inlayHint)
;;    (vim.lsp.inlay_hint bufnr true))
;;  ;; Enable lsp formatting if available 
;;  (when (client.supports_method :textDocument/formatting)
;;    (augroup! format-before-saving (clear! {:buffer bufnr})
;;              (autocmd! BufWritePre <buffer>
;;                        #(when (not vim.g.lsp_autoformat_disable)
;;                           (vim.lsp.buf.format {: bufnr} :filter
;;                                               #(not (contains? [:jsonls
;;                                                                 :tsserver]
;;                                                                $.name))))
;;                        {:buffer bufnr}))))