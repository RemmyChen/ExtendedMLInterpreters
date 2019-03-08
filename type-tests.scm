;; UNIT TEST 1
(val l1 (type-lambda ['a] (lambda ([x : 'a]) ((@ cons 'a) x (@ '() 'a)))))
(check-type l1 (forall ('a) ('a -> (list 'a))))

;; UNIT TEST 2
(define bool e? ([n : int]) ((@ = int) 0 2))
(check-type (lambda ([n : int]) ((@ = int) 0 2)) (int -> bool))

;; UNIT TEST 3
(check-type-error (letrec ([[x : int] (7)]
                           [[y : (int -> int)] (lambda ([n : int]) (+ x n))])
                   (y 11)))

;; extras - written by Professor Norman Ramsey and used for testing purposes
(check-type cons (forall ('a) ('a (list 'a) -> (list 'a))))
(check-type (@ car int) ((list int) -> int))
(check-type
  (type-lambda ['a] (lambda ([x : 'a]) x))
  (forall ('a) ('a -> 'a)))
(check-type-error (+ 1 #t))                        ; extra example
(check-type-error (lambda ([x : int]) (cons x x))) ; another extra example
