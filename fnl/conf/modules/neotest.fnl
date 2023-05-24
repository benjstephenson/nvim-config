(import-macros {: pack} :themis.pack.lazy)
(import-macros {: map!} :themis.keybind)

(fn keymaps []
  (local neotest (require :neotest))
  (map! [n] :<leader>ctr #(neotest.run.run) {:desc "Run test under cursor"})
  (map! [n] :<leader>ctf #(neotest.run.run (vim.fn.expand "%"))
        {:desc "Run file"})
  (map! [n] :<leader>cto #(neotest.output_panel.toggle)
        {:desc "Toggle output panel"})
  (map! [n] :<leader>cts #(neotest.summary.toggle) {:desc "Toggle summary"}))

(fn config []
  (local neotest (require :neotest))
  (neotest:setup {:adapters [(require :neotest-dotnet)
                             (require :neotest-scala)
                             (require :neotest-jest (keymaps))]}))

(pack :nvim-neotest/neotest {:dependencies [:Issafalcon/neotest-dotnet
                                            :nvim-neotest/neotest-jest
                                            :stevanmilic/neotest-scala]
                             : config})
