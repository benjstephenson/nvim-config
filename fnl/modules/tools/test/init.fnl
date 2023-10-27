(import-macros {: lazy : map! : if-loaded!} :macros)

(fn keymaps []
  (local neotest (require :neotest))
  (map! [n] :<localleader>ta #(neotest.run.attach) {:desc "Attach to test"})
  (map! [n] :<localleader>tr #(neotest.run.run) {:desc "Run test under cursor"})
  (map! [n] :<localleader>tf #(neotest.run.run (vim.fn.expand "%"))
        {:desc "Run file"})
  (map! [n] :<localleader>to #(neotest.output_panel.toggle)
        {:desc "Toggle output panel"})
  (map! [n] :<localleader>ts #(neotest.summary.toggle) {:desc "Toggle summary"}))

(fn config []
  (local neotest (require :neotest))
  (local neotest-vitest (require :neotest-vitest))
  (local neotest-jest (require :neotest-jest))
  (keymaps)
  ((. neotest :setup) {:adapters [neotest-vitest neotest-jest]}))

(lazy :nvim-neotest/neotest
      {: config
       :dependencies [:mfussenegger/nvim-dap
                      :antoinemadec/FixCursorHold.nvim
                      ; :Issafalcon/neotest-dotnet
                      ; :stevanmilic/neotest-scala
                      :nvim-neotest/neotest-jest
                      :adrigzr/neotest-mocha
                      :mrcjkb/neotest-haskell
                      :marilari88/neotest-vitest]})

; (lazy :nvim-neotest/neotest-vim-test
;       {:dependencies [:vim-test/vim-test]})]})
