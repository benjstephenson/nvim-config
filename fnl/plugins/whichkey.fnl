(import-macros { : lazy } :macros)

(fn whichkey-setup []
  (local wk (require :which-key))
  (wk.setup {:icons {:breadcrumb "»" :separator "->" :group "+"}
                   :popup_mappings {:scroll_down :<c-d> :scroll_up :<c-u>}
                   :window {:border :solid}
                   :layout {:spacing 3}
                   :hidden [:<silent> :<cmd> :<Cmd> :<CR> :call :lua "^:" "^ "]
                   :triggers_blacklist {:i [:j :k] :v [:j :k]}
                   :height {:min 0 :max 6}
                   :align :center})

  (wk.register {:<leader><tab> {:name :+workspace}})
  (wk.register {:<leader>b {:name :+buffer}})
  (wk.register {:<leader>c {:name :+code}})
  (wk.register {:<leader>cl {:name :+LSP}})
  (wk.register {:<leader>f {:name :+file}})
  (wk.register {:<leader>g {:name :+git}})
  (wk.register {:<leader>h {:name :+help}})
  (wk.register {:<leader>n {:name :+notes}})
  (wk.register {:<leader>o {:name :+open}})
  (wk.register {:<leader>oa {:name :+agenda}})
  (wk.register {:<leader>p {:name :+project}})
  (wk.register {:<leader>q {:name :+quit/session}})
  (wk.register {:<leader>r {:name :+remote}})
  (wk.register {:<leader>s {:name :+search}})
  (wk.register {:<leader>t {:name :+toggle}})
  (wk.register {:<leader>w {:name :+window}})
  (wk.register {:<leader>d {:name :+debug}})
)

(lazy :folke/which-key.nvim {:config whichkey-setup})
