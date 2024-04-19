(import (rl-headers))

(define SPEED 5)

(λ (_)
  (init-window 800 600 "Hello from owl lisp!")
  (set-target-fps 30)
  (letrec* ((bg (make-color #x22 #x22 #x22))
            (fg (make-color #xee #x11 #x11))
            (f (λ (x y)
                 (begin-drawing)

                 (clear-background bg)
                 (draw-circle `(,x . ,y) 16 fg)

                 (end-drawing)

                 (cond
                  ((key-down? #\q) 0)
                  ((key-down? #\a) (f (max (- x SPEED) 0) y))
                  ((key-down? #\d) (f (min (+ x SPEED) 800) y))
                  ((key-down? #\s) (f x (+ y SPEED)))
                  ((key-down? #\w) (f x (- y SPEED)))
                  (else
                   (f x y))))))
    (f 400 300)))
