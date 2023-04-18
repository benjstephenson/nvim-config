(import-macros {: pack} :themis.pack.lazy)

(fn lsp-status []
  (fn render [names]
    (if (= (length names) 0) "Server Inactive"
        (table.concat names ", ")))

  (-> (icollect [_ client (pairs (vim.lsp.buf_get_clients))]
        (. client :name))
      (render)))

(fn get-navic-loc []
  (let [(ok? navic) (pcall require :nvim-navic)]
    (if ok?
        (navic.get_location))))

(fn config []
  (local lualine (require :lualine))
  (lualine.setup {:options {:globalstatus true
                            :theme :auto
                            :icons_enabled true
                            :component_separators {:left " " :right " "}
                            ;;:component_separators { :left "" :right ""}
                            :section_separators {:left "" :right ""}
                            :always_divide_middle true
                            :disabled_filetypes {:winbar [:qf :neotest-summary]}}
                  :winbar {:lualine_a [:progress]
                           :lualine_b [:location]
                           :lualine_c [get-navic-loc]}
                  :inactive_winbar {:lualine_a [] :lualine_b [] :lualine_c []}
                  :sections {:lualine_a [:mode]
                             :lualine_b [:branch :diff :diagnostics]
                             :lualine_c [:filename :searchcount]
                             :lualine_x [lsp-status
                                         :filetype
                                         :encoding
                                         :fileformat]
                             :lualine_y []
                             :lualine_z []}}))

(pack :nvim-lualine/lualine.nvim {:dependencies [:nvim-tree/nvim-web-devicons]
                                  : config})
