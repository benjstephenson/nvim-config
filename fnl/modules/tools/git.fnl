(import-macros {: lazy} :macros)

(fn git-signs-on-attach []
  (import-macros {: map! : set!} :macros)
;  (import-macros {: set!} :core.macros.opt)
  (local gs (require :gitsigns))
  ;; Navigation
  (map! [n] "]c" `(if (set! diff?)
                      "]c"
                      (do
                        (vim.schedule #(gs.next_hunk))
                        :<Ignore>)) {:expr true})
  (map! [n] "[c" `(if (set! diff?)
                      "[c"
                      (do
                        (vim.schedule #(gs.prev_hunk))
                        :<Ignore>)) {:expr true})
  ;; Actions
  (map! [nv] :<leader>gs "<cmd>Gitsigns stage_hunk<cr>")
  (map! [nv] :<leader>gr "<cmd>Gitsigns reset_hunk<cr>")
  (map! [n] :<leader>gS gs.stage_buffer {:desc "stage buffer"})
  (map! [n] :<leader>gu gs.undo_stage_hunk {:desc "stage hunk"})
  (map! [n] :<leader>gR gs.reset_buffer {:desc "reset buffer"})
  (map! [n] :<leader>gp gs.preview_hunk {:desc "preview hunk"})
  (map! [n] :<leader>gb `(gs.blame_line {:full true}) {:desc "blame line"})
  (map! [n] :<leader>gb gs.toggle_current_line_blame
        {:desc "toggle line blame"})
  (map! [n] :<leader>gd gs.diffthis {:desc :diff})
  (map! [n] :<leader>gD `(gs.diffthis "~"))
  (map! [n] :<leader>td gs.toggle_deleted {:desc "show deleted lines"})
  ;; Text object
  (map! [ox] :ih ":<C-U>Gitsigns select_hunk<cr>"))

[(lazy :TimUntersberger/neogit {:dependencies [:nvim-lua/plenary.nvim]})
 (lazy :lewis6991/gitsigns.nvim {:opts {:on_attach git-signs-on-attach}})
 (lazy :f-person/git-blame.nvim)
 (lazy :akinsho/git-conflict.nvim {:opts {:disable_diagnostics true}})]
