#include <raylib.h>
#include <stdio.h>

#include "ovm.h"

word
prim_custom(int op, word a, word b, word c)
{
  switch (op) {
  case 100: /* w h title → #t */
    InitWindow(immval(a), immval(b), (char*)c+W);
    return ITRUE;
  case 101: { /* r g b → color */
    uint32_t l = ((0xff<<24)|(cnum(c)<<16)|(cnum(b)<<8)|cnum(a));
    return onum(l, 1);
  }
  case 102: { /* color → #t */
    uint32_t v = cnum(a);
    ClearBackground(*(Color*)&v);
    return ITRUE;
  }
  case 103:
    BeginDrawing();
    return ITRUE;
  case 104:
    EndDrawing();
    return ITRUE;
  case 105: { /* (x . y) r color → #t */
    int x = cnum(a), y = cnum(a+W);
    DrawCircle(x, y, cnum(b), *(Color*)(uint32_t[]){cnum(c)});
    return ITRUE;
  }
  case 106: /* key → #t | #f */
    return IsKeyDown((int)cnum(a)) ? ITRUE : IFALSE;
  case 107:
    SetTargetFPS(cnum(a));
    return ITRUE;
  default:
    return IFALSE;
  }
}
