#include "ruby.h"
#include "xraylib.h"

void Init_util(void) {
  ID sym_mXraylib = rb_intern("Xraylib");
  VALUE rb_mXraylib = rb_const_get(rb_cObject, sym_mXraylib);
  ID sym_mLibxrl = rb_intern("Libxrl");
  VALUE rb_mLibxrl = rb_const_get(rb_mXraylib, sym_mLibxrl);
  rb_define_const(rb_mLibxrl, "SIZEOF_ERRORCODE",
                  INT2FIX(sizeof(xrl_error_code)));
}
