# frozen_string_literal: true

require "test_helper"
require "error_messages"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_cs_fluor_line_method_29
    assert_in_delta 0.13198670698075143, cs_fluor_line(29, L3M5_LINE, 10.0), 1e-6
    assert_in_delta 7.723944209880828e-6, cs_fluor_line(29, L1M5_LINE, 10.0), 1e-8
    assert_in_delta 0.0018343168459245755, cs_fluor_line(29, L1M2_LINE, 10.0), 1e-6
    assert_in_delta 49.21901698835919, cs_fluor_line(29, KL3_LINE, 10.0), 1e-6
  end

  def test_cs_fluor_line_method_26
    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_line(26, L3M5_LINE, 10.0)
    end

    assert_equal UNAVAILABLE_CK, error.message

    assert_in_delta 0.0200667, cs_fluor_line(26, L2M4_LINE, 10.0), 1e-6
    assert_in_delta 0.000830915, cs_fluor_line(26, L1M2_LINE, 10.0), 1e-6

    cs = [KL3_LINE, KL2_LINE].map { |line| cs_fluor_line(26, line, 10.0) }.sum
    assert_in_delta cs, cs_fluor_line(26, KA_LINE, 10.0), 1e-6
  end

  def test_cs_fluor_line_method_bad
    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_line(0, KL3_LINE, 10.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_line(ZMAX, KL3_LINE, 10.0)
    end

    assert_equal INVALID_LINE, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_line(ZMAX + 1, KL3_LINE, 10.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_line(1, KL3_LINE, 10.0)
    end

    assert_equal INVALID_LINE, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_line(92, M5N7_LINE, 10.0)
    end

    assert_equal INVALID_LINE, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_line(26, KL3_LINE, 0.0)
    end

    assert_equal NEGATIVE_ENERGY, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_line(26, KL3_LINE, 1001)
    end

    assert_equal SPLINT_X_TOO_HIGH, error.message
  end

  def test_cs_fluor_line_method_92
    cs = [L3M5_LINE, L3M4_LINE].map { |line| cs_fluor_line(92, line, 30.0) }.sum
    assert_in_delta cs, cs_fluor_line(92, LA_LINE, 30.0), 1e-6

    cs = [LB1_LINE, LB2_LINE, LB3_LINE, LB4_LINE, LB5_LINE, LB6_LINE, LB7_LINE, LB9_LINE,
          LB10_LINE, LB15_LINE, LB17_LINE, L3N6_LINE, L3N7_LINE].map do |line|
      cs_fluor_line(92, line, 30.0)
    end.sum
    assert_in_delta cs, cs_fluor_line(92, LB_LINE, 30.0), 1e-6
  end

  def test_cs_fluor_shell_method
    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_shell(0, K_SHELL, 10.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_shell(ZMAX, K_SHELL, 10.0)
    end

    assert_equal INVALID_SHELL, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_shell(ZMAX + 1, K_SHELL, 10.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_shell(1, K_SHELL, 10.0)
    end

    assert_equal INVALID_SHELL, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_shell(92, M1_SHELL, 10.0)
    end

    assert_equal INVALID_SHELL, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_shell(92, KL3_LINE, 10.0)
    end

    assert_equal INVALID_SHELL, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_shell(26, K_SHELL, 0.0)
    end

    assert_equal NEGATIVE_ENERGY, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_shell(26, K_SHELL, 1001)
    end

    assert_equal SPLINT_X_TOO_HIGH, error.message

    error = assert_raises XrlInvalidArgumentError do
      cs_fluor_shell(26, K_SHELL, 5)
    end

    assert_equal TOO_LOW_EXCITATION_ENERGY, error.message
  end

  def test_cs_fluor_line_method_92_line_mapping
    line_mappings =
      [{ line_lower: KP5_LINE, line_upper: KL1_LINE, shell: K_SHELL },
       { line_lower: L1P5_LINE, line_upper: L1L2_LINE, shell: L1_SHELL },
       { line_lower: L2Q1_LINE, line_upper: L2L3_LINE, shell: L2_SHELL },
       { line_lower: L3Q1_LINE, line_upper: L3M1_LINE, shell: L3_SHELL }]
    line_mappings.each do |mapping|
      rr = (mapping[:line_lower]..mapping[:line_upper]).map do |line|
        rad_rate(92, line)
      rescue XrlInvalidArgumentError
        0.0
      end.sum
      cs = (mapping[:line_lower]..mapping[:line_upper]).map do |line|
        cs_fluor_line(92, line, 120.0)
      rescue XrlInvalidArgumentError
        0.0
      end.sum
      assert_in_delta cs, rr * cs_fluor_shell(92, mapping[:shell], 120.0), 1e-6
    end
  end
end
