(set vim.notify
     (fn [msg level opts]
       (set vim.notify (_G.autoload :notify))
       (vim.notify msg level opts)
       (local {: load_extension} (_G.autoload :telescope))))

;(load_extension :notify)))
