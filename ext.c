#include <stdio.h>

#include "ovm.h"

word
prim_custom(int op, word a, word b, word c)
{
  switch (op) {
  case 100:
    printf("Hello, World!\n");
    return ITRUE;
  default:
    return IFALSE;
  }
}
