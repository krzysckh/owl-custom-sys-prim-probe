#!/bin/sh
# -*- mode: sh; sh-basic-offset: 2 -*-

set -xe

OWL_SOURCE_PATH=/home/kpm/nmojeprogramy/owl
CFLAGS="-ggdb -DPRIM_CUSTOM -I/usr/local/include -I$OWL_SOURCE_PATH/c -I/usr/include/tcl8.6"
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

  # ol -x c -o tk-main.c tk.scm
  # clang $CFLAGS $LDFLAGS tk-main.c tk.c \
  #   `pkg-config --cflags --libs tcl tk x11` -o tk-main

}

build_win() {
  [ -f ovm-win.c ] || wget https://raw.githubusercontent.com/krzysckh/owl-winrt/master/ovm.c -O ovm-win.c
  [ -f libraylib5-winlegacy.a ] || wget https://pub.krzysckh.org/libraylib5-winlegacy.a

  CFLAGS="-ggdb -DPRIM_CUSTOM -I$OWL_SOURCE_PATH/c -I/usr/local/include"
  LDFLAGS="-L. -l:libraylib5-winlegacy.a -lm -lopengl32 -lwinmm -lgdi32 -lws2_32 -static"

  ol -x c -o rl-main.c -C ovm-win.c rl.scm
  i686-w64-mingw32-gcc $CFLAGS rl.c rl-main.c $LDFLAGS -o rl-main.exe

  ol -x c -o rl-repl.c -C ovm-win.c rl-repl.scm
  i686-w64-mingw32-gcc $CFLAGS rl.c rl-repl.c $LDFLAGS -o rl-repl.exe
}

build_pubcpy() {
  build_win
  yes | pubcpy rl-main.exe
  yes | pubcpy rl-repl.exe
}

build_$1
