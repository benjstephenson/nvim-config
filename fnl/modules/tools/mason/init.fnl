(import-macros {: lazy} :macros)

[(lazy :williamboman/mason.nvim {:build ":MasonUpdate" :config true})
 (lazy :williamboman/mason-lspconfig.nvim
       {:opts {:automatic_installation true}
        :dependencies [:williamboman/mason.nvim]})]
