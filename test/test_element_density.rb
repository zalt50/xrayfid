# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  include Xraylib

  def test_element_densitiy_method_1
    assert_in_delta 0.000084, element_density(1), 1e-8
  end

  def test_element_densitiy_method_50
    assert_in_delta 7.31, element_density(50), 1e-8
  end

  def test_element_densitiy_method_98
    assert_in_delta 10.0, element_density(98), 1e-8
  end

  def test_element_densitiy_method_0
    assert_equal 0.0, element_density(0)
  end

  def test_element_densitiy_method_99
    assert_equal 0.0, element_density(99)
  end
end
