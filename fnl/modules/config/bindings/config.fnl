(import-macros {: map! : buf-map! : augroup! : autocmd! : clear! : let!}
               :macros)

;(import-macros {: augroup! : autocmd! : clear!} :core.event)
;(import-macros {: let!} :core.var)

;; Set leader to space by default

(let! mapleader " ")
(let! maplocalleader ",")

;; easier command line mode + 
(map! [n] ";" ":" {:desc :vim-ex})

;; * LSP symbols in project (telescope)

(map! [n] "<leader>`" "<cmd>e#<CR>" {:desc "Switch to last buffer"})
(map! [n] "<leader>," "<cmd>Telescope buffers<CR>" {:desc "Switch buffer"})

(map! [n] "<leader>;" :<cmd>ConjureEval<CR> {:desc "Eval expression"})

(map! [n] :<leader>x :<cmd>Scratch<CR> {:desc "New scratch buffer"})

;; X (n)Org capture
;(map! [n] :<leader>X "<cmd>Neorg gtd capture<CR>" {:desc "Neorg capture"})

;; ~ Open messages

(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>"
      {:desc "Find file in project"})

(map! [n] "<leader>'" "<cmd>Telescope resume<CR>" {:desc "Resume last search"})

(map! [n] :<leader>. "<cmd>Telescope find_files hidden=true<CR>"
      {:desc "Find all files"})

(map! [n] :<leader>/ "<cmd>Telescope live_grep<CR>" {:desc "Search project"})

(map! [n] "<leader>:" "<cmd>Telescope commands<CR>" {:desc :M-x})

(map! [n] :<leader>< "<cmd>Telescope buffers<CR>" {:desc "Switch Buffer"})

;;; TAB +workspace

(map! [n] :<leader><tab><tab> "<cmd>set showtabline=2<CR>"
      {:desc "Display tab bar"})

(map! [n] :<leader><tab>. "<cmd>Telescope telescope-tabs list_tabs<CR>"
      {:desc "Switch tab"})

(map! [n] :<leader><tab>0 :<cmd>tablast<CR> {:desc "Switch to final tab"})
(map! [n] :<leader><tab>1 :<cmd>tabn1<CR> {:desc "Switch to 1st tab"})
(map! [n] :<leader><tab>2 :<cmd>tabn2<CR> {:desc "Switch to 2st tab"})
(map! [n] :<leader><tab>3 :<cmd>tabn3<CR> {:desc "Switch to 3st tab"})
(map! [n] :<leader><tab>4 :<cmd>tabn4<CR> {:desc "Switch to 4st tab"})
(map! [n] :<leader><tab>5 :<cmd>tabn5<CR> {:desc "Switch to 5st tab"})
(map! [n] :<leader><tab>6 :<cmd>tabn6<CR> {:desc "Switch to 6st tab"})
(map! [n] :<leader><tab>7 :<cmd>tabn7<CR> {:desc "Switch to 7st tab"})
(map! [n] :<leader><tab>8 :<cmd>tabn8<CR> {:desc "Switch to 8st tab"})
(map! [n] :<leader><tab>9 :<cmd>tabn9<CR> {:desc "Switch to 9st tab"})
(map! [n] :<leader><tab>9 :<cmd>tabn9<CR> {:desc "Switch to 9st tab"})
(map! [n] "<leader><tab>[" :<cmd>tabn<CR> {:desc "Previous tab"})
(map! [n] "<leader><tab>]" :<cmd>tabp<CR> {:desc "Next tab"})
(map! [n] "<leader><tab>]" :<cmd>tabp<CR> {:desc "Next tab"})
(map! [n] "<leader><tab>`" "<cmd>tabn#<CR>" {:desc "Switch to last tab"})
(map! [n] :<leader><tab>d :<cmd>tabclose<CR> {:desc "Delete this tab"})

(map! [n] :<leader><tab>l
      "<cmd>:lua require'telescope'.extensions.project.project{}<CR>"
      {:desc "List projects"})

(map! [n] :<leader><tab>n :<cmd>tabnew<CR> {:desc "New tab"})

(map! [n] :<leader><tab>r "<cmd>Telescope xray23 listCR>"
      {:desc "View all sessions"})

(map! [n] :<leader><tab>s "<cmd>Telescope xray23 saveCR>"
      {:desc "Save current session"})

(map! [n] :<leader><tab>x :<cmd>tabclose<CR> {:desc "Delete this tab"})

;;; a +actions

;;; b +buffer

;; - Toggle narrowing

(map! [n] "<leader>b[" :<cmd>bprevious<CR> {:desc "Previous buffer"})
(map! [n] :<leader>bl "<cmd>e#<CR>" {:desc "Switch to last buffer"})
(map! [n] :<leader>bp :<cmd>bprevious<CR> {:desc "Previous buffer"})
(map! [n] "<leader>b]" :<cmd>bnext<CR> {:desc "Next buffer"})
(map! [n] :<leader>bn :<cmd>bnext<CR> {:desc "Next buffer"})

(map! [n] :<leader>bb "<cmd>Telescope buffers<CR>" {:desc "Switch buffer"})

