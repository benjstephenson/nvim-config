(import-macros {: pack} :themis.pack.lazy)

(pack :vhyrro/neorg
      {:config {:load {:core.defaults {}
                       :core.concealer {}
                       :core.completion {:config {:engine :nvim-cmp}}
                       :core.dirman {:config {:workspaces {:work :/Users/bste/ghq/github.com/benjstephenson/notes.neorg}}}}}})
