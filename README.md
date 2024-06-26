simple examples of using custom prim-ops in owl lisp

```console
$ build.sh unix
$ build.sh ol_rl_unix
```

it even works on the weird operating system for playing games, and their foss brother!

* https://pub.krzysckh.org/rl-main.exe
![](res/raylib-reactos.png)


notes:

```
Aki Helin @akihe · 1 hour ago (Owner)

A few things that may be of use or are useful to know in this context:

* Tuples are always arrays of word (*), so they are convenient for
  passing large numbers of arguments to C-functions. owl/core.scm:452
  has the descriptor format
* Strings with ASCII data are internally char*, but large strings can
  be trees, and strings with higher unicode codepoints are stored in a
  wider format. You can use c-string from (owl string) to convert them
  to null-terminated UTF8 for passing to C if necessary.
* (type <object>) can useful for checking in what format a value is
  stored in heap.
* If an extension function needs to block, it's a good idea to instead
  return a value denoting the need and repeatedly e.g. (sleep 50) at
  lisp side until a result is available. This makes it possible for
  other threads to keep running.
```
