(import-macros {: lazy} :macros)

 (lazy :sheerun/vim-polyglot
       {:init #(do
                 (import-macros {: let!} :macros)
                 (let! polyglot_disabled [:fennel :autoindent :sensible]))})
