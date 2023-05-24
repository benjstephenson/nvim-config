(import-macros {: pack} :themis.pack.lazy)
(import-macros {: set!} :themis.opt)

[(pack :anuvyklack/windows.nvim
       {:dependencies [:anuvyklack/middleclass :anuvyklack/animation.nvim]
        :config #(do
                   (set! winwidth 10)
                   (set! winminwidth 10)
                   (set! equalalways false)
                   (. (require :windows) :setup))})]
