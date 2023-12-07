(local stdlib {})

;; load shared constants

(require :constants)

(local tables (require :lib.tables))
(each [k v (pairs tables)]
  (tset stdlib k v))

(tset stdlib :crypt (require :lib.crypt))

(fn stdlib.nil? [x]
  "Returns true if the given value is nil, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (nil? nil) true))
  (assert (= (nil? 1) false))
  ```"
  (= nil x))

(fn stdlib.str? [x]
  "Returns true if the given value is a string, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (str? \"hello world\") true))
  (assert (= (str? 1) false))
  ```"
  (= :string (type x)))

(fn stdlib.num? [x]
  "Returns true if the given value is a number, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (num? 1) true))
  (assert (= (num? \"hello world\") false))
  ```"
  (= :number (type x)))

(fn stdlib.bool? [x]
  "Returns true if the given value is a boolean, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (bool? true) true))
  (assert (= (bool? \"hello\") false))
  ```"
  (= :boolean (type x)))

(fn stdlib.fn? [x]
  "Returns true if the given value is a function, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (fn? (fn [])) true))
  (assert (= (fn? \"hello world\") false))
  ```"
  (= :function (type x)))

(fn stdlib.executable? [...]
  "Returns true if the input is executable, false otherwise.
  Arguments:
  * `...`: a string

  Example:
  ```fennel
  (assert (= (executable? :python3) true))
  (assert (= (executable? :python3) false))
  ```"
  (= 1 (vim.fn.executable ...)))

(fn stdlib.nightly? []
  "Returns true if the given neovim is of version 0.9, false otherwise.

  Example:
  ```fennel
  (assert (= (nightly?) true))
  (assert (= (nightly?) false))
  ```"
  (let [nightly (vim.fn.has :nvim-0.9.0)]
    (= nightly 1)))

(fn stdlib.headless? []
  "Returns true if the current instance is running headless, false otherwise.

  Example:
  ```fennel
  (assert (= (headless?) true))
  (assert (= (headless?) false))
  ```"
  (= (length (vim.api.nvim_list_uis)) 0))

(fn stdlib.->str [x]
  "Converts `x` to a string.

  Arguments:
  * `x`: the value to convert to a string

  Example:
  ```fennel
  (assert (= (->str {a: 1, b: 2}) \"{a: 1, b: 2}\"))
  (assert (= (->str 123) \"123\"))
  ```"
  (tostring x))

(fn stdlib.->bool [x]
  "Converts `x` to a boolean.

  Arguments:
  * `x`: the value to convert to a boolean

  Example:
  (assert (= (->bool 1) true))
  (assert (= (->bool 0) false))
  (assert (= (->bool \"hello\") true))
  (assert (= (->bool "
  ") false))\n  ```"
  (if x true false))

(fn stdlib.empty? [xs]
  "Returns true if the given list is empty, false otherwise.
  Arguments:
  * `xs`: a list

  Example:
  ```fennel
  (assert (= (empty? []) true))
  (assert (= (empty? [1, 2, 3]) false))
  ```"
  (= 0 (length xs)))

(fn stdlib.contains? [xs x]
  "Returns `true` if `xs` contains the value `x`, `false` otherwise.

  Arguments:
  * `xs`: the list or table to check
  * `x`: the value to search for

  Example:
  ```fennel
  (assert (= (contains? [1, 2, 3, 4, 5] 3) true))
  (assert (= (contains? [1, 2, 3, 4, 5] 6) false))
  ```"
  (fun.any #(= $ x) xs))

(fn stdlib.truncate [num digits]
  "Truncates a value to a given number of digits.

  Arguments:
  * `num`: the value to truncate.
  * `digits`: the number of digits to truncate to.

  Example:
  ```fennel
  (assert (= (truncate .123456 3) .123)
  ```"
  (let [mult (^ 10 digits)]
    (/ (math.modf (* num mult)) mult)))

(fn stdlib.begins-with? [chars str]
  "Returns `true` if the string `str` begins with the characters in `chars`, `false` otherwise.

  Arguments:
  * `chars`: the characters to check for at the beginning of `str`
  * `str`: the string to check

  Example:
  ```fennel
  (assert (= (begins-with? \"hello\" \"hello, world!\") true)
  (assert (= (begins-with? \"hey\" \"hello, world!\") false)
  ```"
  (stdlib.->bool (str:match (.. "^" chars))))

(fn stdlib.++ [n]
  "Increments `n` by 1 and returns the result.

  Arguments:
  * `n`: the number to increment

  Example:
  ```fennel
  (assert (= (++ 3) 4)
  (assert (= (++ 1) 2)
  ```"
  (+ n 1))

(fn stdlib.-- [n]
  "Decrements `n` by 1 and returns the result.

  Arguments:
  * `n`: the number to decrement

  Example:
  ```fennel
  (assert (= (-- 3) 2)
  (assert (= (-- 1) 0)
  ```"
  (- n 1))

(fn stdlib.even? [n]
  "Returns `true` if `n` is an even number, `false` otherwise.

  Arguments:
  * `n`: the number to check

  Example:
  ```fennel
  (assert (= (even? 2) true)
  (assert (= (even? 3) false)
  ```"
  (= (% n 2) 0))

(fn stdlib.odd? [n]
  "Returns `true` if `n` is an odd number, `false` otherwise.

  Arguments:
  * `n`: the number to check

  Example:
  ```fennel
  (assert (= (odd? 2) false)
  (assert (= (odd? 3) true)
  ```"
  (not (stdlib.even? n)))

(fn stdlib.car [xs]
  "Returns the head value of the list
   or nil if the list is empty
  "
  (?. xs 1))


(fn stdlib.any? [pred xs]
  (accumulate [any? false
                _ v (ipairs xs)
                &until any?]
    (pred v)))
 

(fn stdlib.all? [pred xs]
  (not (stdlib.any? #(not (pred $)) xs)))

stdlib
