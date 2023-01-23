(import-macros {: pack} :themis.pack.lazy)
(import-macros {: let!} :themis.var)

[;; PlantUML
 (pack :aklt/plantuml-syntax {:ft [ :puml :plant :plantuml]})
 (pack :weirongxu/plantuml-previewer.vim {:ft :plantuml
                                          :dependencies [:tyru/open-browser.vim]})
 ;; Markdown
 (pack :iamcco/markdown-preview.nvim {:setup (let! [g] :mkdp_filetypes [:markdown :plantuml])
                                      :ft [:markdown :plantuml]})]
