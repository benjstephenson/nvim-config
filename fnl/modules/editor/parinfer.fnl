(import-macros {: lazy} :macros)

[(lazy :eraserhd/parinfer-rust {:lazy true :build "cargo build --release"})
 (lazy :harrygallagher4/nvim-parinfer-rust {:ft _G.shared.lisp-file-types})
 (lazy :gpanders/nvim-parinfer {:ft _G.shared.lisp-filetypes})]
