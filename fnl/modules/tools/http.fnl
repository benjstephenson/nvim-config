(import-macros {: lazy : map!} :macros)

(fn config []
  (local rest (require :rest-nvim))
  (rest.setup {:result_split_in_place true
               :result {:formatters {:json :jq
                                     :html (fn [body]
                                             (vim.fn.system [:tidy :-i :-q "-"]
                                                            body))}}})
  (map! [n] :<localleader>rr :<plug>RestNvim {:desc "Run under cursor"})
  (map! [n] :<localleader>rp :<plug>RestNvimPreview
        {:desc "Preview cURL command"}))

(lazy :rest-nvim/rest.nvim {:ft [:http]
                            :commit :8b62563
                            :dependencies [:nvim-lua/plenary.nvim]
                            : config})
