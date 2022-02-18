#include "util.h"

void Init_util(void) {
  ID sym_mXrayfid = rb_intern("Xrayfid");
  VALUE rb_mXrayfid = rb_const_get(rb_cObject, sym_mXrayfid);
  ID sym_mLibxrl = rb_intern("Libxrl");
  VALUE rb_mLibxrl = rb_const_get(rb_mXrayfid, sym_mLibxrl);
  rb_define_const(rb_mLibxrl, "SIZEOF_ERRORCODE",
                  INT2FIX(sizeof(xrl_error_code)));
}
