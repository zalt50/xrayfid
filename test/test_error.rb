# frozen_string_literal: true

require "test_helper"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_error_code
    Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
      Libxrl.AtomicWeight(26, error)
      assert error.ptr.null?
      Libxrl.xrl_error_free(error.ptr)

      Libxrl.AtomicWeight(185, error)
      assert_equal Libxrl::ERROR_INVALID_ARGUMENT, error.ptr[0, Fiddle::SIZEOF_LONG].unpack1("I!")
      Libxrl.xrl_error_free(error.ptr)
    end
  end

  def test_error_message
    Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
      Libxrl.AtomicWeight(185, error)
      assert_equal "Z out of range", (error.ptr + Fiddle::ALIGN_LONG).ptr.to_s
      Libxrl.xrl_error_free(error.ptr)
    end
  end
end
