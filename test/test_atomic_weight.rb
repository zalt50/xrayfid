# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  def test_atomic_weight_method_26
    assert_in_delta 55.850, Xraylib.atomic_weight(26), 1e-6
  end

  def test_atomic_weight_method_92
    assert_in_delta 238.070, Xraylib.atomic_weight(92), 1e-6
  end

  def test_atomic_weight_method_185
    assert_equal 0.0, Xraylib.atomic_weight(185)
  end
end
