(import-macros {: tbl? : nil?} :themis.lib.types)
(import-macros {: pack} :themis.pack.lazy)

(require :conf.constants)
(require :conf.settings)

(fn load-plugins! []
  (local plugins-path (.. (vim.fn.stdpath :config) :/fnl/conf/modules))

  (fn get-module [module-name]
    (let [module-path (.. (.. plugins-path "/") module-name)
          module-init (.. module-path :/init.fnl)]
      (if (tbl? (vim.loop.fs_stat module-init))
          module-name)))

  (fn build-require-list []
    (icollect [file ftype (vim.fs.dir plugins-path)]
      (match ftype
        :file (file:match "^(.*)%.fnl$")
        :directory (get-module file))))

  (fn require-modules [modules]
    (icollect [_ name (ipairs modules)]
      (require (.. :conf/modules/ name))))

  (let [plugin-spec [(pack :rktjmp/hotpot.nvim)]]
    (do
      ;;(table.insert plugin-spec (require :conf.lsp))
      (table.insert plugin-spec (require-modules (build-require-list)))
      (tset _G.conf :pack (vim.tbl_flatten plugin-spec))
      ((. (require :lazy) :setup) plugin-spec))))

(load-plugins!)

(when vim.g.neovide
  (require :conf.gui-settings))

(require :conf.keybinds)
(require :conf.events)
(require :conf.diagnostics)
