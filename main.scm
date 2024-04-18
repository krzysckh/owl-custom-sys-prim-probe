(import (owl toplevel))

(define (print-hello)
  (sys-prim 100 #f #f #f))

(λ (_)
  (print-hello)
  0)
