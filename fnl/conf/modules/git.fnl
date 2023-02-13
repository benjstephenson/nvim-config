(import-macros {: pack} :themis.pack.lazy)

(fn git-signs-on-attach []
  (import-macros {: map!} :themis.keybind)
  (import-macros {: set!} :themis.opt)
  (local gs (require :gitsigns))
  ;; Navigation
  (map! [n] "]c" `(if (set! diff?) "]c"
                      (do
                        (vim.schedule #(gs.next_hunk))
                        :<Ignore>)) {:expr true})
  (map! [n] "[c" `(if (set! diff?) "[c"
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

[(pack :lewis6991/gitsigns.nvim {:config {:on_attach git-signs-on-attach}})
 (pack :f-person/git-blame.nvim)
 (pack :lambdalisue/gin.vim {:dependencies [:vim-denops/denops.vim]})
 (pack :akinsho/git-conflict.nvim {:config {:disable_diagnostics true}})]
