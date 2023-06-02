(import-macros {: pack} :themis.pack.lazy)

[(pack :folke/noice.nvim
       {:dependencies [:MunifTanjim/nui.nvim :rcarriga/nvim-notify]
        :opts {:cmdline {:view :cmdline}
               :lsp {:override {:vim.lsp.util.convert_input_to_markdown true
                                :vim.lsp.util.stylize_markdown true
                                :cmp.entry.get_documentation true}
                     :signature {:enabled false}}
               :presets {:bottom_search true
                         :command_palette true
                         :inc_rename true
                         :lsp_doc_border true}}})]
