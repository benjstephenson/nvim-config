(import-macros {: lazy : let!} :macros)

(lazy :iamcco/markdown-preview.nvim
      {:build #((. vim.fn "mkdp#util#install"))
       :setup (let! [g] :mkdp_filetypes [:markdown :plantuml])
       :ft [:markdown :plantuml]})

; (lazy :toppair/peek.nvim {:build "deno task --quiet build:fast"})
