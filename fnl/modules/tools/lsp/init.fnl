(import-macros {: lazy : buf-map! : autocmd! : augroup! : clear!} :macros)
(local {: default-capabilities} (require :modules.tools.lsp.capabilities))
;(import-macros {: buf-map!} :core..keybind)
;(import-macros {: autocmd! : augroup! : clear!} :core.event)

;(local {: nil?} (require :core.lib.types))
;(local {: contains?} (require :core.lib.seq))
;(local {: deep-merge} (require :core.lib.table))

(local on-attach (require :modules.tools.lsp.on-attach))

(set vim.lsp.handlers.textDocument/signatureHelp
     (vim.lsp.with vim.lsp.handlers.signature_help {:border :solid}))

(set vim.lsp.handlers.textDocument/hover
     (vim.lsp.with vim.lsp.handlers.hover {:border :solid}))

;; What should the lsp be demanded of?
(local capabilities (default-capabilities))

;;; Setup servers
(local defaults {:on_attach on-attach
                 : capabilities
                 :flags {:debounce_text_changes 150}})

(fn build-server-list [lsp]
  (local lsp-servers {})
  (tset lsp-servers :clangd {:cmd [:clangd]})
  (tset lsp-servers :omnisharp {:cmd [:omnisharp]})
  (tset lsp-servers :jsonls
        {:format {:enabled false}
         :schemas [{:description "ESLint config"
                    :fileMatch [:.eslintrc.json :.eslintrc]
                    :url "http://json.schemastore.org/eslintrc"}
                   {:description "Package config"
                    :fileMatch [:package.json]
                    :url "https://json.schemastore.org/package"}
                   {:description "Packer config"
                    :fileMatch [:packer.json]
                    :url "https://json.schemastore.org/packer"}]})
  (tset lsp-servers :kotlin_langage_server {})
  (tset lsp-servers :texlab {})
  (tset lsp-servers :lua_ls
        {:settings {:Lua {:diagnostics {:globals [:vim]}
                          :workspace {:library (vim.api.nvim_list_runtime_paths)
                                      :maxPreload 100000}}}})
  (tset lsp-servers :marksman {})
  (tset lsp-servers :rnix {})
  (tset lsp-servers :pyright
        {:root_dir (lsp.util.root_pattern [:.flake8])
         :settings {:python {:analysis {:autoImportCompletions true
                                        :useLibraryCodeForTypes true
                                        :disableOrganizeImports false}}}})
  (tset lsp-servers :tsserver {})
  (tset lsp-servers :yamlls
        {:settings {:yaml {:schemaStore {:enable false
                                         :url "https://www.schemastore.org/api/json/catalog.json"}
                           :schemas {:/path/to/your/custom/strict/schema.json "yet-another.{yml,yaml}"
                                     "http://json.schemastore.org/prettierrc" ".prettierrc.{yml,yaml}"}
                           :validate true}}})
  lsp-servers)

(fn lsp-config []
  (local lsp (require :lspconfig))
  (local util (require :lspconfig.util))
  (local server-list (build-server-list lsp))
  (let [servers server-list]
    (each [server server-config (pairs server-list)]
      ((. (. lsp server) :setup) (_G.deep-merge defaults server-config)))))

;; Configuration
(lazy :neovim/nvim-lspconfig
      {:config lsp-config
       :dependencies [:folke/neodev.nvim
                      :williamboman/mason-lspconfig.nvim
                      ;:jose-elias-alvarez/typescript.nvim
                      :SmiteshP/nvim-navic]})