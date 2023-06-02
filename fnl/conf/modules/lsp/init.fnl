(import-macros {: pack} :themis.pack.lazy)
(import-macros {: nil?} :themis.lib.types)

(fn lsp-config []
  (local on-attach (require :conf.modules.lsp.on-attach))
  (local lsp (require :lspconfig))
  (local util (require :lspconfig.util))
  (local capabilities
         (let [(ok? cmp) (pcall require :cmp_nvim_lsp)]
           (if ok? (cmp.default_capabilities)
               (vim.lsp.protocol.make_client_capabilities))))
  (set capabilities.textDocument.foldingRange
       {:dynamicRegistration false :lineFoldingOnly true})
  ;;; ====================
  ;;; Client configuration
  ;;; ====================
  ;; Lua
  (let [neodev (require :neodev)]
    (neodev.setup {})
    (lsp.lua_ls.setup {:on_attach on-attach
                       : capabilities
                       :settings {:Lua {:format {:defaultConfig {:indent_style :space
                                                                 :indent_size :2}}
                                        :workspace {:preloadFileSize 500}}}}))
  ;; Json
  (lsp.jsonls.setup {:on_attach on-attach
                     : capabilities
                     :settings {:json {:schemas (let [{: json} (require :schemastore)]
                                                  (json.schemas))}}})
  ;; Docker
  (lsp.dockerls.setup {:on_attach on-attach : capabilities})
  ;; Nix
  ;;(lsp.rnix.setup {:on_attach on-attach : capabilities})
  ;; Bash
  (lsp.bashls.setup {:on_attach on-attach : capabilities})
  ;; C & C++
  ;;(lsp.clangd.setup {:on_attach on-attach : capabilities})
  ;; CMake
  ;;(lsp.cmake.setup {:on_attach on-attach : capabilities})
  (lsp.omnisharp.setup {:on_attach on-attach
                        : capabilities
                        :enable_editorconfig_support true
                        :organise_imports_on_format true
                        :enable_import_completion true})
  ;; Python
  ;(lsp.pyright.setup {:on_attach on-attach : capabilities :on-init set-path})
  ;(lsp.pylsp.setup {:on_attach on-attach : capabilities})
  ;; Rust
  (lsp.rust_analyzer.setup {:on_attach on-attach
                            : capabilities
                            :settings {:rust-analyzer {:checkOnSave {:allFeatures true
                                                                     :overrideCommand [:cargo
                                                                                       :clippy
                                                                                       :--workspace
                                                                                       :--message-format=json
                                                                                       :--all-targets
                                                                                       :--all-features]}}}})
  ;; Typescript
  (let [typescript (require :typescript)]
    (typescript.setup {:server {:on_attach on-attach
                                : capabilities
                                :root_dir (lsp.util.root_pattern :package.json)}}))
  ;; (lsp.denols.setup {:on_attach on-attach : capabilities 
  ;;                    :root_dir (lsp.util.root_pattern "deno.json" "deno.jsonc")))
  ;; ESLint
  (lsp.eslint.setup {:on_attach on-attach : capabilities})
  ;; CSS
  ;; (lsp.cssls.setup {:on_attach on-attach : capabilities})
  ;; HTML
  ;; (lsp.html.setup {:on_attach on-attach : capabilities})
  ;; Emmet
  ;; (lsp.emmet_ls.setup {:on_attach on-attach : capabilities})
  ;; Vue
  ;;(lsp.volar.setup {:on_attach on-attach : capabilities})
  ;; Svelte
  ;;(lsp.svelte.setup {:on_attach on-attach : capabilities})
  ;; Yaml
  (lsp.yamlls.setup {:on_attach on-attach
                     : capabilities
                     :settings {:yaml {:keyOrdering false}}})
  ;; Toml
  (lsp.taplo.setup {:on_attach on-attach : capabilities})
  ;; XML
  ;; (lsp.lemminx.setup {:on_attach on-attach : capabilities})
  ;; Clojure
  (lsp.clojure_lsp.setup {:on_attach on-attach : capabilities})
  ;; VimL
  (lsp.vimls.setup {:on_attach on-attach : capabilities}))

;; Go
;;(lsp.gopls.setup {:on_attach on-attach : capabilities}))

[;; Configuration
 (pack :neovim/nvim-lspconfig
       {:config lsp-config
        :dependencies [:folke/neodev.nvim
                       :williamboman/mason-lspconfig.nvim
                       :jose-elias-alvarez/typescript.nvim
                       :b0o/schemastore.nvim
                       :SmiteshP/nvim-navic]})
 (pack :j-hui/fidget.nvim
       {:opts {:text {:spinner :dots_pulse :completed :Done}
               :window {:border :rounded}}})
 (pack :ray-x/lsp_signature.nvim {:opts {:max_width 120}})
 ;; Installation
 (pack :williamboman/mason.nvim {:config true})
 (pack :williamboman/mason-lspconfig.nvim
       {:opts {:automatic_installation true}
        :dependencies [:williamboman/mason.nvim]})
 ;; Non-LSP integration
 (require :conf.modules.lsp.null-ls)
 (require :conf.modules.lsp.lisp)
 (require :conf.modules.lsp.python)
 (require :conf.modules.lsp.scala)]
