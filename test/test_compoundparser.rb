# frozen_string_literal: true

require "test_helper"
require "error_messages"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_symbol_to_atomic_number
    assert_equal 26, symbol_to_atomic_number("Fe")

    error = assert_raises XrlInvalidArgumentError do
      symbol_to_atomic_number("Uu")
    end

    assert_equal "Invalid chemical symbol", error.message


    error = assert_raises XrlInvalidArgumentError do
      symbol_to_atomic_number(nil)
    end

    assert_equal "Symbol cannot be NULL", error.message
  end

  def test_atomic_number_to_symbol
    assert_equal "Fe", atomic_number_to_symbol(26)

    error = assert_raises XrlInvalidArgumentError do
      atomic_number_to_symbol(-2)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end
end
