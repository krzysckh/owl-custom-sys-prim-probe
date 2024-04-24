(import
 (owl toplevel)
 (owl lazy))

(define (print-hello)
  (sys-prim 100 #f #f #f))

(define (print-wow n)
  (sys-prim 101 n #f #f))

(define (get-n)
  (sys-prim 102 #f #f #f))

(define (hii)
  (sys-prim 103 #f #f #f))

(define (get-ext)
  (force-ll (lines (sys-prim 104 #f #f #f))))

(define (rat)
  (sys-prim 105 0.3 #f #f))

(λ (_)
  (print-hello)
  (print-wow (get-n))
  (print (hii))
  (map print (get-ext))
  (print (rat))
  (print (sys-prim 106 #f #f #f))
  (print (sys-prim 107 #f #f #f))

  (print (sys-prim 108 '(1 2 3 4) #f #f))
  0)
