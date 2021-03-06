# frozen_string_literal: true

require "test_helper"

class TestXrayfid < Minitest::Test
  include Xrayfid

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
    error = assert_raises XrlInvalidArgumentError do
      element_density(0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end

  def test_element_densitiy_method_99
    error = assert_raises XrlInvalidArgumentError do
      element_density(99)
    end

    assert_equal Z_OUT_OF_RANGE, error.message
  end
end
