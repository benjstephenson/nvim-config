(import-macros {: lazy : map!} :macros)

(fn config []
  (local rest (require :rest-nvim))
  (rest.setup {:result {:formatters {:html (fn [body]
                                             (vim.fn.system [:tidy :-i :-q "-"]
                                                            body))}}})
  (map! [n] :<localleader>rr :<plug>RestNvim {:desc "Run under cursor"})
  (map! [n] :<localleader>rp :<plug>RestNvimPreview
        {:desc "Preview cURL command"}))

(lazy :rest-nvim/rest.nvim {:ft [:http]
                            :dependencies [:nvim-lua/plenary.nvim]
                            : config})
