;; (import (rl-headers))

;; (define SPEED 5)

;; (λ (_)
;;   (set-target-fps 30)
;;   (letrec* ((bg (make-color #x22 #x22 #x22))
;;             (fg (make-color #xee #x11 #x11)))
;;     (with-window
;;      800 600 "Hello from owl lisp!"
;;      (letrec ((f (λ (x y)
;;                    (draw
;;                     (clear-background bg)
;;                     (draw-circle `(,x . ,y) 16 fg))

;;                    (cond
;;                     ((window-should-close?) 0)
;;                     ((key-down? #\q) 0)
;;                     ((key-down? #\a) (f (max (- x SPEED) 0) y))
;;                     ((key-down? #\d) (f (min (+ x SPEED) 800) y))
;;                     ((key-down? #\s) (f x (+ y SPEED)))
;;                     ((key-down? #\w) (f x (- y SPEED)))
;;                     (else
;;                      (f x y))))))
;;        (f 400 300)))))

(import (rl-headers))

(lambda (_)
  (set-target-fps 60)
  (with-window
    800 450 "raylib [core] example - basic window"
    (let main-loop ()
      (draw
       (clear-background (make-color #xf5 #xf5 #xf5))
       (draw-text "Congrats! You created your first window!" 190 200 20 (make-color #xc8 #xc8 #xc8)))
      (cond
       ((window-should-close?) 0)
       ((key-down? #\q) 0)
       (else (main-loop))))))
