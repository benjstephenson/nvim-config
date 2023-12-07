(import-macros {: lazy} :macros)
(local {: lisp-filetypes} (require :constants))

[;; Interactive evaluation
 (lazy :Olical/conjure {:ft lisp-filetypes})]

;; Clojure interactive evaluation
;(lazy :clojure-vim/vim-jack-in
;      {:ft :clojure
;       :dependencies [:tpope/vim-dispatch :radenling/vim-dispatch-neovim]})]
