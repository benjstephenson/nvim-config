(import-macros {: pack} :themis.pack.lazy)

(fn wilder-setup []
  (local wilder (require :wilder))
  (wilder.setup {:modes [":" "/" "?"] :accept_key :<space>})
  (wilder.set_option :use_python_remote_plugin 0)
  (wilder.set_option :pipeline
                     [(wilder.branch (wilder.cmdline_pipeline {:fuzzy 1
                                                               :fuzzy_filter (wilder.lua_fzy_filter)})
                                     (wilder.vim_search_pipeline))])
  (wilder.set_option :renderer
                     (wilder.popupmenu_renderer {:highlighter (wilder.lua_fzy_highlighter)
                                                 :left [" "
                                                        (wilder.popupmenu_devicons)]
                                                 :right [" "
                                                         (wilder.popupmenu_scrollbar)]
                                                 :highlights {:accent (wilder.make_hl :WilderAccent
                                                                                      :Pmenu
                                                                                      [{:a 1}
                                                                                       {:a 1}
                                                                                       {:foreground "#f4468f"}])}})))

(fn whichkey-setup []
  (let [whichkey (require :which-key)]
    ((. whichkey :setup) {:icons {:breadcrumb "»" :separator "->" :group "+"}
                          :popup_mappings {:scroll_down :<c-d>
                                           :scroll_up :<c-u>}
                          :window {:border :solid}
                          :layout {:spacing 3}
                          :hidden [:<silent>
                                   :<cmd>
                                   :<Cmd>
                                   :<CR>
                                   :call
                                   :lua
                                   "^:"
                                   "^ "]
                          :triggers_blacklist {:i [:j :k] :v [:j :k]}
                          :height {:min 0 :max 6}
                          :align :center})
    ((. whichkey :register) {:<leader>b {:name :+buffers}})
    ((. whichkey :register) {:<leader>c {:name :+code}})
    ((. whichkey :register) {:<leader>ct {:name :+test}})
    ((. whichkey :register) {:<leader>d {:name :+diagnostic}})
    ((. whichkey :register) {:<leader>f {:name :+files}})
    ((. whichkey :register) {:<leader>g {:name :+git}})
    ((. whichkey :register) {:<leader>s {:name :+search}})))

[;; Keybind discoverability
 (pack :folke/which-key.nvim {:config #(whichkey-setup)})
 ;; Wildmenu
 (pack :gelguy/wilder.nvim {:config wilder-setup
                            :dependencies [:romgrk/fzy-lua-native]
                            :event :CmdlineEnter})]
