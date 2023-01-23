(import-macros {: pack} :themis.pack.lazy)
(import-macros {: let!} :themis.var)


[;; PlantUML
 (pack :weirongxu/plantuml-previewer.vim {:ft :plantuml
                                          :dependencies ["tyru/open-browser.vim"]})
 ;; Markdown
 (pack :iamcco/markdown-preview.nvim {:setup #((let! [g] :mkdp_filetyes [:markdown :plantuml]))
                                      :ft [:markdown :plantuml]})]
