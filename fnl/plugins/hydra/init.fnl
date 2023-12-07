;;(import-macros {: lazy} :macros)
;;
;;(fn setup-hydra []
;;  (require :conf.modules.hydra.options)
;;  (require :conf.modules.hydra.window)
;;  (require :conf.modules.hydra.telescope))
;;
;;(lazy :anuvyklack/hydra.nvim
;;       {:dependencies [:akinsho/bufferline.nvim
;;                       :jlanzarotta/bufexplorer
;;                       :sindrets/winshift.nvim
;;                       :mrjones2014/smart-splits.nvim
;;                       :szw/vim-maximizer
;;                       :TimUntersberger/neogit
;;                       :lewis6991/gitsigns.nvim
;;                       (lazy :anuvyklack/windows.nvim {:config true})]
;;        :config setup-hydra})
{}
