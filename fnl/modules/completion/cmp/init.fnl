(import-macros {: lazy} :macros)

(fn feedkey [key mode]
  (vim.api.nvim_feedkeys (vim.api.nvim_replace_termcodes key true true true)
                         mode true))

(fn config []
  (local cmp (require :cmp))
  ;;; =======
  ;;; Options
  ;;; =======
  (import-macros {: set!} :macros)
  (set! completeopt [:menu :menuone :noselect])
  ;;; ========
  ;;; Mappings
  ;;; ========
  (local mappings {;; Scrolling
                   :<C-b> (cmp.mapping.scroll_docs -4)
                   :<C-f> (cmp.mapping.scroll_docs 4)
                   ;; Completion
                   :<C-Space> (cmp.mapping.complete)
                   :<C-e> (cmp.mapping.abort)
                   :<CR> (cmp.mapping.confirm {:select true})
                   :<Tab> (cmp.mapping (fn [fallback]
                                         (if (cmp.visible)
                                             (cmp.select_next_item)
                                             (= (vim.fn.vsnip#available 1) 1)
                                             (feedkey "<Plug>(vsnip-expand-or-jump)"
                                                      "")
                                             (fallback)))
                                       [:i :s])
                   :<S-Tab> (cmp.mapping (fn [fallback]
                                           (if (cmp.visible)
                                               (cmp.select_prev_item)
                                               (= (vim.fn.vsnip#jumpable -1) 1)
                                               (feedkey "<Plug>(vsnip-jump-prev)"
                                                        "")
                                               (fallback)))
                                         [:i :s])})
  ;;; =======
  ;;; Sources
  ;;; =======
  (local sources
         [[{:name :nvim_lsp}
           ; {:name :nvim_lsp_signature_help}
           {:name :vsnip}
           {:name :path}
           {:name :git}
           {:name :conjure}]
          [{:name :buffer :option {:keyword_pattern "\\k\\+"}}
           {:name :spell
            :option {:enable_in_context #(let [context (require :cmp.config.context)]
                                           (context.in_treesitter_capture :spell))}}]])
  ;;; ===========
  ;;; Comparators
  ;;; ===========
  (local cmp-buffer (require :cmp_buffer))
  (local under-compare (require :cmp-under-comparator))
  (local comparators [(fn [...] (cmp-buffer:compare_locality ...))
                      cmp.config.compare.offset
                      cmp.config.compare.exact
                      cmp.config.compare.score
                      under-compare.under
                      cmp.config.compare.kind
                      cmp.config.compare.sort_text
                      cmp.config.compare.length
                      cmp.config.compare.order])
  ;;; =========
  ;;; Aesthetic
  ;;; =========
 (local source-labels {:buffer "[Buffer]"
                       :nvim_lsp "[LSP]"
                       :luasnip "[LuaSnip]"
                       :nvim_lua "[Lua]"
                       :latex_symbols "[LaTeX]"})


 (fn format-item [entry item] ; Define kind icons
   (let [icon (. _G.shared.kind-icons item.kind)]
     (set item.kind (.. (or icon "") " " item.kind)) ; Define menu labels
     (set item.menu (or (. source-labels entry.source.name) "")) ; Return the item
     item))

  ;;; =====
  ;;; Setup
  ;;; =====
 (cmp.setup {:view {:entries {:name :custom :selection_order :near_cursor}}
             :formatting {:mode :symbol_text
                          :fields [:kind :abbr :menu]
                          :format format-item}
             :window {:documentation (cmp.config.window.bordered)}
             :preselect cmp.PreselectMode.Item
             :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
             :mapping (cmp.mapping.preset.insert mappings)
             :sources (cmp.config.sources (unpack sources))
             :sorting {: comparators}
             :experimental {:ghost_text true}})
 (let [cmp-git (require :cmp_git)]
   (cmp-git.setup)))

[;; Autocomplete
 (lazy :hrsh7th/nvim-cmp {:dependencies [:hrsh7th/cmp-nvim-lsp
                                         :hrsh7th/cmp-nvim-lsp-signature-help
                                         :hrsh7th/cmp-buffer
                                         :hrsh7th/cmp-path
                                         (lazy :hrsh7th/cmp-vsnip
                                               {:dependencies [:hrsh7th/vim-vsnip]})
                                         :lukas-reineke/cmp-under-comparator
                                         (lazy :petertriho/cmp-git
                                               {:dependencies [:nvim-lua/plenary.nvim]})
                                         :f3fora/cmp-spell
                                         (lazy :PaterJason/cmp-conjure {:dependencies [:Olical/conjure]})]

                          : config})
 ;; Snippets
 (lazy :hrsh7th/vim-vsnip {:dependencies [:rafamadriz/friendly-snippets]})]
