(import-macros {: lazy} :macros)
(local {: lisp-filetypes} (require :constants))

; [(lazy :eraserhd/parinfer-rust {:lazy true :build "cargo build --release"})
; (lazy :harrygallagher4/nvim-parinfer-rust {:ft _G.shared.lisp-filetypes}))
(lazy :gpanders/nvim-parinfer {:ft lisp-filetypes})
