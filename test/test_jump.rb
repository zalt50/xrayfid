# frozen_string_literal: true

require "test_helper"
require "error_messages"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_jump_factor_method_82_k
    assert_in_delta 4.731, jump_factor(82, K_SHELL), 1e-6
  end

  def test_jump_factor_method_82_m3
    assert_in_delta 1.15887, jump_factor(82, M3_SHELL), 1e-6
  end

  def test_jump_factor_method_neg_k
    error = assert_raises XrlInvalidArgumentError do
      jump_factor(-35, K_SHELL)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end

  def test_jump_factor_method_82_neg
    error = assert_raises XrlInvalidArgumentError do
      jump_factor(82, -1)
    end

    assert_equal UNKNOWN_SHELL, error.message
  end

  def test_jump_factor_method_26_n1
    error = assert_raises XrlInvalidArgumentError do
      jump_factor(26, N1_SHELL)
    end

    assert_equal INVALID_SHELL, error.message
  end
end
