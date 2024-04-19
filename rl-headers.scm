(define-library
    (rl-headers)

  (import
   (owl toplevel)
   (common))

  (export
   init-window
   make-color
   clear-background
   begin-drawing
   end-drawing
   draw-circle
   key-down?
   set-target-fps)

  (begin
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
    ))
