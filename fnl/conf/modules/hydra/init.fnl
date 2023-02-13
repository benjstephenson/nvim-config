(import-macros {: pack} :themis.pack.lazy)
(import-macros {: map!} :themis.keybind)

(fn setup-hydra []
  (require :conf.modules.hydra.options)
  (require :conf.modules.hydra.telescope))

;;(map! [n] :<leader>to options.activate {:desc "editor options"})
;;(map! [n] :<leader>F telescope.activate {:desc :telescope})))

[(pack :anuvyklack/hydra.nvim
       {:dependencies [:smart-splits.nvim
                       :gitsigns.nvim
                       :akinsho/bufferline.nvim
                       :jlanzarotta/bufexplorer
                       :sindrets/winshift.nvim
                       :mrjones2014/smart-splits.nvim
                       :szw/vim-maximizer
                       :TimUntersberger/neogit
                       :lewis6991/gitsigns.nvim]
        :config setup-hydra})]
