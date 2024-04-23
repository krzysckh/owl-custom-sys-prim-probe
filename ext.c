#include <stdio.h>
#include <fcntl.h>

#include "ovm.h"

word
prim_custom(int op, word a, word b, word c)
{
  uint i;

  switch (op) {
  case 100:
    printf("Hello, World!\n");
    return ITRUE;
  case 101:
    for (i = 0; i < immval(a); ++i)
      printf("wow %d!\n", i);
    return ITRUE;
  case 102:
    return onum(2137, 0);
  case 103:
    return mkstring("Hiii :333");
  case 104: {
    int fd = open("ext.c", O_RDONLY);
    return mkport(fd);
  }
  case 105:
    return mkfloat(0.25);
  default:
    return IFALSE;
  }
}
