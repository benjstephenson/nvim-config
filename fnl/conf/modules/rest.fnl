(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (import-macros {: map!} :themis.keybind)
  (. (require :rest-nvim) :setup)
  (map! [n] :<localleader>rr :<plug>RestNvim {:desc "Run under cursor"})
  (map! [n] :<localleader>rp :<plug>RestNvimPreview
        {:desc "Preview cURL command"}))

(pack :rest-nvim/rest.nvim {:ft [:http]
                            :dependencies [:nvim-lua/plenary.nvim]
                            : config})
