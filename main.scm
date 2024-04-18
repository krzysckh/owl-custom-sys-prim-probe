(import (owl toplevel))

(define (print-hello)
  (sys-prim 100 #f #f #f))

(define (print-wow n)
  (sys-prim 101 n #f #f))

(define (get-n)
  (sys-prim 102 #f #f #f))

(λ (_)
  (print-hello)
  (print-wow (get-n))
  0)
