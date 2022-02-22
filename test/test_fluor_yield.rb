# frozen_string_literal: true

require "test_helper"
require "error_messages"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_fluor_yield_method_82_k
    assert_in_delta 1.0 - auger_yield(82, K_SHELL), fluor_yield(82, K_SHELL), 1e-6
  end

  def test_fluor_yield_method_82_m3
    assert_in_delta 0.0050475, fluor_yield(82, M3_SHELL), 1e-6
  end

  def test_fluor_yield_method_74_l3
    assert_in_delta 0.255, fluor_yield(74, L3_SHELL), 1e-6
  end

  def test_fluor_yield_method_50_l1
    assert_in_delta 0.036, fluor_yield(50, L1_SHELL), 1e-6
  end

  def test_fluor_yield_method_neg_35
    error = assert_raises XrlInvalidArgumentError do
      fluor_yield(-35, K_SHELL)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end

  def test_fluor_yield_method_82_unknown
    error = assert_raises XrlInvalidArgumentError do
      fluor_yield(82, -1)
    end

    assert_equal UNKNOWN_SHELL, error.message
  end

  def test_fluor_yield_method_26_m5
    error = assert_raises XrlInvalidArgumentError do
      fluor_yield(25, M5_SHELL)
    end

    assert_equal INVALID_SHELL, error.message
  end
end
