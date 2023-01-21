(import-macros {: pack} :themis.pack.lazy)

(fn setup-hydra []
  (require :conf.plugins.hydra.options)
  (require :conf.plugins.hydra.telescope))


[(pack "anuvyklack/hydra.nvim" {:dependencies ["smart-splits.nvim"
                                               "gitsigns.nvim"
                                               "akinsho/bufferline.nvim"
                                               "jlanzarotta/bufexplorer"
                                               "sindrets/winshift.nvim"
                                               "mrjones2014/smart-splits.nvim"
                                               "szw/vim-maximizer"
                                               "TimUntersberger/neogit"
                                               "lewis6991/gitsigns.nvim"]
                                :config setup-hydra})]
