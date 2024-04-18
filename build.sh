#!/bin/sh

set -xe

OWL_SOURCE_PATH=/home/kpm/nmojeprogramy/owl

ol -x c -o main.c main.scm
clang -I$OWL_SOURCE_PATH/c -DPRIM_CUSTOM ext.c main.c -o main

ol -x c -o rl-main.c rl.scm
clang -ggdb -I$OWL_SOURCE_PATH/c -DPRIM_CUSTOM rl.c rl-main.c -lraylib -lm -o rl-main
