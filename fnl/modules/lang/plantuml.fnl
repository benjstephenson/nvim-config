(import-macros {: lazy : let!} :macros)

[(lazy :aklt/plantuml-syntax {:ft [ :puml :plant :plantuml]})
 (lazy :weirongxu/plantuml-previewer.vim {:ft :plantuml
                                          :dependencies [:tyru/open-browser.vim]})]
