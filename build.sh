#!/bin/sh

set -xe

OWL_SOURCE_PATH=/home/kpm/nmojeprogramy/owl
CFLAGS="-ggdb -DPRIM_CUSTOM -I/usr/local/include -I$OWL_SOURCE_PATH/c"
LDFLAGS="-L/usr/local/lib"

if [ `uname -s` = "OpenBSD" ]; then
  LDFLAGS="$LDFLAGS -lglfw"
fi

ol -x c -o main.c main.scm
clang $CFLAGS $LDFLAGS ext.c main.c -o main

ol -x c -o rl-main.c rl.scm
clang $CFLAGS $LDFLAGS rl.c rl-main.c -lraylib -lm -o rl-main

ol -x c -o rl-repl.c rl-repl.scm
clang $CFLAGS $LDFLAGS rl.c rl-repl.c -lraylib -lm -o rl-repl
