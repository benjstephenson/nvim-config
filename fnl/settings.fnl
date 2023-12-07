(import-macros {: set! : let!} :macros)

(fn escape [combination]
  (vim.api.nvim_replace_termcodes combination true true true))

;;; ====================
;;; Editor configuration
;;; ====================
;; File configuration
; Do not write backups
(set! nowritebackup)
; Do not create swap files
(set! noswapfile)

;; Indentation configuration
; Use spaces instead of tabs
(set! expandtab)
; Number of spaces used for each <tab> and auto-indent
(set! softtabstop -1)
(set! shiftwidth 2)
(set! tabstop 2)

;; Wrapping configuration
; Do not break words at the middle
(set! linebreak)
; Maintain indentation on break
(set! breakindent)
; Add characters after wrap
(set! breakindentopt ["shift:2"])
; Show character after wrap
(set! showbreak "↳ ")

;; Formatting configuration
(set! formatoptions [:q :j])

;; Spell-checking configuration
(set! spell)
(set! spelllang [:en])
(set! spelloptions [:camel :noplainbuffer])
(let [config-folder (vim.fn.stdpath :config)
      spell-folder (.. config-folder :/spell)]
  (set! spellfile+ (.. spell-folder :/en.utf-8.add))
  (set! spellfile+ (.. spell-folder :/es.utf-8.add)))

;; Undo persistence
(set! undofile)

;; CursorHold delay
(set! updatetime 250)

;; External configuration file
(set! exrc)

;;; ======================
;;; Terminal configuration
;;; ======================
;; Mouse support
(set! mouse :a)

;;; ====================
;;; Visual configuration
;;; ====================
;; True color
(set! termguicolors)
(set! background :dark)
(set! laststatus 3)
(vim.cmd.colorscheme :oxocarbon)

;; Stabilize lines
(set! splitkeep :screen)

;; Line number
(set! number)
(set! relativenumber)

;; Status configuration
(set! noshowmode)

;; Characters configuration
; Show whitespace characters
(set! list)
; Define characters to show
(set! listchars {:trail "·" :tab "→ " :nbsp "·"})

;; Sign column
; Always show sign column
(set! signcolumn "yes:1")

;; Fold configuration
; Enable folding
(set! foldenable)
; Display column for folds
(set! foldcolumn :1)
; Fold column characters
(set! fillchars {:eob " "
                 :fold " "
                 :foldopen ""
                 :foldsep " "
                 :foldclose ""})

; Start with everything unfolded
(set! foldlevel 99)
(set! foldlevelstart 99)

;;; ========================
;;; Completion configuration
;;; ========================
;; Insert-mode completion
(set! infercase)
(set! shortmess+ :c)

;; Command-mode completion
(set! wildcharm (string.byte (escape :<tab>)))
(set! wildignorecase)

;; Support fuzzy finding
(set! path ["." "**"])

;;; ==========================
;;; Command-mode configuration
;;; ==========================
;; Search and replace
(set! ignorecase)
(set! smartcase)

;; Substitution
(set! gdefault)

;;; ===========================
;;; Miscellaneous configuration
;;; ===========================
;; Diff-mode
(set! diffopt+ "linematch:60")

;; Lazy redraw
; (set! lazyredraw)

;; Timeout for mappings
(set! timeoutlen 400)

;; Grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")

;;; ===========================================
;;; Override configuration for floating windows
;;; ===========================================
;; Extend vim.lsp.util.open_floating_preview
;(local open_floating_preview vim.lsp.util.open_floating_preview)
;(fn vim.lsp.util.open_floating_preview [...]
;  ;; Execute original function
;  (local (bufnr winid) (open_floating_preview ...))
;  ;; Set window-local options
;  (vim.api.nvim_win_set_option winid :breakindentopt "")
;  (vim.api.nvim_win_set_option winid :showbreak :NONE)
;  ;; Return the result of the original function
;  (values bufnr winid))
