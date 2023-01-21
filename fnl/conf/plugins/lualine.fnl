(import-macros {: pack} :themis.pack.lazy)

    ; function(msg)
    ;   msg = msg or "LS Inactive"
    ;   local buf_clients = vim.lsp.buf_get_clients()
    ;   if next(buf_clients) == nil then
    ;     -- TODO: clean up this if statement
    ;     if type(msg) == "boolean" or #msg == 0 then
    ;       return "LS Inactive"
    ;     end
    ;     return msg
    ;   end
    ;   local buf_ft = vim.bo.filetype
    ;   local buf_client_names = {}
    ;
    ;   -- add client
    ;   for _, client in pairs(buf_clients) do
    ;     if client.name ~= "null-ls" then
    ;       table.insert(buf_client_names, client.name)
    ;     end
    ;   end
    ;
    ;   -- add formatter
    ;   -- local formatters = require "lvim.lsp.null-ls.formatters"
    ;   -- local supported_formatters = formatters.list_registered(buf_ft)
    ;   -- vim.list_extend(buf_client_names, supported_formatters)
    ;
    ;   -- -- add linter
    ;   -- local linters = require "lvim.lsp.null-ls.linters"
    ;   -- local supported_linters = linters.list_registered(buf_ft)
    ;   -- vim.list_extend(buf_client_names, supported_linters)
    ;
    ;   local unique_client_names = vim.fn.uniq(buf_client_names)
    ;   return "[" .. table.concat(unique_client_names, ", ") .. "]"
    ; end,)

(fn lsp-status []
  (fn render [names]
    (if (= (length names) 0)
      "Server Inactive"
      (table.concat names ", ")))
  (-> (icollect [_ client (pairs (vim.lsp.buf_get_clients))]
              (. client :name))
      (render)))

(lsp-status)


(fn config []
  (local lualine (require :lualine))
  (lualine.setup {:options {:globalstatus true
                            :theme :auto
                            :icons_enabled true
                            :component_separators { :left "" :right ""}
                            :section_separators { :left "" :right ""}
                            :always_divide_middle true
                            :globalstatus false
                            :disabled_filetypes {:winbar ["qf"]}}
                  :winbar {:lualine_a [:location]
                           :lualine_b [:progress]
                           :lualine_c [:filename]}
                  :inactive_winbar {:lualine_a [:location]
                                    :lualine_b [:progress]
                                    :lualine_c [:filename]}
                  :sections {:lualine_a [:mode]
                             :lualine_b [:banch :diff :diagnostics]
                             :lualine_c [:filename]
                             :lualine_x [lsp-status :encoding :fileformat]
                             :lualine_y [:progress]
                             :lualine_z []}}))

(pack "nvim-lualine/lualine.nvim" {:dependencies ["kyazdani42/nvim-web-devicons"]
                                   : config})
