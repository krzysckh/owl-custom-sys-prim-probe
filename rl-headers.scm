(define-library
    (rl-headers)

  (import
   (owl toplevel)
   (common))

  (export
   draw
   with-window

   window-should-close?
   init-window
   close-window
   make-color
   clear-background
   begin-drawing
   end-drawing
   draw-circle
   key-down?
   set-target-fps
   draw-text
   )

  (begin
    (define (init-window w h title)
      (when (and (number? w) (number? h) (string? title))
        (prim 100 w h (c-string title))))

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

    (define (window-should-close?)
      (prim 108))

    (define (close-window)
      (prim 109))

    (define (draw-text text x y h color)
      (prim 110 (c-string text) (list x y h) color))


    (define-syntax draw
      (syntax-rules ()
        ((draw exp1 ...)
         (begin
           (begin-drawing)
           exp1 ...
           (end-drawing)))))

    (define-syntax with-window
      (syntax-rules ()
        ((with-window width height title exp1)
         (begin
           (init-window width height title)
           (let ((res exp1))
             (close-window)
             res)))))
    ))
