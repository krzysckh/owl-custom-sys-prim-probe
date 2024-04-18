(define (prim n . vs)
  (let ((L (length vs)))
    (cond
     ((= L 0) (sys-prim n #f #f #f))
     ((= L 1) (sys-prim n (car vs) #f #f))
     ((= L 2) (sys-prim n (car vs) (cadr vs) #f))
     (else
      (sys-prim n (car vs) (cadr vs) (caddr vs))))))

(define (init-window w h title)
  (when (and (number? w) (number? h) (string? title))
    (prim 100 w h title)))

(define (make-color r g b)
  (prim 101 r g b))

(define (clear-background color)
  (prim 102 color))

(define (begin-drawing)
  (prim 103))

(define (end-drawing)
  (prim 104))

(define (draw-circle pos r color)
  (prim 105 pos r color))

(define (key-down? k)
  (let ((c (if (> k 96) (- k 32) k)))
    (prim 106 c)))

(define (set-target-fps n)
  (prim 107 n))

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
