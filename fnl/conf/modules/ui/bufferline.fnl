(import-macros {: pack} :themis.pack.lazy)

(pack :akinsho/bufferline.nvim
      {:opts {:options {:indicator {:style :underline}
                        :diagnostics :nvim_lsp
                        :separator_style :padded_slope
                        :max_name_length 25}}})
