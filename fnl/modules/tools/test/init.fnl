(import-macros {: lazy : map! : if-loaded!} :macros)

(fn keymaps []
  (local neotest (require :neotest))
  (map! [n] :<leader>tr #(neotest.run.run) {:desc "Run test under cursor"})
  (map! [n] :<leader>tf #(neotest.run.run (vim.fn.expand "%"))
        {:desc "Run file"})
  (map! [n] :<leader>to #(neotest.output_panel.toggle)
        {:desc "Toggle output panel"})
  (map! [n] :<leader>ts #(neotest.summary.toggle) {:desc "Toggle summary"}))

(fn config []
  (local neotest (require :neotest))
  (neotest:setup {:adapters [(if-loaded! :lang.csharp (require :neotest-dotnet))
                             (if-loaded! :lang.scala (require :neotest-scala))
                             (if-loaded! :lang.typescript
                                         (require :neotest-jest))]})
  (keymaps))

(lazy :nvim-neotest/neotest {:dependencies [:Issafalcon/neotest-dotnet
                                            :nvim-neotest/neotest-jest
                                            :stevanmilic/neotest-scala]
                             : config})
