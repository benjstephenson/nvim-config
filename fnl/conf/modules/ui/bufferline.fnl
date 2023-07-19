(import-macros {: pack} :themis.pack.lazy)

(pack :akinsho/bufferline.nvim
      {:opts {:options {:indicator {:style :underline}
                        :diagnostics :nvim_lsp
                        :separator_style :thick
                        :max_name_length 25
                        :show_close_icon false
                        :show_tab_indicators true}}})
