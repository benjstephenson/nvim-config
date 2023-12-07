(import-macros {: set!} :core.opt)

(local Hydra (require :hydra))
(local key-util (require :hydra.keymap-util))
(local splits (require :smart-splits))

(do
  (local window-hint "
     ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
     ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
     ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally 
     _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
     ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
     focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
     ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
    ")
  (Hydra {:name :Windows
          :hint window-hint
          :config {:invoke_on_body true :hint {:border :solid :offset -1}}
          :mode :n
          :body :<leader>w
          :heads [[:h :<C-w>h]
                  [:j :<C-w>j]
                  [:k :<C-w>k]
                  [:l :<C-w>l]
                  [:l :<C-w>l]
                  [:H (key-util.cmd "WinShift left")]
                  [:J (key-util.cmd "WinShift down")]
                  [:K (key-util.cmd "WinShift up")]
                  [:L (key-util.cmd "WinShift right")]
                  [:<C-h> #(splits.resize_left 2)]
                  [:<C-j> #(splits.resize_down 2)]
                  [:<C-k> #(splits.resize_up 2)]
                  [:<C-l> #(splits.resize_right 2)]
                  ["=" (key-util.cmd :WindowsEqualize) {:desc :equalise}]
                  [:s (key-util.pcmd :split :E36)]
                  [:<C-s> (key-util.pcmd :split :E36) {:desc false}]
                  [:v (key-util.pcmd :vsplit :E36)]
                  [:<C-s> (key-util.pcmd :vsplit :E36) {:desc false}]
                  [:w :<C-w>w {:exit true :desc false}]
                  [:<C-w> :<C-w>w {:exit true :desc false}]
                  [:z
                   (key-util.cmd :WindowsMaximize)
                   {:exit true :desc :maximise}]
                  [:<C-z>
                   (key-util.cmd :WindowsMaximize)
                   {:exit true :desc false}]
                  [:o :<C-w>o {:exit true :desc "remain only"}]
                  [:<C-o> :<C-w>o {:exit true :desc false}]
                  [:c (key-util.pcmd :close :E444)]
                  [:q (key-util.pcmd :close :E444) {:desc "close window"}]
                  [:<C-c> (key-util.pcmd :close :E444) {:desc false}]
                  [:<C-q> (key-util.pcmd :close :E444) {:desc false}]
                  [:<Esc> nil {:exit true :desc false}]]}))
