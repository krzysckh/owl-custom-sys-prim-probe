#include <stdio.h>
#include <sqlite3.h>

#include "ovm.h"

/* pointer = onum(ptr, 0) */

static char *last_err = NULL;

word
prim_custom(int op, word a, word b, word c)
{
  switch (op) {
  case 100: { /* filename → ptr */
    sqlite3 *db;
    if (sqlite3_open((char*)a+W, &db) != SQLITE_OK)
      return IFALSE;
    return onum((uint64_t)db, 0);
  }
  case 101: /* ptr → #t */
    sqlite3_close((sqlite3*) cnum(a));
    return ITRUE;
  case 102: /* ptr sql → #t | #f */
    if (sqlite3_exec((sqlite3*)cnum(a), (char*)b+W, 0, 0, &last_err) != SQLITE_OK)
      return IFALSE;
    return ITRUE;
  case 103: /* → last-error | #f */ {
    if (last_err) {
      word ret = mkstring(last_err);
      sqlite3_free(last_err), last_err = NULL;
      return ret;
    }
    return IFALSE;
  }
    /* ... you get the point */
  default:
    return IFALSE;
  }
}
