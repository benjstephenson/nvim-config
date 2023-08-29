(import-macros {: lazy} :macros)

(fn config []
  (let [silicon (require :silicon)]
       (silicon.setup {:font "Fira Code=16"
                       :theme "Monokai Extended"
                       :window_controls false
                       :tab_width 2
                       :pad_vert 0
                       :pad_horiz 0})))

(lazy :krivahtoo/silicon.nvim
      {:build "./install.sh build"
       : config})
