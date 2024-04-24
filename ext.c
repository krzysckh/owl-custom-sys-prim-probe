#include <stdio.h>
#include <fcntl.h>

#include "ovm.h"

word
list_at(word l, int n)
{
  if (n == 0)
    return G(l, 1);
  return list_at(G(l, 2), n-1);
}

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
    return mkfloat(-0.25); /* 25/100 */
  case 106:
    return mkfloat((float)INT64_MAX+1.f); /* #f */
  case 107:
    return cons(mkfloat(0.00000000001),
                mkfloat(0.000000000001)); /* (small float . #f) */
  case 108: /* last */
    return list_at(a, llen((word*)a)-1);
  default:
    return IFALSE;
  }
}
