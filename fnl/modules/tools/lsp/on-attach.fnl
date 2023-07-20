(import-macros {: autocmd! : augroup! : clear! : buf-map!} :macros)

(fn on-attach [client bufnr]
  ;; Keybindings
  (local {:hover open-doc-float!
          :declaration goto-declaration!
          :definition goto-definition!
          :type_definition goto-type-definition!
          :references goto-references!} vim.lsp.buf)
  (buf-map! [n] :K open-doc-float! {:desc "doc under cursor"})
  (buf-map! [n] :gD goto-declaration! {:desc "goto declaration"})
  (buf-map! [n] :gd goto-definition! {:desc "goto definition"})
  (buf-map! [n] :gt goto-type-definition! {:desc "goto type definition"})
  (buf-map! [n] :gr goto-references! {:desc "goto references"})
  ;; Enable lsp formatting if available 
  (when (client.supports_method :textDocument/formatting)
    (augroup! format-before-saving (clear! {:buffer bufnr})
              (autocmd! BufWritePre <buffer>
                        #(when (not vim.g.lsp_autoformat_disable)
                           (vim.lsp.buf.format {: bufnr} :filter
                                               #(not (contains? [:jsonls
                                                                 :tsserver]
                                                                $.name))))
                        {:buffer bufnr}))))
