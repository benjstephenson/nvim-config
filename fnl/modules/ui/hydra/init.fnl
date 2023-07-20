(import-macros {: pack} :core.macros.lazy)
(import-macros {: map!} :core.macros.lazy)
(import-macros {: set!} :core.opt)

(fn setup-hydra []
  (require :conf.modules.hydra.options)
  (require :conf.modules.hydra.window)
  (require :conf.modules.hydra.telescope))

[(pack :anuvyklack/hydra.nvim
       {:dependencies [:akinsho/bufferline.nvim
                       :jlanzarotta/bufexplorer
                       :sindrets/winshift.nvim
                       :mrjones2014/smart-splits.nvim
                       :szw/vim-maximizer
                       :TimUntersberger/neogit
                       :lewis6991/gitsigns.nvim
                       (pack :anuvyklack/windows.nvim {:config true})]
        :config setup-hydra})]
