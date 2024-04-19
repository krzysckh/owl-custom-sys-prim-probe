(import
 (owl toplevel)
 (owl repl)
 (owl eval env))

(λ (_)
  (print "o/")
  (let ((env (fold
              (λ (env defn) (env-set env (car defn) (cdr defn)))
              *toplevel*
              (list
               (cons '*include-dirs* '("."))
               (cons '*libraries* *libraries*)
               (cons '*interactive* #t)))))
    (repl-ui env)))
