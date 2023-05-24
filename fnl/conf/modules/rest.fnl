(import-macros {: pack} :themis.pack.lazy)
(import-macros {: map!} :themis.keybind)

(fn config []
  (local rest (require :rest-nvim))
  (rest.setup {:result {:formatters {:html (fn [body]
                                             (vim.fn.system [:tidy :-i :-q "-"]
                                                            body))}}})
  (map! [n] :<localleader>rr :<plug>RestNvim {:desc "Run under cursor"})
  (map! [n] :<localleader>rp :<plug>RestNvimPreview
        {:desc "Preview cURL command"}))

(pack :rest-nvim/rest.nvim {:ft [:http]
                            :dependencies [:nvim-lua/plenary.nvim]
                            : config})
