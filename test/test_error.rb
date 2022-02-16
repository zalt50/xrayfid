# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  include Xraylib

  def test_error_code
    error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
    Libxrl.AtomicWeight(20, error)
    error.ptr[0, Libxrl::SIZEOF_ERRORCODE].unpack("I!") unless error.ptr.null?
    # assert_equal 1, *error.ptr[0, Libxrl::SIZEOF_ERRORCODE].unpack("I!")
  end
end
