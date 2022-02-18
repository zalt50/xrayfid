# frozen_string_literal: true

require "mkmf"

dir_config("xraylib")
create_makefile("xraylib/util") if have_header("xraylib.h")
