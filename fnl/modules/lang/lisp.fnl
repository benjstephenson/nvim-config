(import-macros {: lazy} :macros)

[(lazy :gpanders/nvim-parinfer {:ft _G.shared.lisp-filetypes})
 ;; Interactive evaluation
 (lazy :Olical/conjure {:ft _G.shared.lisp-filetypes})
 ;; Clojure interactive evaluation
 (lazy :clojure-vim/vim-jack-in
       {:ft :clojure
        :dependencies [:tpope/vim-dispatch :radenling/vim-dispatch-neovim]})]
