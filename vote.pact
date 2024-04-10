(namespace 'free)
(define-keyset "free.vote-gov" (read-keyset "vote"))
(module vote GOV

   (defcap GOV ()
    (enforce-guard (keyset-ref-guard "free.vote-gov"))
    )

(defschema votes-schema
    @doc "Schema for holding votes"
    optiona:integer
    optionb:integer
)
(deftable votes-table:{votes-schema})

; Vote Functions

(defun vote:string (vote-topic:string vote:string)
 @doc "Register a vote"
  (let* (
    (topica:integer (at 'optiona (read votes-table vote-topic)))
    (topicb:integer (at 'optionb (read votes-table vote-topic)))
       )
  (enforce (or (= vote 'optiona) (= vote 'optionb)) "Invalid vote option")

  (write votes-table vote-topic
    (if (= vote 'optiona) { 'optiona: (+ topica 1), 'optionb: topicb}
        { 'optiona: topica, 'optionb: (+ topicb 1)}
        )
  )
 (format "You have voted {} for: {}" [vote vote-topic])
  )
) 

(defun init-vote (vote-topic:string)
 (write votes-table vote-topic
    {'optiona: 0, 'optionb: 0}
    )
)

 (defun read-votes (vote-topic:string)
    @doc "Supplies vote information"
    (let* (
        (vote-data (read votes-table vote-topic))
        (optiona (at 'optiona vote-data))
        (optionb (at 'optionb vote-data))
    )
    (format "Votes for {}: Option A: {} Option B: {}" [vote-topic optiona optionb])
    )
 )

(defun read-with-votes (vote-topic:string)
 (with-read votes-table vote-topic { 'optiona:=optiona, 'optionb:=optionb}
 (format "Votes for {}: Option A: {} Option B: {}" [vote-topic optiona optionb])
 )
)

(defun key ()
(keys votes-table)
)

)
(create-table votes-table)