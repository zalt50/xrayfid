# frozen_string_literal: true

require "test_helper"
require "error_messages"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_auger_rate_method_82_k_l3m5
    assert_in_delta 0.004573193387, auger_rate(82, K_L3M5_AUGER), 1e-6
  end

  def test_auger_rate_method_82_l3_m4n7
    assert_in_delta 0.0024327572005, auger_rate(82, L3_M4N7_AUGER), 1e-6
  end

  def test_auger_rate_method_neg_35
    error = assert_raises XrlInvalidArgumentError do
      auger_rate(-35, L3_M4N7_AUGER)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end

  def test_auger_rate_method_82_unknown
    error = assert_raises XrlInvalidArgumentError do
      auger_rate(82, M4_M5Q3_AUGER + 1)
    end

    assert_equal UNKNOWN_AUGER, error.message
  end

  def test_auger_rate_method_62_invalid
    error = assert_raises XrlInvalidArgumentError do
      auger_rate(62, L3_M4N7_AUGER)
    end

    assert_equal INVALID_AUGER, error.message
  end

  def test_auger_yield_method_82_k
    assert_in_delta 1.0 - fluor_yield(82, K_SHELL), auger_yield(82, K_SHELL), 1e-6
  end

  def test_auger_yield_method_82_m3
    assert_in_delta 0.1719525, auger_yield(82, M3_SHELL), 1e-6
  end

  def test_auger_yield_method_82_l1
    assert_in_delta 0.1825, auger_yield(82, L1_SHELL), 1e-9
  end

  def test_auger_yield_method_neg_35
    error = assert_raises XrlInvalidArgumentError do
      auger_yield(-35, K_SHELL)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end

  def test_auger_yield_method_82_n2
    error = assert_raises XrlInvalidArgumentError do
      auger_yield(82, N2_SHELL)
    end

    assert_equal UNKNOWN_SHELL, error.message
  end

  def test_auger_yield_method_26_m5
    error = assert_raises XrlInvalidArgumentError do
      auger_yield(26, M5_SHELL)
    end

    assert_equal INVALID_SHELL, error.message
  end
end
