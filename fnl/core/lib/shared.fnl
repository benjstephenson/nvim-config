(local userconfigs {})

(local databases-folder (.. (vim.fn.stdpath "data") "/databases"))

(local diagnostic-icons {:error " "
              :warn  " "
              :info  " "
              :hint  " "
              :ok    " "})

(local kind-icons {:Text "  "
                 :Method "  "
                 :Function "  "
                 :Constructor "  "
                 :Field "  "
                 :Variable "  "
                 :Class "  "
                 :Interface "  "
                 :Module "  "
                 :Property "  "
                 :Unit "  "
                 :Value "  "
                 :Enum "  "
                 :Keyword "  "
                 :Snippet "  "
                 :Color "  "
                 :File "  "
                 :Reference "  "
                 :Folder "  "
                 :EnumMember "  "
                 :Constant "  "
                 :Struct "  "
                 :Event "  "
                 :Operator "  "
                 :Copilot "  "
                 :TypeParameter "  "})


(local lisp-filetypes [:fennel :clojure :lisp :racket :scheme :janet :hy])

(local border [["🭽" :FloatBorder]
               ["▔" :FloatBorder]
               ["🭾" :FloatBorder]
               ["▕" :FloatBorder]
               ["🭿" :FloatBorder]
               ["▁" :FloatBorder]
               ["🭼" :FloatBorder]
               ["▏" :FloatBorder]])


(tset _G :shared {: userconfigs
                  : databases-folder
                  : diagnostic-icons
                  : kind-icons
                  : lisp-filetypes
                  : border})
