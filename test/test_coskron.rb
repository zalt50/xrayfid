# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  def test_cos_kron_trans_prob_method_92
    assert_in_delta 0.620, Xraylib.cos_kron_trans_prob(92, Xraylib::FL13_TRANS), 1e-6
  end

  def test_cos_kron_trans_prob_method_75
    assert_in_delta 1.03e-1, Xraylib.cos_kron_trans_prob(75, Xraylib::FL12_TRANS), 1e-6
  end

  def test_cos_kron_trans_prob_method_51
    assert_in_delta 1.24e-1, Xraylib.cos_kron_trans_prob(51, Xraylib::FL23_TRANS), 1e-6
  end

  def test_cos_kron_trans_prob_method_86
    assert_in_delta 6e-2, Xraylib.cos_kron_trans_prob(86, Xraylib::FM45_TRANS), 1e-6
  end

  def test_cos_kron_trans_prob_method_11
    assert_equal 0.0, Xraylib.cos_kron_trans_prob(11, Xraylib::FL12_TRANS)
  end

  def test_cos_kron_trans_prob_method_109
    assert_in_delta 1.02e-1, Xraylib.cos_kron_trans_prob(109, Xraylib::FM45_TRANS), 1e-6
  end

  def test_cos_kron_trans_prob_method_110
    assert_equal 0.0, Xraylib.cos_kron_trans_prob(110, Xraylib::FL12_TRANS)
  end

  def test_cos_kron_trans_prob_method_0
    assert_equal 0.0, Xraylib.cos_kron_trans_prob(0, Xraylib::FL12_TRANS)
  end

  def test_cos_kron_trans_prob_method_ZMAX
    assert_equal 0.0, Xraylib.cos_kron_trans_prob(Xraylib::ZMAX + 1, Xraylib::FL12_TRANS)
  end

  def test_cos_kron_trans_prob_method_non_existent
    assert_equal 0.0, Xraylib.cos_kron_trans_prob(26, 0)
    assert 0.0 < Xraylib.cos_kron_trans_prob(92, Xraylib::FM45_TRANS)
    assert_equal 0.0, Xraylib.cos_kron_trans_prob(92, Xraylib::FM45_TRANS + 1)
  end

  def test_cos_kron_trans_prob_method_internal_consistency
    sum =
      Xraylib.fluor_yield(92, Xraylib::L1_SHELL) +
      Xraylib.auger_yield(92, Xraylib::L1_SHELL) +
      [Xraylib::FL12_TRANS, Xraylib::FL13_TRANS, Xraylib::FLP13_TRANS].map do |trans|
        Xraylib.cos_kron_trans_prob(92, trans)
      end.sum
    assert_in_delta 1.0, sum, 1e-6

    sum =
      Xraylib.fluor_yield(92, Xraylib::L2_SHELL) +
      Xraylib.auger_yield(92, Xraylib::L2_SHELL) +
      Xraylib.cos_kron_trans_prob(92, Xraylib::FL23_TRANS)
    assert_in_delta 1.0, sum, 1e-6

    sum =
      Xraylib.fluor_yield(92, Xraylib::M4_SHELL) +
      Xraylib.auger_yield(92, Xraylib::M4_SHELL) +
      Xraylib.cos_kron_trans_prob(92, Xraylib::FM45_TRANS)
    assert_in_delta 1.0, sum, 1e-6

    sum =
      Xraylib.fluor_yield(92, Xraylib::M2_SHELL) +
      Xraylib.auger_yield(92, Xraylib::M2_SHELL) +
      [Xraylib::FM23_TRANS, Xraylib::FM24_TRANS, Xraylib::FM25_TRANS].map do |trans|
        Xraylib.cos_kron_trans_prob(92, trans)
      end.sum
    assert_in_delta 1.0, sum, 1e-6
  end
end
