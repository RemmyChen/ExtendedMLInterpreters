;; step 5
(check-type 3 int)
(check-type #t bool)
(check-type 'hello sym)

;; step 6
(check-type (if #t 77 88) int)
(check-type-error (if 1 77 88))

;; step 7
(val x 1)
(check-type x int)
(val y #f)
(check-type y bool)
(check-type + (int int -> int))
(check-type-error r)

;; step 9
(val z 'test)
(check-type z sym)
(check-type z sym)
(check-type-error a)
(val b (if #t 44 55))
(check-type b int)

;; step 10
(val add +)
(check-type (add (add 1 2) 3) int)
(check-type-error (add 1 #t))
(check-type (< 1 2) bool)
(check-type-error (< 's 1))
(check-type-error (add 1))

;; step 11
(check-type (let ([s 1] [t 2]) (+ s t)) int)
(check-type-error (let ([s 1] [t 's]) (+ s t)))

;; step 12
(check-type (lambda ([x : int]) (+ x 2)) (int -> int))
(check-type (let ([add2 (lambda ([x : int]) (+ x 2))]) (add2 1)) int)
(check-type-error (let ([add2 (lambda ([x : int]) (+ x 2))]) (add2 'b)))
(check-type 
    (let ([add2 (lambda ([x : int] [y : int]) (+ x y))]) (add2 1 4)) int)
(check-type-error 
    (let ([add2 (lambda ([x : int] [y : int]) (+ x y))]) (add2 #t 'b)))
(check-type-error (let ([add2 (lambda ([x : int]) (+ x 3))]) (add2)))
(check-type-error (let ([add2 (lambda ([x : int]) (+ 3))]) (add2 2)))

;; step 13
(check-type (set y #t) bool)
(check-type-error (set add (lambda ([x : int]) (+ x 2))))
(check-type (while #t 1) unit)
(check-type-error (while 1 1))
(check-type (begin 1) int)
(check-type (begin) unit)
(check-type (begin #t 1 's) sym)
(check-type-error (begin (< 's 1)))

;; step 14
(check-type (let* ([x 3]) (+ 1 x)) int)
(check-type-error (let* ([x #t]) (+ 1 x)))
(check-type (let* ([x 3] [y 2] [z 1]) (+ (+ x y) z)) int)
(check-type-error (let* ([x 3] [y 2] [z 's]) (+ (+ x y) z)))

;; step 15
(check-type (letrec ([[x : (int -> int)] (lambda ([m : int]) (+ 7 m))] 
                     [[y : (int -> int)] (lambda ([n : int]) (x n))])
            (y 11)) int)
(check-type-error (letrec ([[x : int] (7)] 
                     [[y : (int -> int)] (lambda ([n : int]) (+ x n))])
            (y 11)))

;; step 16
(val-rec [xy : (int -> int)] (lambda ([y : int]) 2)) 
(check-type (xy 3) int)

(define bool t ([n : int]) (if (< n 10) #t #f))
(check-type t (int -> bool))

;; step 17
(define bool e? ([n : int]) ((@ = int) 0 2))
(check-type (lambda ([n : int]) ((@ = int) 0 2)) (int -> bool))

(val second 
    (type-lambda ['a] (lambda ([xs : (list 'a)]) ((@ car 'a) ((@ cdr 'a) xs)))))
(check-type second (forall ('a) ((list 'a) -> 'a)))

;; step 18
(check-type '() (forall ('a) (list 'a)))
(check-type '(3) (list int))
(check-type '(3 4 5) (list int))

;; more checks
(check-type ((lambda ([x : int] [y : int]) (+ (* x x) (* y y))) 3 4) int)

(val l1 (type-lambda ['a] (lambda ([x : 'a]) ((@ cons 'a) x (@ '() 'a)))))
(check-type l1 (forall ('a) ('a -> (list 'a))))

(define bool e? ([n : int]) ((@ = int) 0 (mod n 2)))
(check-type e? (int -> bool))

(check-type (lambda ([n : int]) ((@ = int) 0 (mod n 2))) (int -> bool))


