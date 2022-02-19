# frozen_string_literal: true

require "test_helper"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_error_code
    error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE)
    Libxrl.AtomicWeight(26, error)
    assert error.ptr.null?
    Libxrl.xrl_error_free(error.ptr)
    Libxrl.AtomicWeight(185, error)
    assert_equal Libxrl::ERROR_INVALID_ARGUMENT, error.ptr[0, Libxrl::SIZEOF_ERRORCODE].unpack1("I!")
    Libxrl.xrl_error_free(error.ptr)
  end
end
