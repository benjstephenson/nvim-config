(local databases-folder (.. (vim.fn.stdpath :data) :/databases))

(local diagnostic-icons {:error " "
                         :warn " "
                         :info " "
                         :hint "󰌶 "
                         :ok " "})

(local kind-icons {:Branch " "
                   :Class " "
                   :Color " "
                   :Constant " "
                   :Constructor " "
                   :Copilot " "
                   :Enum " "
                   :EnumMember " "
                   :Event " "
                   :Field " "
                   :File " "
                   :Folder " "
                   :Function " "
                   :Interface " "
                   :Keyword " "
                   :Merge " "
                   :Method " "
                   :Module " "
                   :Operator " "
                   :Property " "
                   :Reference " "
                   :Save " "
                   :Snippet " "
                   :Struct " "
                   :TypeParameter " "
                   :Unit " "
                   :Value " "
                   :Variable " "
                   :Test " "
                   :Text " "})

(local lisp-filetypes [:fennel :clojure :lisp :racket :scheme :janet :hy])

(local border [["🭽" :FloatBorder]
               ["▔" :FloatBorder]
               ["🭾" :FloatBorder]
               ["▕" :FloatBorder]
               ["🭿" :FloatBorder]
               ["▁" :FloatBorder]
               ["🭼" :FloatBorder]
               ["▏" :FloatBorder]])

{: databases-folder
 : diagnostic-icons
 : kind-icons
 : lisp-filetypes
 : border}
 
