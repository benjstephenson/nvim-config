(import-macros {: lazy : map! : set! : augroup! : autocmd! : clear!} :macros)
(local on-attach (require :modules.tools.lsp.on-attach))

(fn config []
  (let [ht (require :haskell-tools)
        telescope-themes (require :telescope.themes)]
    (ht.start_or_attach {:hls {:on_attach (fn [client bufnr]
                                            (map! [n] :<leader>cR
                                                  vim.lsp.codelens.run
                                                  {:desc "Run code lens"}))}
                         :tools {:hover {:border _G.shared.border}}})
    (map! [n] :<localleader>hh
          #(ht.hoogle.hoogle_signature (telescope-themes.get_ivy))
          {:desc "Hoogle search"})
    (map! [n] :<localleader>hr #(ht.repl.toggle (vim.api.nvim_buf_get_name 0))
          {:desc "REPL for current buffer"})
    (map! [n] :<localleader>hq ht.repl.quit {:desc "quit REPL"})))

(augroup! haskell-ft (clear!) (autocmd! [Filetype] [haskell cabal] `(config)))

(lazy :MrcJkb/haskell-tools.nvim
      {:dependencies [:nvim-lua/plenary.nvim :nvim-lua/telescope.nvim]
       :branch :1.x.x
       :ft [:haskell]})
