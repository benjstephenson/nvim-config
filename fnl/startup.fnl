(import-macros {: let! } :macros)
(local {: executable?} (require :lib))

(local default-plugins [:2html_plugin
                        :bugreport
                        :compiler
                        :ftplugin
                        :getscript
                        :getscriptPlugin
                        :gzip
                        :logipat
                        :matchit
                        :netrw
                        :netrwFileHandlers
                        :netrwPlugin
                        :netrwSettings
                        :optwin
                        :rplugin
                        :rrhelper
                        :spellfile_plugin
                        :synmenu
                        :syntax
                        :tar
                        :tarPlugin
                        :tutor
                        :vimball
                        :vimballPlugin
                        :zip
                        :zipPlugin])
(each [_ plugin (pairs default-plugins)] (tset vim.g (.. :loaded_ plugin) 1))

(local default-providers [:node :perl :ruby])
(each [_ provider (ipairs default-providers)]
  (tset vim.g (.. :loaded_ provider :_provider) 0))


;; add python provider and mason binaries
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :config) :/bin))
(let! python3_host_prog
      (if (executable? :python) (vim.fn.exepath :python)
          (executable? :python3) (vim.fn.exepath :python3)
          nil))

(require :settings)
(require :line)
(require :events)
(require :keybinds)

