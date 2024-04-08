
(module hello GOV
    (defcap GOV () true)

(defun hello-world (name:string)
    (format "Hello, {}" [name])
)
    )

(at 1 [1 2 3])
2 
(at "bar" { "foo": 1, "bar": 2 })
2
(enforce (!= (+ 2 2) 4) "Chaos reigns")

(hash "hello")

pact> (if (= (+ 2 2) 4) "Sanity prevails" "Chaos reigns")
"Sanity prevails"

(namespace 'free)

(read-msg) (read-keyset)

calc app

"Pact is a unique language designed for smart contracts on the blockchain, 
offering features like readability and formal verification straight out of the box. 
Today, we'll start with something simple but foundational: a calculator app. This 
will not only help us understand Pact's syntax and functions but also demonstrate 
how easily we can implement logic that's secure and efficient on the blockchain."


; Define a function to add two numbers
(defun add (x y)
  (+ x y))
"In our first function, `add`, we simply take two numbers, `x` and `y`, 
and use the `+` operator to return their sum. In Pact, defining functions is 
straightforward, emphasizing clarity and directness. Think of this as adding up 
the total cost of items in your shopping cart. It's a basic operation, but essential."


"Next up is `subtract`, which takes two numbers and finds the difference. 
If you've ever calculated change owed to a customer, you've performed this operation. 
In Pact, it's as simple as placing a `-` between the two numbers. Understanding these 
basic arithmetic operations is crucial as they form the building blocks of more complex 
logic in smart contracts."
; Define a function to subtract one number from another
(defun subtract (x y)
  (- x y))

"Our final function, `sum`, goes a step further by calculating the total of a list of 
numbers. Using `fold`, we start with a base value of 0 and iterate through each number, 
adding it to the total. This is akin to totaling up scores in a game, where each player's
points are added to reach a final score. `fold` is a powerful tool in Pact, showcasing 
how we can handle lists of data efficiently."
; Define a function to calculate the sum of a list of numbers
(defun sum (numbers)
  (fold (+) 0 numbers))

"Let's see our calculator in action. We'll start by adding a few expenses together, 
then subtract a deposit we've made. Lastly, we'll sum up a list of transaction amounts. 
This hands-on demonstration will give you a feel for how Pact functions operate and how 
they can be composed to build more complex logic. The simplicity and power of Pact make 
it an excellent choice for blockchain application development."

"In this section, we've covered the basics of building with Pact, from simple arithmetic
operations to working with lists. By understanding these fundamentals, you're well on 
your way to developing robust and secure smart contracts. I encourage you to build 
upon this calculator app, exploring more of what Pact has to offer. Happy coding, and 
remember, the blockchain is your canvas!"

Conditional statements are a core aspect of programming logic, allowing you to 
execute different code paths based on certain conditions. In Pact, if/else statements 
are used for this purpose.


(if (> 1 5) "Greater than 5" "5 or less")
(defun check-number (num)
  "Evaluates whether a number is positive, negative, or zero."
  (if (> num 0)
    "The number is positive."
    (if (< num 0)
      "The number is negative."
      "The number is zero.")))

(defun increment-list (numbers:[integer])
  "Increments each number in a list by 1."
  (map (lambda (x) (+ x 1)) numbers))

(increment-list [1 2 3])  ; Expected output: [2 3 4]


(defun sum-list (numbers:[integer])
  "Calculates the sum of a list of numbers."
  (fold (+) 0 numbers))

  (sum-list [1 2 3 4])  ; Expected output: 10


(defun filter-even (numbers:[integer])
  "Retains only even numbers from a list."
  (filter (lambda (x) (= 0 (mod x 2))) numbers))

(filter-even [1 2 3 4 5])  ; Expected output: [2 4]

(enforce (> balance amount) "Insufficient balance")

(enforce-one "At least one condition must be true" 
  [(> balance 100)
   (= user-id "admin")])

(defun check-balance (balance amount)
    "Ensures the balance is sufficient for the transaction."
    (enforce (> balance amount) "Insufficient balance"))

    (defun check-conditions (balance user-id)
  "Checks if at least one condition is met: balance over 100 or user is admin."
  (enforce-one "At least one condition must be true"
    [(> balance 100)
     (= user-id "admin")]))

(check-conditions 101 "user") ; This should pass (balance > 100).
(check-conditions 99 "admin") ; This should pass (user-id is "admin").
(check-conditions 50 "user") ; This should fail with "At least one condition must be true".

(defun sum (numbers:[integer])
"calculate the sum using a lambda"
(fold (lambda (acc num) (+ acc num)) 0 numbers)
)

 (defun concatenate (strings:[string])
    "Concatenate a list of strings using a lambda."
    (fold (lambda (acc str) (+ acc str)) "" strings))

(interface calculator-interface
;; Interface function for addition
(defun add:decimal (x:decimal y:decimal) 
@doc "Adds two numbers together"
)
)

;; Implement the interface in a module
(module calculator 'admin-keyset
  (implements calculator-interface)
  
  ;; Actual implementation of the add function
  (defun add (x y)
    (+ x y))
)
(load "init.repl")

(env-data {
    "gov": {
        "keys": ["test"],
        "pred": "keys-all"
    }
})

(namespace 'free)
(define-keyset "free.gov" (read-keyset "gov"))
(module mod4 GOV
    (defcap GOV () (enforce-guard (keyset-ref-guard "free.gov" )))
    (defschema cost-schema
        @doc "Stores cost values"
        season:string
        name:string
        cost:decimal
      )
    
      (deftable costing:{cost-schema})
    )
    (create-table mod4.costing)

    (defcap CAL () 
    (enforce-guard (keyset-ref-guard "free.gov"))
    )


        (enforce-keyset "free.cal")

(defschema guard-schema
        account:string
        guard:guard
        )
  
        (deftable g:{guard-schema})
  (defun G () true)
    (defun add-g (account:string guard:guard)
     (insert g account
        {'account: account, 'guard:guard}
        )
    )

    (defun add-g (account:string guard:guard)
     (insert g account
        {'account: account, 'guard:(create-user-guard (G))}
        )
    )

    (defun get-g (account:string)
     (read g account)
    )

(env-data {"g":{"keys":["g1"], "pred": "keys-all"}})
(create-table mod4.g)

(load "mod5.repl")
(env-data {"g":{"keys":["g1"], "pred": "keys-all"}})
(free.mod5.add-g "acc" (read-keyset 'g))
(free.mod5.add-write 1.0 2.0 "test1" "acc")
(env-keys ["cal-test"])
(free.mod5.add-write 1.0 2.0 "test1" "acc")
(env-keys ["test"])
(free.mod5.add-write 1.0 2.0 "test2" "acc")
(env-keys ["g1"])
(free.mod5.add-write 1.0 2.0 "test3" "acc")

(defun exception (name:string)
 (enforce-one "Name must be 'test' or 'test2'"
  [(= name "test")(= name "test2")])
)

(defun exception1 (name:string)
 (if (or (= name 'test)
      (= name 'test2)          
 ) (format "{} is valid" [name])
    (format "{} is invalid" [name])
     )
)

 @model [
        (defproperty is-valid-number(x:decimal)
        (or (> x 0.0) (= x 0.0))
        )
    ]

(enforce (and (>= x 0.0) (>= y 0.0))
    "Both numbers must be positive or zero")

    (verify "free.mod5")

    @model [
    ;; Ensure both inputs are positive or zero
    (property (is-valid-number x))
    (property (is-valid-number y))
 ]


  (defun read-with-votes (vote-topic:string)
   @doc "Supplies more vote information"
   (with-read votes-table vote-topic { 'optiona:=optiona, 'optionb:=optionb}
   (format "Votes for {}: Option A: {} Option B: {}" [vote-topic optiona optionb])
   )
 )

; Returns all table keys
 (defun key ()
(keys votes-table))