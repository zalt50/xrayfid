# frozen_string_literal: true

require "test_helper"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_jump_factor_method_82_k
    assert_in_delta 4.731, jump_factor(82, K_SHELL), 1e-6
  end

  def test_jump_factor_method_82_m3
    assert_in_delta 1.15887, jump_factor(82, M3_SHELL), 1e-6
  end

  def test_jump_factor_method_neg_k
    assert_raises XrlInvalidArgumentError do
      jump_factor(-35, K_SHELL)
    end
  end

  def test_jump_factor_method_82_neg
    assert_raises XrlInvalidArgumentError do
      jump_factor(82, -1)
    end
  end

  def test_jump_factor_method_26_n1
    assert_raises XrlInvalidArgumentError do
      jump_factor(26, N1_SHELL)
    end
  end
end
