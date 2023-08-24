(import-macros {: lazy} :macros)

(lazy :krivahtoo/silicon.nvim
      {:build "./install.sh build"
       :opts {:font "Fira Code=16"
              :theme "Monokai Extended"
              :window_controls false
              :tab_width 2
              :pad_vert 0
              :pad_horiz 0}})
