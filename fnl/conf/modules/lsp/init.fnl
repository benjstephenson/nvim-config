(import-macros {: pack} :themis.pack.lazy)
(import-macros {: nil?} :themis.lib.types)

; local function get_python_path(workspace)
;   -- Use activated virtualenv.
;   if vim.env.VIRTUAL_ENV then
;     return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
;   end
;
;   -- Find and use virtualenv from pipenv in workspace directory.
;   local match = vim.fn.glob(path.join(workspace, 'Pipfile'))
;   if match ~= '' then
;      local venv = vim.fn.trim(vim.fn.system('poetry --directory ' .. workspace .. ' env info -p'))
;      return path.join(venv, 'bin', 'python'))
;   end
;
;   -- Fallback to system Python.
;   return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
; end
;

(fn build-virtual-env [workspace]
  (local util (require :lspconfig.util))
  (let [poetry-file (vim.fn.glob (util.path.join workspace :poetry.lock))]
    (if (nil? poetry-file)
        (or (or (vim.fn.exepath :python3) (vim.fn.exepath :python)) :python)
        (let [venv (vim.fn.trim (vim.fn.system (.. "poetry --directory "
                                                   workspace "env info -p")))]
          (util.path.join venv :bin :python)))))

(fn get-python-path [workspace]
  (local util (require :lspconfig.util))
  (if vim.env.VIRTUAL_ENV
      (util.path.join vim.env.VIRTUAL_ENV :bin :python)
      (build-virtual-env workspace)))

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

  (fn set-path [client]
    (tset client.config.settings.python :pythonPath
          (get-python-path client.config.root_dir)))

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
  (lsp.cssls.setup {:on_attach on-attach : capabilities})
  ;; HTML
  (lsp.html.setup {:on_attach on-attach : capabilities})
  ;; Emmet
  (lsp.emmet_ls.setup {:on_attach on-attach : capabilities})
  ;; Vue
  ;;(lsp.volar.setup {:on_attach on-attach : capabilities})
  ;; Svelte
  ;;(lsp.svelte.setup {:on_attach on-attach : capabilities})
  ;; Yaml
  (lsp.yamlls.setup {:on_attach on-attach : capabilities})
  ;; Toml
  (lsp.taplo.setup {:on_attach on-attach : capabilities})
  ;; XML
  (lsp.lemminx.setup {:on_attach on-attach : capabilities})
  ;; Clojure
  (lsp.clojure_lsp.setup {:on_attach on-attach : capabilities})
  ;; VimL
  (lsp.vimls.setup {:on_attach on-attach : capabilities}))

;; Go
;;(lsp.gopls.setup {:on_attach on-attach : capabilities}))

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

[;; Configuration
 (pack :neovim/nvim-lspconfig
       {:config lsp-config
        :dependencies [:folke/neodev.nvim
                       :williamboman/mason-lspconfig.nvim
                       (pack :j-hui/fidget.nvim {:config true})
                       (pack :narutoxy/dim.lua {:config true})
                       :jose-elias-alvarez/typescript.nvim
                       :b0o/schemastore.nvim
                       :SmiteshP/nvim-navic]})
 ;; Installation
 (pack :williamboman/mason.nvim {:config true})
 (pack :williamboman/mason-lspconfig.nvim
       {:config {:automatic_installation true}
        :dependencies [:williamboman/mason.nvim]})
 (pack :HallerPatrick/py_lsp.nvim
       {:config true
        :ft [:python :py]
        :setup {:host_python (vim.fn.exepath :python3)
                :default_venv_name :.venv}})
 ;; Non-LSP integration
 (pack :jose-elias-alvarez/null-ls.nvim
       {:config null-config :dependencies [:nvim-lua/plenary.nvim]})]
