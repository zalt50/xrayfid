# frozen_string_literal: true

require "test_helper"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_atomic_level_width_26
    assert_in_delta 1.19E-3, atomic_level_width(26, K_SHELL), 1e-6
  end

  def test_atomic_level_width_92
    assert_in_delta 0.31E-3, atomic_level_width(92, N7_SHELL), 1e-8
  end

  def test_atomic_level_width_185
    assert_raises XrlInvalidArgumentError do
      atomic_level_width(185, K_SHELL)
    end
  end

  def test_atomic_level_width_26_neg
    assert_raises XrlInvalidArgumentError do
      atomic_level_width(26, -5)
    end
  end

  def test_atomic_level_width_26_n3
    assert_raises XrlInvalidArgumentError do
      atomic_level_width(26, N3_SHELL)
    end
  end
end
