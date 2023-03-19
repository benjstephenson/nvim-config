(import-macros {: pack} :themis.pack.lazy)

(pack :akinsho/bufferline.nvim
      {:config {:options {:indicator {:style :underline}
                          :diagnostics :nvim_lsp
                          :separator_style :slant
                          :max_name_length 25}}})
