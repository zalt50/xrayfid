# frozen_string_literal: true

require "test_helper"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_ie_total
    ie(:total, 26, 10.0)
  end

  def test_ie_photo
    ie(:photo, 26, 10.0)
  end

  def test_ie_rayl
    ie(:rayl, 26, 10.0)
  end

  def test_ie_compt
    ie(:compt, 26, 10.0)
  end

  def test_iie_fluor_line
    iie(:fluor_line, 26, KL3_LINE, 10.0)
  end

  def test_iie_fluor_shell
    iie(:fluor_shell, 26, K_SHELL, 10.0)
  end

  def test_iee_rayl
    iee(:rayl, 26, 10.0, Math::PI / 4.0)
  end

  def test_iee_compt
    iee(:compt, 26, 10.0, Math::PI / 4.0)
  end

  def test_ieee_rayl
    ieee(:rayl, 26, 10.0, Math::PI / 4.0, Math::PI / 4.0)
  end

  def test_ieee_compt
    ieee(:compt, 26, 10.0, Math::PI / 4.0, Math::PI / 4.0)
  end

  private

  def ie(name, z, energy)
    cs = send("cs_#{name}", z, energy)
    assert 0.0 < cs
    aw = atomic_weight(z)
    assert 0.0 < aw
    assert_equal cs * aw / AVOGNUM, send("csb_#{name}", z, energy)
  end

  def iie(name, z, line, energy)
    cs = send("cs_#{name}", z, line, energy)
    assert 0.0 < cs
    aw = atomic_weight(z)
    assert 0.0 < aw
    assert_equal cs * aw / AVOGNUM, send("csb_#{name}", z, line, energy)
  end

  def iee(name, z, energy, theta)
    cs = send("dcs_#{name}", z, energy, theta)
    assert 0.0 < cs
    aw = atomic_weight(z)
    assert 0.0 < aw
    assert_equal cs * aw / AVOGNUM, send("dcsb_#{name}", z, energy, theta)
  end

  def ieee(name, z, energy, theta, phi)
    cs = send("dcsp_#{name}", z, energy, theta, phi)
    assert 0.0 < cs
    aw = atomic_weight(z)
    assert 0.0 < aw
    assert_equal cs * aw / AVOGNUM, send("dcspb_#{name}", z, energy, theta, phi)
  end
end
