# frozen_string_literal: true

require "test_helper"
require "error_messages"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_line_energy_method_26
    assert_in_delta 6.4039, line_energy(26, KL3_LINE), 1e-6
  end

  def test_line_energy_method_92
    assert_in_delta 93.844, line_energy(92, KL1_LINE), 1e-6
  end

  def test_line_energy_method_56
    assert_in_delta 3.9542, line_energy(56, L3M1_LINE), 1e-6
  end

  def test_line_energy_method_82
    assert_in_delta 2.3477, line_energy(82, M5N7_LINE), 1e-6
  end

  def test_line_energy_method_0
    error = assert_raises XrlInvalidArgumentError do
      line_energy(0, KL3_LINE)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end

  def test_line_energy_method_neg
    error = assert_raises XrlInvalidArgumentError do
      line_energy(-1, KL3_LINE)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end

  def test_line_energy_method_zmax_1
    error = assert_raises XrlInvalidArgumentError do
      line_energy(ZMAX + 1, KL3_LINE)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end

  def test_line_energy_method_zmax
    error = assert_raises XrlInvalidArgumentError do
      line_energy(ZMAX, KL3_LINE)
    end

    assert_equal INVALID_LINE, error.message
  end

  def test_line_energy_method_105
    error = assert_raises XrlInvalidArgumentError do
      line_energy(105, KL3_LINE)
    end

    assert_equal INVALID_LINE, error.message
  end

  def test_line_energy_method_104
    assert 0.0 < line_energy(104, KL3_LINE)
  end

  def test_line_energy_method_26_1000
    error = assert_raises XrlInvalidArgumentError do
      line_energy(26, 1000)
    end

    assert_equal UNKNOWN_LINE, error.message
  end

  def test_line_energy_method_26_m5n7
    error = assert_raises XrlInvalidArgumentError do
      line_energy(26, M5N7_LINE)
    end

    assert_equal INVALID_LINE, error.message
  end

  def test_line_energy_method_26_ka
    assert_in_delta 6.399505664957576, line_energy(26, KA_LINE), 1e-6
  end

  def test_line_energy_method_26_kb
    assert_in_delta 7.058, line_energy(26, KB_LINE), 1e-6
  end

  def test_line_energy_method_1_ka
    error = assert_raises XrlInvalidArgumentError do
      line_energy(1, KA_LINE)
    end

    assert_equal INVALID_LINE, error.message
  end

  def test_line_energy_method_26_la
    assert_in_delta 0.7045, line_energy(26, LA_LINE), 1e-6
  end

  def test_line_energy_method_26_lb
    assert_in_delta 0.724378, line_energy(26, LB_LINE), 1e-6
  end

  def test_line_energy_method_0_ka
    error = assert_raises XrlInvalidArgumentError do
      line_energy(0, KA_LINE)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end

  def test_line_energy_method_92_l1n67
    assert_in_delta (line_energy(92, L1N6_LINE) + line_energy(92, L1N7_LINE)) / 2.0, line_energy(92, L1N67_LINE), 1e-6
  end

  def test_line_energy_method_12_lb
    error = assert_raises XrlInvalidArgumentError do
      line_energy(12, LB_LINE)
    end

    assert_equal INVALID_LINE, error.message
  end

  def test_line_energy_method_13_lb
    assert_in_delta 0.112131, line_energy(13, LB_LINE), 1e-6
  end

  def test_line_energy_method_20_la
    error = assert_raises XrlInvalidArgumentError do
      line_energy(20, LA_LINE)
    end

    assert_equal INVALID_LINE, error.message
  end

  def test_line_energy_method_21_la
    assert_in_delta 0.3956, line_energy(21, LA_LINE), 1e-6
  end

  def test_line_energy_method_47_ko
    error = assert_raises XrlInvalidArgumentError do
      line_energy(47, KO_LINE)
    end

    assert_equal INVALID_LINE, error.message
  end

  def test_line_energy_method_48_ko
    assert_in_delta 26.709, line_energy(48, KO_LINE), 1e-6
    assert_in_delta line_energy(48, KO1_LINE), line_energy(48, KO_LINE), 1e-6
  end

  def test_line_energy_method_81_ko
    error = assert_raises XrlInvalidArgumentError do
      line_energy(81, KP_LINE)
    end

    assert_equal INVALID_LINE, error.message
  end

  def test_line_energy_method_82_kp
    assert_in_delta 88.0014, line_energy(82, KP_LINE), 1e-6
    assert_in_delta line_energy(82, KP1_LINE), line_energy(82, KP_LINE), 1e-6
  end
end
