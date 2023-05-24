(import-macros {: nil?} :themis.lib.types)

(local {: contains?} (require :themis.lib.seq))

(fn format! [bufnr ?async?]
  (vim.lsp.buf.format {: bufnr
                       :filter #(not (contains? [:jsonls :tsserver] $.name))
                       :async ?async?}))

(fn on-attach [client bufnr]
  ;;; ========
  ;;; Keybinds
  ;;; ========
  (import-macros {: buf-map!} :themis.keybind)
  (local builtin (require :telescope.builtin))
  ;; Show documentation
  (buf-map! [n] :K vim.lsp.buf.hover)
  ;; Go to definition
  (buf-map! [n] :gd vim.lsp.buf.definition)
  ;; Go to declaration
  (buf-map! [n] :gD vim.lsp.buf.declaration)
  ;; Go to implementation
  (buf-map! [n] :gi #(builtin.lsp_implementations {:theme :get_ivy})
            {:desc "Goto implementations"})
  ;; Go to type
  (buf-map! [n] :gt #(builtin.lsp_type_definitions {:theme :get_ivy})
            {:desc "Goto type"})
  ;; Go to references
  (buf-map! [n] :gr #(builtin.lsp_references {:theme :get_ivy})
            {:desc "Goto references"})
  ;; Rename symbol under cursor
  (buf-map! [n] :<leader>cr vim.lsp.buf.rename {:desc :rename})
  ;; Apply code actions
  (buf-map! [n] :<leader>ca vim.lsp.buf.code_action {:desc "code action"})
  (buf-map! [n] :<leader>cc #(builtin.lsp_incoming_calls {:theme :get_ivy})
            {:desc "Incoming calls"})
  (buf-map! [n] :<leader>cC #(builtin.lsp_outgoing_calls {:theme :get_ivy})
            {:desc "Outgoing calls"})
  (buf-map! [n] :<leader>cs #(builtin.lsp_document_symbols {:theme :get_ivy})
            {:desc "document symbols"})
  (buf-map! [n] :<leader>cS
            #(builtin.lsp_dynamic_workspace_symbols {:theme :get_ivy})
            {:desc "workspace symbols"})
  ;; Diagnostics
  (buf-map! [n] :<leader>dj vim.diagnostic.goto_next {:desc "next diagnostic"})
  (buf-map! [n] :<leader>dk vim.diagnostic.goto_prev {:desc "prev diagnostic"})
  (buf-map! [n] :<leader>dq vim.diagnostic.setloclist {:desc :quickfix})
  ;; Format buffer 
  (when (client.supports_method :textDocument/formatting)
    (buf-map! [n] :<leader>cf `(format! bufnr true)))
  (let [(ok? navic) (pcall require :nvim-navic)]
    (if ok?
        (if client.server_capabilities.documentSymbolProvider
            (navic.attach client bufnr))))
  ;;; ======
  ;;; Events
  ;;; ======
  (import-macros {: augroup! : clear! : autocmd!} :themis.event)
  ;; Format before saving
  (when (client.supports_method :textDocument/formatting)
    (augroup! format-before-saving (clear! {:buffer bufnr})
              (autocmd! BufWritePre <buffer> `(format! bufnr) {:buffer bufnr})))
  ;; Omnisharp-Roslyn reports non-lsp-spec compliant tokens.  
  ;; Override them here to avoid annoying 'Invalid semantic token' errors
  (when (= client.name :omnisharp)
    (tset client.server_capabilities :semanticTokensProvider
          {:full (vim.empty_dict)
           :legend {:tokenModifiers [:static_symbol]
                    :tokenTypes [:comment
                                 :excluded_code
                                 :identifier
                                 :keyword
                                 :keyword_control
                                 :number
                                 :operator
                                 :operator_overloaded
                                 :preprocessor_keyword
                                 :string
                                 :whitespace
                                 :text
                                 :static_symbol
                                 :preprocessor_text
                                 :punctuation
                                 :string_verbatim
                                 :string_escape_character
                                 :class_name
                                 :delegate_name
                                 :enum_name
                                 :interface_name
                                 :module_name
                                 :struct_name
                                 :type_parameter_name
                                 :field_name
                                 :enum_member_name
                                 :constant_name
                                 :local_name
                                 :parameter_name
                                 :method_name
                                 :extension_method_name
                                 :property_name
                                 :event_name
                                 :namespace_name
                                 :label_name
                                 :xml_doc_comment_attribute_name
                                 :xml_doc_comment_attribute_quotes
                                 :xml_doc_comment_attribute_value
                                 :xml_doc_comment_cdata_section
                                 :xml_doc_comment_comment
                                 :xml_doc_comment_delimiter
                                 :xml_doc_comment_entity_reference
                                 :xml_doc_comment_name
                                 :xml_doc_comment_processing_instruction
                                 :xml_doc_comment_text
                                 :xml_literal_attribute_name
                                 :xml_literal_attribute_quotes
                                 :xml_literal_attribute_value
                                 :xml_literal_cdata_section
                                 :xml_literal_comment
                                 :xml_literal_delimiter
                                 :xml_literal_embedded_expression
                                 :xml_literal_entity_reference
                                 :xml_literal_name
                                 :xml_literal_processing_instruction
                                 :xml_literal_text
                                 :regex_comment
                                 :regex_character_class
                                 :regex_anchor
                                 :regex_quantifier
                                 :regex_grouping
                                 :regex_alternation
                                 :regex_text
                                 :regex_self_escaped_character
                                 :regex_other_escape]}})))
