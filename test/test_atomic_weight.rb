# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  include Xraylib

  def test_atomic_weight_method_26
    assert_in_delta 55.850, atomic_weight(26), 1e-6
  end

  def test_atomic_weight_method_92
    assert_in_delta 238.070, atomic_weight(92), 1e-6
  end

  def test_atomic_weight_method_185
    assert_equal 0.0, atomic_weight(185)
  end
end
