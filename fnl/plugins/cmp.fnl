(import-macros {: lazy} :macros)
(local {: kind-icons} (require :constants))

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
                   :<CR> (cmp.mapping.confirm)
                   ; {:select true})
                   :<Tab> (cmp.mapping (fn [fallback]
                                         (if (cmp.visible)
                                             (cmp.select_next_item)
                                             (fallback)))
                                       [:i :s])
                   :<S-Tab> (cmp.mapping (fn [fallback]
                                           (if (cmp.visible)
                                               (cmp.select_prev_item)
                                               (fallback)))
                                         [:i :s])})
  ;;; =======
  ;;; Sources
  ;;; =======
  (local sources
         [[{:name :nvim_lsp :keyword_lenth 3}
           {:name :nvim_lsp_signature_help}
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
    (let [icon (. kind-icons item.kind)]
      (set item.kind (.. (or icon "") " " item.kind)) ; Define menu labels
      (set item.menu (or (. source-labels entry.source.name) "")) ; Return the item
      item))

  ;;; =====
  ;;; Setup
  ;;; =====
  (cmp.setup {:completion {:keyword_length 3}
              :view {:entries {:name :custom :selection_order :near_cursor}}
              :formatting {:mode :symbol_text
                           :fields [:kind :abbr :menu]
                           :format format-item
                           :maxwidth 120}
              :window {:documentation (cmp.config.window.bordered)}
              :preselect cmp.PreselectMode.None
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
                                         :lukas-reineke/cmp-under-comparator
                                         (lazy :petertriho/cmp-git
                                               {:dependencies [:nvim-lua/plenary.nvim]})
                                         :f3fora/cmp-spell
                                         (lazy :PaterJason/cmp-conjure
                                               {:dependencies [:Olical/conjure]})]
                          : config})
 ;; Snippets
 (lazy :hrsh7th/vim-vsnip {:dependencies [:rafamadriz/friendly-snippets]})]
