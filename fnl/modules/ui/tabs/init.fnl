(import-macros {: lazy} :macros)

(fn init []
  (vim.api.nvim_create_autocmd [:BufAdd :TabEnter]
                               {:pattern "*"
                                :group (vim.api.nvim_create_augroup :BufferLineLazyLoading
                                                                    {})
                                :callback (fn []
                                            (local count
                                                   (length (vim.fn.getbufinfo {:buflisted 1})))
                                            (when (>= count 2)
                                              ((. (require :lazy) :load) :bufferline.nvim)))}))

(lazy :akinsho/bufferline.nvim
      {:opts {:options {:numbers :none
                        :diagnostics :nvim_lsp
                        :diagnostics_indicator (fn [total-count
                                                    level
                                                    diagnostics-dict]
                                                 (var s "")
                                                 (each [kind count (pairs diagnostics-dict)]
                                                   (set s
                                                        (string.format "%s %s%d"
                                                                       s
                                                                       (. _G.shared.diagnostic-icons
                                                                          kind)
                                                                       count)))
                                                 s)
                        :show_buffer_close_icons false
                        :show_close_icon false
                        :persist_buffer_sort true
                        :separator_style ["│" "│"]
                        :indicator {:icon "│" :style :icon}
                        :enforce_regular_tabs false
                        :always_show_bufferline false
                        :offsets [{:filetype :NvimTree
                                   :text :Files
                                   :text_align :center}
                                  {:filetype :DiffviewFiles
                                   :text "Source Control"
                                   :text_align :center}]}}})
