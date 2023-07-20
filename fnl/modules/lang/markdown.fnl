(import-macros {: lazy : let!} :macros)

(lazy :iamcco/markdown-preview.nvim
      {:setup (let! [g] :mkdp_filetypes [:markdown :plantuml])
       :ft [:markdown :plantuml]})
