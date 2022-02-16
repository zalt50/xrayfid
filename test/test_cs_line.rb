# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  def test_cs_fluor_line_method_29
    assert_in_delta 0.13198670698075143, Xraylib.cs_fluor_line(29, Xraylib::L3M5_LINE, 10.0), 1e-6
    assert_in_delta 7.723944209880828e-6, Xraylib.cs_fluor_line(29, Xraylib::L1M5_LINE, 10.0), 1e-8
    assert_in_delta 0.0018343168459245755, Xraylib.cs_fluor_line(29, Xraylib::L1M2_LINE, 10.0), 1e-6
    assert_in_delta 49.21901698835919, Xraylib.cs_fluor_line(29, Xraylib::KL3_LINE, 10.0), 1e-6
  end

  def test_cs_fluor_line_method_26
    assert_equal 0.0, Xraylib.cs_fluor_line(26, Xraylib::L3M5_LINE, 10.0)
    assert_in_delta 0.0200667, Xraylib.cs_fluor_line(26, Xraylib::L2M4_LINE, 10.0), 1e-6
    assert_in_delta 0.000830915, Xraylib.cs_fluor_line(26, Xraylib::L1M2_LINE, 10.0), 1e-6

    cs = [Xraylib::KL3_LINE, Xraylib::KL2_LINE].map { |line| Xraylib.cs_fluor_line(26, line, 10.0) }.sum
    assert_in_delta cs, Xraylib.cs_fluor_line(26, Xraylib::KA_LINE, 10.0), 1e-6
  end

  def test_cs_fluor_line_method_92
    cs = [Xraylib::L3M5_LINE, Xraylib::L3M4_LINE].map { |line| Xraylib.cs_fluor_line(92, line, 30.0) }.sum
    assert_in_delta cs, Xraylib.cs_fluor_line(92, Xraylib::LA_LINE, 30.0), 1e-6

    cs = [Xraylib::LB1_LINE, Xraylib::LB2_LINE, Xraylib::LB3_LINE, Xraylib::LB4_LINE, Xraylib::LB5_LINE,
          Xraylib::LB6_LINE, Xraylib::LB7_LINE, Xraylib::LB9_LINE, Xraylib::LB10_LINE, Xraylib::LB15_LINE,
          Xraylib::LB17_LINE, Xraylib::L3N6_LINE, Xraylib::L3N7_LINE].map do |line|
      Xraylib.cs_fluor_line(92, line, 30.0)
    end.sum
    assert_in_delta cs, Xraylib.cs_fluor_line(92, Xraylib::LB_LINE, 30.0), 1e-6
  end

  def test_cs_fluor_line_method_92_line_mapping
    line_mappings =
      [{ line_lower: Xraylib::KP5_LINE, line_upper: Xraylib::KL1_LINE, shell: Xraylib::K_SHELL },
       { line_lower: Xraylib::L1P5_LINE, line_upper: Xraylib::L1L2_LINE, shell: Xraylib::L1_SHELL },
       { line_lower: Xraylib::L2Q1_LINE, line_upper: Xraylib::L2L3_LINE, shell: Xraylib::L2_SHELL },
       { line_lower: Xraylib::L3Q1_LINE, line_upper: Xraylib::L3M1_LINE, shell: Xraylib::L3_SHELL }]
    line_mappings.each do |mapping|
      rr = (mapping[:line_lower]..mapping[:line_upper]).map { |line| Xraylib.rad_rate(92, line) }.sum
      cs = (mapping[:line_lower]..mapping[:line_upper]).map { |line| Xraylib.cs_fluor_line(92, line, 120.0) }.sum
      assert_in_delta cs, rr * Xraylib.cs_fluor_shell(92, mapping[:shell], 120.0), 1e-6
    end
  end
end
