#!/bin/sh
# -*- mode: sh; sh-basic-offset: 2 -*-

set -xe

OWL_SOURCE_PATH=/home/kpm/nmojeprogramy/owl
CFLAGS="-ggdb -DPRIM_CUSTOM -I/usr/local/include -I$OWL_SOURCE_PATH/c"
LDFLAGS="-L/usr/local/lib"

if [ `uname -s` = "OpenBSD" ]; then
  LDFLAGS="$LDFLAGS -lglfw"
fi

build_unix() {
  ol -x c -o main.c main.scm
  clang $CFLAGS $LDFLAGS ext.c main.c -o main

  ol -x c -o rl-main.c rl.scm
  clang $CFLAGS $LDFLAGS rl.c rl-main.c -lraylib -lm -o rl-main

  ol -x c -o rl-repl.c rl-repl.scm
  clang $CFLAGS $LDFLAGS rl.c rl-repl.c -lraylib -lm -o rl-repl

  ol -x c -o sqlite-main.c sqlite.scm
  clang $CFLAGS $LDFLAGS sqlite-main.c sqlite.c -lsqlite3 -o sqlite-main
}

build_win() {
  [ -f ovm-win.c ] || wget https://raw.githubusercontent.com/krzysckh/owl-winrt/master/ovm.c -O ovm-win.c
  [ -f libraylib.a ] || wget https://pub.krzysckh.org/libraylib.a

  CFLAGS="-ggdb -DPRIM_CUSTOM -I$OWL_SOURCE_PATH/c -I/usr/local/include"
  LDFLAGS="-L. -l:libraylib.a -lm -lwinmm -lgdi32 -lws2_32 -static"

  ol -x c -o rl-main.c -C ovm-win.c rl.scm
  x86_64-w64-mingw32-gcc $CFLAGS rl.c rl-main.c $LDFLAGS -o rl-main.exe
}

build_$1
