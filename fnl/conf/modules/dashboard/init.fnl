(import-macros {: pack} :themis.pack.lazy)

(local cthulhu ["⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣾⣿⣷⣾⣿⣷⣶⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣀⠀⠀⠀⢀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⠀⠀⠀⠀⣀⣤⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠟⠻⣿⣿⣆⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⣼⣿⣿⠟⠻⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⣿⣿⡿⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⣿⣿⣿⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⠀⠀⢀⣴⣿⣿⠃⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠘⣿⣿⣆⠀⠀⠀⣀⣀⣀⣀⡀⠀⠀⠀⠀ "
                "⠀⠀⠀⢠⣶⣿⣿⣿⣿⣿⣷⣄⢿⣿⠟⠁⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠈⢻⣿⣷⣴⣾⣿⣿⣿⣿⣿⣦⡀⠀⠀ "
                "⠀⠀⢰⡿⠋⠁⠀⢀⣨⣝⣿⣿⣷⡁⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⢩⣾⣿⣿⣫⣄⠀⠀⠈⠙⣿⡆⠀ "
                "⠀⠀⢾⠃⠀⢀⣴⣿⣿⡿⠚⣿⣿⣷⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⣿⣿⣿⠱⢿⣿⣿⣦⡀⠀⠸⡇⠀ "
                "⠀⠀⠀⢀⣴⣿⣿⡿⠋⠀⠀⣿⣿⣿⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⣿⣿⣿⠀⠀⠙⢿⣿⣿⣦⡀⠀⠀ "
                "⠀⠀⣰⣿⣿⡿⠋⠀⠀⠀⠀⣿⣿⡿⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⣿⣿⣿⠀⠀⠀⠀⠙⢿⣿⣿⣄⠀ "
                "⠀⣼⣿⣿⠏⠀⠀⠀⠀⠀⣰⣿⣿⠇⣠⣾⡇⠀⠀⣮⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣴⠀⠀⢸⣷⡄⢹⣿⣿⡄⠀⠀⠀⠀⠀⠻⣿⣿⣦ "
                "⣸⣿⣿⠏⠀⠀⠀⠀⠀⢠⣿⣿⡟⢰⣿⣿⣿⣄⣀⣹⣿⣞⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣵⣿⣇⣀⣤⣿⣿⣿⡄⢻⣿⣿⡄⠀⠀⠀⠀⠀⢹⣿⣿⡆"
                "⣿⣿⣿⠀⠀⠀⠀⠀⣰⣿⣿⠟⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢏⣾⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⢻⣿⣿⣆⠀⠀⠀⠀⠀⣿⣿⣿"
                "⣿⣿⣿⡀⠀⠀⢀⣼⣿⣿⠏⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠁⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠉⠀⣹⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠻⣿⣿⣧⡀⠀⠀⢠⣿⣿⣿"
                "⢹⣿⣿⣧⠀⣠⣾⣿⡿⠃⠀⠀⠀⠹⣿⣿⠟⠛⠛⣿⣿⣿⣦⣀⠀⠀⠻⣿⣿⣿⣿⣿⣿⠏⠀⠀⣀⣼⣿⣿⣿⠛⠛⠻⣿⣿⠃⠀⠀⠀⠙⢿⣿⣷⡄⢀⣾⣿⣿⠇"
                "⠀⠻⣿⣿⣷⣽⣻⠟⠁⠀⠀⠀⠀⠀⠈⠁⠀⢀⣠⣿⣿⣿⣿⣿⣿⣶⣤⡙⣿⡿⢿⣿⢃⣤⣶⣿⣿⣿⣿⣿⣷⣄⡀⠀⠈⠁⠀⠀⠀⠀⠀⠈⠿⣟⣿⣿⣿⣿⠟ "
                "⠀⠀⠈⣻⢿⣿⣿⣿⣷⣶⣶⣶⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡎⠁⠈⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣶⣶⣶⣾⣿⣿⣿⡿⣛⠁⠀ "
                "⠀⠀⢸⣿⣷⡏⠙⠛⠿⠿⢿⣿⣿⣿⣿⣿⠿⠿⠿⠿⢿⣿⠿⣿⣿⣿⣿⣿⣿⠀⢀⣿⣿⣿⣿⣿⣿⠿⣿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⡿⠿⠿⠛⠋⢵⣿⣿⡆⠀ "
                "⠀⠀⣿⣿⣿⠃⠀⠀⢀⣀⣀⣀⡀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣷⡝⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⢫⣾⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⣀⣀⣀⣀⡀⠀⠀⠸⣿⣿⣷⠀ "
                "⠀⠀⣿⣿⣿⠀⠀⢰⣿⡿⠿⣿⣿⣷⢄⣴⣿⣿⣿⣿⠟⠉⣵⣶⣶⡸⣿⣿⣿⡇⢸⣿⣿⣿⢃⣶⣶⡎⠙⠻⣿⣿⣿⣷⣤⡠⣾⣿⡿⠿⢿⣿⡄⠀⠀⣿⣿⣿⠀ "
                "⠀⠀⢿⣿⣿⡀⠀⠸⡿⠀⠀⠀⢙⣵⣿⣿⣿⠟⠋⠀⠀⠀⣾⣿⣿⡇⣿⣿⣿⡇⢸⣿⣿⣿⢸⣿⣿⣧⠀⠀⠀⠙⠿⣿⣿⣿⣮⡋⠀⠀⠀⣿⠇⠀⢠⣿⣿⡟⠀ "
                "⠀⠀⠸⣿⣿⣧⡀⠀⠀⠀⢀⣴⣿⣿⡿⣿⡅⠀⠀⠀⢀⣼⣿⣿⣿⠇⣿⣿⣿⠇⢸⣿⣿⣿⢸⣿⣿⣿⣆⠀⠀⠀⠀⣨⣻⣿⣿⣿⣦⠀⠀⠀⠀⢀⣾⣿⣿⠃⠀ "
                "⠀⠀⠀⠹⣿⣿⣷⣤⡀⢠⣿⣿⣿⠟⢿⣿⣿⠀⣀⣴⣿⣿⣿⠟⠁⠀⣿⣿⣿⠀⠈⣿⣿⣿⠀⠈⠻⣿⣿⣷⣦⣀⠀⣿⣿⡎⠻⣿⣿⣷⡄⢀⣴⣿⣿⣿⠃⠀⠀ "
                "⠀⠀⠀⠀⠈⠻⣿⣿⣿⣷⣾⣿⣥⣤⢸⣿⣿⣸⣿⣿⡿⠋⠁⠀⠀⢀⣿⣿⡟⠀⠀⣿⣿⣿⠀⠀⠀⠈⠻⢿⣿⣿⣷⣿⣿⣧⣤⣭⣿⣷⣿⣿⣿⡿⠟⠁⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⠀⠀⠉⢛⣻⣿⣿⣿⣿⢼⣿⣿⡟⠛⠉⠀⢀⣀⣤⣄⣸⣿⣿⠇⠀⠀⢸⣿⣿⡇⣤⣤⣀⡀⠀⠉⠛⢻⣿⣿⣿⣿⣿⣿⣿⣟⡛⠉⠀⠀⠀⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣷⡀⠀⠸⣿⣿⡇⣀⣴⣾⣿⣿⣿⣏⣿⣿⡿⠀⠀⠀⠀⣿⣿⣿⢻⣿⣿⣿⣷⣦⡀⢸⣿⣿⠁⠀⢀⣾⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣦⣤⣿⣿⣾⣿⣿⠿⠋⠁⢀⣾⣿⣿⢳⣷⠀⢀⣾⡼⣿⣿⣧⡀⠈⠙⠿⣿⣿⣷⣯⣯⣤⣴⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⣟⣯⣅⣀⣠⣴⣿⣿⣿⠃⢻⣿⠆⢸⣿⡏⠹⣿⣿⣿⣦⣄⣀⣨⣽⣻⣿⣿⣿⣿⣿⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⠟⠁⠀⣼⡿⠀⠈⣿⣇⠀⠈⠻⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠙⠉⠉⠀⠀⣠⣾⠿⠁⠀⠀⠘⠿⣷⡄⠀⠀⠉⠉⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "])

; (pack :goolord/alpha-nvim {:lazy false
;                            :config #((. (require :alpha) :setup) {:opts {}
;                                                                    :layout [{:type :padding :val 5}
;                                                                             {:type :text
;                                                                               :val cthulhu
;                                                                               :opts {:position :center
;                                                                                      :hl :AlphaHeader}}]})})
;
(pack :goolord/alpha-nvim {:lazy false
                           :config #((. (require :alpha) :setup) (. (require :alpha.themes.dashboard) :config))})