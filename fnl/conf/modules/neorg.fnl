(import-macros {: pack} :themis.pack.lazy)

(pack :vhyrro/neorg
      {:config {:load {:core.defaults {}
                       :core.norg.concealer {}
                       :core.norg.completion {:config {:engine :nvim-cmp}}
                       :core.norg.dirman {:config {:workspaces {:work :/Users/bste/ghq/github.com/benjstephenson/notes.neorg}}}}}})
