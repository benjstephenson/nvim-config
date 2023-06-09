(import-macros {: set!} :themis.opt)

(local Hydra (require :hydra))

(do
  (local options-hint "
    ^ ^        Options
    ^
    _v_ %{ve} virtual edit
    _i_ %{list} invisible characters  
    _s_ %{spell} spell
    _w_ %{wrap} wrap
    _c_ %{cul} cursor line
    _n_ %{nu} number
    _r_ %{rnu} relative number
    _b_ Toggle Background
    _d_ Toggle deleted lines
    ^
         ^^^^              _<Esc>_
    ")
  (Hydra {:name :+options
          :hint options-hint
          :config {:color :amaranth
                   :invoke_on_body true
                   :hint {:border :solid :position :middle}}
          :mode :n
          :body :<leader>o
          :heads [[:d
                   (fn []
                     (local gs (require :gitsigns))
                     (gs.toggle_deleted))
                   {:desc "Deleted lines"}]
                  [:b
                   (fn []
                     (if (= vim.o.background :dark)
                         (set! background :light)
                         (set! background :dark)))
                   {:desc :Background}]
                  [:n
                   (fn []
                     (if (= vim.o.number true)
                         (set! nonumber)
                         (set! number)))
                   {:desc :number}]
                  [:r
                   (fn []
                     (if (= vim.o.relativenumber true (set! norelativenumber)
                            (do
                              (set! number)
                              (set! relativenumber)))
                         {:desc :relativenumber}))]
                  [:v
                   (fn []
                     (if (= vim.o.virtualedit :all)
                         (set! virtualedit :block)
                         (set! virtualedit :all)))
                   {:desc :virtualedit}]
                  [:i
                   (fn []
                     (if (= vim.o.list true)
                         (set! nolist)
                         (set! list)))
                   {:desc "show invisible"}]
                  [:s
                   (fn []
                     (if (= vim.o.spell true)
                         (set! nospell)
                         (set! spell)))
                   {:desc :spell :exit true}]
                  [:w
                   (fn []
                     (if (= vim.o.wrap true)
                         (set! nowrap)
                         (set! wrap)))
                   {:desc :wrap}]
                  [:c
                   (fn []
                     (if (= vim.o.cursorline true)
                         (set! nocursorline)
                         (set! cursorline)))
                   {:desc "cursor line"}]
                  [:<Esc> nil {:exit true :nowait true}]]}))
