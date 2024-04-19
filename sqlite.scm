(import
 (common)
 (owl toplevel)
 (prefix (owl sys) sys/))

(define (sqlite-open dbname)
  (when (string? dbname)
    (prim 100 dbname)))

(define (sqlite-close ptr)
  (prim 101 ptr))

(define (sqlite-exec ptr sql)
  (when (string? sql)
    (prim 102 ptr sql)))

(define (sqlite-get-error)
  (prim 103))


(λ (_)
  (when (sys/file? "temp.db")
    (sys/unlink "temp.db"))

  (let ((db (sqlite-open "temp.db")))
    (sqlite-exec db "CREATE TABLE users(id int, uname text)")
    (sqlite-exec db "INSERT INTO users VALUES (1, 'kpm')")
    (sqlite-exec db "INSERT INTO users VALUES (2, 'user')")
    (sqlite-close db))
  0)