(map! [n] :<leader>bB "<cmd>Telescope telescope-tabs list_tabs<CR>"
      {:desc "Switch tab"})

;; c Clone buffer

(map! [n] :<leader>bd :<cmd>bw<CR> {:desc "Delete buffer"})
(map! [n] :<leader>bz :<cmd>bw<CR> {:desc "Bury buffer"})

;; i ibuffer
;; I ibuffer workspace

(map! [n] :<leader>bk :<cmd>bd<CR> {:desc "Kill buffer"})
(map! [n] :<leader>bK "<cmd>%bd<CR>" {:desc "Kill all buffers"})

;; m Set bookmark
;; M Delete bookmark 

(map! [n] :<leader>bK :<cmd>enew<CR> {:desc "New empty buffer"})
(map! [n] :<leader>bO "<cmd>%bd|e#<CR>" {:desc "Kill other buffers"})
(map! [n] :<leader>br :<cmd>u0<CR> {:desc "Revert buffer"})

;; R Rename buffer

(map! [n] :<leader>bs :<cmd>w<CR> {:desc "Save buffer"})
(map! [n] :<leader>bS :<cmd>wa<CR> {:desc "Save all buffers"})
(map! [n] :<leader>bu
      "<cmd>com -bar W exe 'w !sudo tee >/dev/null %:p:S' | setl nomod<CR>"
      {:desc "Save buffer as root"})

(map! [n] :<leader>bx :<cmd>Scratch<CR> {:desc "New scratch buffer"})

(map! [n] :<leader>bX "<cmd>buffer *scratch*<CR>"
      {:desc "Switch to scratch buffer"})

(map! [n] :<leader>by "<cmd>%y+<CR>" {:desc "Yank buffer"})

;;; c +code

(map! [n] :<leader>ca `(vim.lsp.buf.code_action) {:desc "LSP Code actions"})

(map! [n] :<leader>cd `(vim.lsp.buf.definition)
      {:desc "LSP Jump to definition"})

(map! [n] :<leader>cD `(vim.lsp.buf.references)
      {:desc "LSP Jump to references"})

(map! [n] :<leader>ce :<cmd>ConjureEvalBuf<CR> {:desc "Evaluate buffer"})

(map! [v] :<leader>ce :<cmd>ConjureEval<CR> {:desc "Evaluate region"})

(map! [n] :<leader>cE :<cmd>ConjureEvalReplaceForm<CR>
      {:desc "Evaluate & replace form"})

(map! [n] :<leader>cf `(vim.lsp.buf.format {:async true})
      {:desc "Format buffer"})

(map! [v] :<leader>cf `(vim.lsp.buf.range_formatting)
      {:desc "LSP Format region"})

;; i LSP Find implementations (telescope)
;; D LSP Jump to references (telescope)
;; j LSP Jump to symbol in file (telescope)
;; J LSP Jump to symbol in workspace (telescope)

(map! [n] :<leader>ck `(vim.lsp.buf.hover) {:desc "LSP View documentation"})

