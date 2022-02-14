# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Xraylib::VERSION
  end

  def test_calling_AtomicWeight_function
    assert_equal 12.01, Xraylib::Libxrl.AtomicWeight(6, nil)
  end

  def test_atomic_weight_method
    assert_equal 12.01, Xraylib.atomic_weight(6)
    assert_equal 222.0, Xraylib.atomic_weight(86)
  end

  def test_element_densitiy_method
    assert_equal 2.0, Xraylib.element_density(6)
    assert_equal 7.874, Xraylib.element_density(26)
  end

  def test_cs_total_method
    assert_equal 0.3717235309719578, Xraylib.cs_total(26, 100.0)
  end

  def test_cs_photo_method
    assert_equal 0.20443433907301226, Xraylib.cs_photo(26, 100.0)
  end

  def test_cs_rayl_method
    assert_equal 0.0376750946443608, Xraylib.cs_rayl(26, 100.0)
  end

  def test_cs_compt_method
    assert_equal 0.12961409725458475, Xraylib.cs_compt(26, 100.0)
  end
end
