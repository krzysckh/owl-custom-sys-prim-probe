#!/bin/sh

set -xe

OWL_SOURCE_PATH=/home/kpm/nmojeprogramy/owl

ol -x c -o main.c main.scm
clang -I$OWL_SOURCE_PATH/c -DPRIM_CUSTOM ext.c main.c -o main