;; l +lsp
(map! [n] :<leader>ck
      `(vim.lsp.buf.code_action {:source {:organizeImports true}})
      {:desc "LSP Organize Imports"})

(map! [n] :<leader>cr vim.lsp.buf.rename {:desc "LSP Rename"})

(map! [n] :<leader>cw "<cmd>%s/\\s\\+$//e<CR>"
      {:desc "Delete trailing whitespace"})

(map! [n] :<leader>cW "<cmd>v/\\_s*\\S/d<CR>"
      {:desc "Delete trailing newlines"})

(map! [n] :<leader>cc :<cmd>make<CR> {:desc "Compile with quickfix list"})

(map! [n] :<leader>cC :<cmd>lmake<CR {:desc "Compile with location list"})

(map! [n] :<leader>cq :<cmd>copen<cr> {:desc "Open quickfix list"})

(map! [n] :<leader>cQ :<cmd>cclose<cr> {:desc "Close quickfix list"})

(augroup! quickfix-mappings (clear!)
          (autocmd! FileType qf
                    #(buf-map! [n] :<leader>cq :<cmd>cclose<cr>
                               {:desc "Close quickfix list"}))
          (autocmd! FileType qf
                    #(buf-map! [n] :dd
                               #(let [current-item (vim.fn.line ".")
                                      current-list (vim.fn.getqflist)
                                      new-list (doto current-list
                                                 (table.remove current-item))]
                                  (vim.fn.setqflist new-list :r)))))

;; x Local diagnostics (telescope)
;; x Project diagnostics (telescope)

;;; -- f +file (hydra)

(map! [n] :<leader>fc "<cmd>e .editorconfig<CR>"
      {:desc "Open project editorconfig"})

(map! [n] :<leader>fC "<cmd>%y+<CR>" {:desc "Copy file contents"})
(map! [n] :<leader>fC "<cmd>%y+<CR>" {:desc "Copy file contents"})

;; d Find Directory

(map! [n] :<leader>fD :<cmd>bw<CR> {:desc "Delete this file"})
(map! [n] :<leader>ff "<cmd>r! echo %<CR>" {:desc "Current file name"})
(map! [n] :<leader>fF "<cmd>r! echo %:p<CR>" {:desc "Current file path"})
(map! [n] :<leader>fl ":grep " {:desc "Locate file (rg)"})
(map! [n] :<leader>fs :<cmd>w<CR> {:desc "Save file"})
(map! [n] :<leader>fS ":w " {:desc "Save file as"})
(map! [n] :<leader>fp :<cmd>R!echo<CR> {:desc "Vi ex path"})
(map! [n] :<leader>fr "<C-R><C-O> " {:desc "From register"})
(map! [n] :<leader>fy "<C-R><C-O>+ " {:desc "From clipboard"})

;(map! [n] :<leader>fy "<cmd>let @+ = expand('%')<CR>"
;      {:desc "Yank replative path"})

(map! [n] :<leader>fY "<cmd>let @+ = expand('%:p')<CR>"
      {:desc "Yank full path"})

;;; -- g +git (hydra)

;;; h +help 

(map! [n] :<leader>h<CR> :<cmd>help<CR> {:desc "Vim Help"})
(map! [n] "<leader>h'" :<cmd>ascii<CR> {:desc "Descibe Char (ascii)"})
(map! [n] :<leader>h? "<cmd>help help<CR>" {:desc "Help for help"})
(map! [n] :<leader>hb "<cmd>Telescope keymaps<CR>" {:desc "List keymaps"})

(map! [n] :<leader>hc "<cmd>help encoding-values<CR>" {:desc "List encodings"})
(map! [n] :<leader>hd "<cmd>help diagnostic.txt<CR>"
      {:desc "Help for diagnostics"})

(map! [n] :<leader>he "<cmd>:messages<CR>" {:desc "View message history"})

(map! [n] :<leader>hF :<cmd>hi<CR> {:desc "List highlights/faces"})
(map! [n] :<leader>hi ":help " {:desc "Help for _"})
(map! [n] :<leader>hI "<cmd>help x-input-method<CR>"
      {:desc "Help for X11 input methods"})

(map! [n] :<leader>hl :<cmd>hist<CR> {:desc "List command history"})

;; o describe symbol
;; O lookup online

;; r +reload
;; re env
;; rf font
;; rp packages
;; rr reload
;; rt theme

;; s describe syntax
;; S info lookup symbol
;; t load theme

(map! [n] :<leader>ht "<cmd>Telescope colorscheme enable_preview=true<CR>"
      {:desc "Load theme"})

;(map! [n] :<leader>hT `(profile.toggle) {:desc "Toggle profiler"})

;; u help autodefs
;; v describe-variable 
;; w where is
;; W man or women

;;; i +insert

;; s symbols (telescope)

;;; n +notes

;; * search notes for symbol
;; a Agenda
;; b Bibliographic notes
;; c Toggle last clock 
;; C Cancel current clock
;; d Open deft
;; e Noter
;; f Find file in notes
;; F Browse notes
;; l Store link
;; m Tags search
;; n Capture
;; N Goto capture
;; o Active clock
;; r +roam
;; s Search notes
;; S Search agenda headlines
;; t Todo list
;; v View search 
;; y Export note to clipboard
;; Y Export note to clipboard as

;;; o +open

;; - Dired

;(map! [n] :<leader>oA "<cmd>Neorg gtd views<CR>" {:desc :Agenda})
;(map! [n] :<leader>oaa "<cmd>Neorg gtd views<CR>" {:desc :Agenda})

;; (map! [n] :<leader>oa "<cmd><CR>" {:desc "Tags search"})
;; (map! [n] :<leader>oa "<cmd><CR>" {:desc "Todo list"})
;; (map! [n] :<leader>oa "<cmd><CR>" {:desc "View search"})))

(map! [n] :<leader>ob "<cmd>!open '%'<CR>" {:desc "Open in browser"})

(map! [n] :<leader>od "<cmd>lua require('dapui').toggle()CR>"
      {:desc "Toggle debugger ui"})

(map! [n] :<leader>od ":Devcontainer" {:desc "Docker commands"})

;; e Open fshell split
;; E Open fshell buffer
;; f New window
;; F Select window

(when (= (vim.fn.has :mac) 1)
  (map! [n] :<leader>oo "<cmd>!open %:p:h<CR>" {:desc "Reveal file in finder"})
  (map! [n] :<leader>oO "<cmd>!open .<CR>" {:desc "Reveal project in finder"}))

(map! [n] :<leader>od :<cmd>Devcontainer {:desc "Docker commands"})

(map! [n] :<leader>or :<cmd>ConjureLogToggle<CR> {:desc "Conjure log split"})

(map! [n] :<leader>ot :<cmd>ToggleTerm<CR> {:desc "Open term split"})

(map! [n] :<leader>oT :<cmd>term<CR> {:desc "Open term buffer"})
;;; p +project

;;; q +quit/session 

;;; r +remote

;;; s +search

;;; t +toggle

;;; w +window

;;; -- m +filetype (hydra

;; non-doom
