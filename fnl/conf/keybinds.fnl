(import-macros {: map!} :themis.keybind)

(local {: getbufinfo : getbufvar} vim.fn)

(local {: format} string)
(fn wildmenumode? [...]
  (= (vim.fn.wildmenumode ...) 1))

(fn empty? [xs]
  (= 0 (length xs)))

;;; =============
;;; Miscellaneous
;;; =============
;; Disable highlight on escape
(map! [n] :<esc> :<esc><cmd>noh<cr>)
;; Make `/` and `?` search inside selection
(map! [x] "/" "<esc>/\\%V")
(map! [x] "?" "<esc>?\\%V")

;;; ===============
;;; Quickfix window
;;; ===============
;; Open or focus the quickfix window
(map! [n] :<localleader>q :<cmd>copen<cr> {:desc "open quickfix"})
;; Close the quickfix window
(map! [n] :<localleader>Q :<cmd>cclose<cr> {:desc "close quickfix"})

;;; =========
;;; Tab pages
;;; =========
;; Create a new tab page
(map! [n] :<leader>tc :<cmd>tabnew<cr>)
;; List tabs
(map! [n] :<leader>tw :<cmd>tabs<cr>)
;; Navigate to the next tab page
(map! [n] :<leader>tn :<cmd>tabNext<cr>)
;; Navigate to the previous tab page
(map! [n] :<leader>tp :<cmd>tabprevious<cr>)
;; Kill current tab page
(map! [n] :<leader>t& :<cmd>tabclose<cr>)

;;; ========
;;; Wildmenu
;;; ========
;; Close the wildmenu
(map! [c] :<space> `(if (wildmenumode?) :<C-y> :<space>) {:expr true})

;;; ========
;;; Movement
;;; ========
;; Move words with <A-Right> and <A-Left>
(map! [nvo] :<A-Left> :b)
(map! [nvo] :<A-Right> :e)
(map! [i] :<A-Left> :<C-o>b)
(map! [i] :<A-Right> :<C-o>e<Right>)
(map! [c] :<A-Left> :<S-Left>)
(map! [c] :<A-Right> :<S-Right>)
;; Move to the beginning
(map! [nvo] :<C-h> "^")
(map! [nvo] :<C-left> "^")
(map! [i] :<C-h> :<C-o>^)
(map! [i] :<C-left> :<C-o>^)
(map! [c] :<C-h> :<home>)
(map! [c] :<C-left> :<home>)
;; Move to the end
(map! [nvo] :<C-l> "$")
(map! [nvo] :<C-right> "$")
(map! [i] :<C-l> :<C-o>$)
(map! [i] :<C-right> :<C-o>$)
(map! [c] :<C-l> :<end>)
(map! [c] :<C-right> :<end>)

;;; ============
;;; Text objects
;;; ============
;; Line object
; Inner line
(map! [xo] :il ":<C-u>normal! g_v^<cr>" {:silent true})

; Around line
(map! [xo] :al ":<C-u>normal! $v0<cr>" {:silent true})

;; Document object
; Inner document
(map! [x] :id ":<C-u>normal! G$Vgg0<cr>" {:silent true})

(map! [o] :id ":<C-u>normal! GVgg<cr>" {:silent true})

(map! [n] "<leader>;" :<cmd>Alpha<CR> {:desc :dashboard})
(map! [n] :<leader>h :<cmd>nohlsearch<CR> {:desc "no highlight"})
(map! [n] :<leader>x :<cmd>ToggleTerm<cr> {:desc :terminal})

;; Buffers)
(map! [n] :<leader>bj :<cmd>BufferLinePick<cr> {:desc :jump})
(map! [n] :<leader>bf #(vim.lsp.buf.format) {:desc :format})
(map! [n] :<leader>bp :<cmd>BufferLineCyclePrev<cr> {:desc :previous})
(map! [n] :<leader>bn :<cmd>BufferLineCycleNext<cr> {:desc :next})
(map! [n] :<leader>bc :<cmd>bd<CR> {:desc "close buffer"})
(map! [n] :<leader>bd :<cmd>bd!<CR> {:desc "force close buffer"})
(map! [n] :<leader>bC :<cmd>BufferCloseAllButCurrent<CR> {:desc "close others"})
(map! [n] :<leader>bh :<cmd>BufferLineCloseLeft<cr>
      {:desc "close all to the left"})

(map! [n] :<leader>bl :<cmd>BufferLineCloseRight<cr>
      {:desc "close all to the right"})

(map! [n] :<leader>bw :<cmd>w!<CR> {:desc :save})

;; Git
(map! [n] :<leader>gd "<cmd>Gitsigns diffthis HEAD<cr>" {:desc "git diff"})
(map! [n] :<leader>gg "<cmd>lua require 'user.lazygit'.lazygit_toggle()<cr>"
      {:desc :LazyGit})

(map! [n] :<leader>gn :<cmd>Neogit<cr> {:desc :neogit})
(map! [n] :<leader>gl "<cmd>lua require 'gitsigns'.blame_line()<cr>"
      {:desc :blame})
