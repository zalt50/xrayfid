# frozen_string_literal: true

require "test_helper"
require "error_messages"

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

  def test_ie_bad_total
    ie_bad(:total)
  end

  def test_ie_bad_photo
    ie_bad(:photo)
  end

  def test_ie_bad_rayl
    ie_bad(:rayl)
  end

  def test_ie_bad_compt
    ie_bad(:compt)
  end

  def test_iie_bad_fluor_line
    iie_bad(:fluor_line)
  end

  def test_iee_bad_rayl
    iee_bad(:rayl)
  end

  def test_iee_bad_compt
    iee_bad(:compt)
  end

  def test_ieee_bad_rayl
    ieee_bad(:rayl)
  end

  def test_ieee_bad_compt
    ieee_bad(:compt)
  end

  private

  def ie(name, z, energy)
    cs = send("cs_#{name}", z, energy)
    assert 0.0 < cs
    aw = atomic_weight(z)
    assert 0.0 < aw
    assert_equal cs * aw / AVOGNUM, send("csb_#{name}", z, energy)
  end

  def ie_bad(name)
    error = assert_raises XrlInvalidArgumentError do
      send("csb_#{name}", -1, 10.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      send("csb_#{name}", ZMAX, 10.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      send("csb_#{name}", 26, 0.0)
    end

    assert_equal NEGATIVE_ENERGY, error.message
  end

  def iie(name, z, line, energy)
    cs = send("cs_#{name}", z, line, energy)
    assert 0.0 < cs
    aw = atomic_weight(z)
    assert 0.0 < aw
    assert_equal cs * aw / AVOGNUM, send("csb_#{name}", z, line, energy)
  end

  def iie_bad(name)
    error = assert_raises XrlInvalidArgumentError do
      send("csb_#{name}", -1, KL3_LINE, 10.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      send("csb_#{name}", ZMAX, KL3_LINE, 10.0)
    end

    assert_equal INVALID_LINE, error.message

    error = assert_raises XrlInvalidArgumentError do
      send("csb_#{name}", 26, -500, 10.0)
    end

    assert_equal INVALID_LINE, error.message

    error = assert_raises XrlInvalidArgumentError do
      send("csb_#{name}", 26, KL3_LINE, 0.0)
    end

    assert_equal NEGATIVE_ENERGY, error.message
  end

  def iee(name, z, energy, theta)
    cs = send("dcs_#{name}", z, energy, theta)
    assert 0.0 < cs
    aw = atomic_weight(z)
    assert 0.0 < aw
    assert_equal cs * aw / AVOGNUM, send("dcsb_#{name}", z, energy, theta)
  end

  def iee_bad(name)
    error = assert_raises XrlInvalidArgumentError do
      send("dcsb_#{name}", -1, 10.0, Math::PI / 4.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      send("dcsb_#{name}", ZMAX, 10.0, Math::PI / 4.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      send("dcsb_#{name}", 26, 0.0, Math::PI / 4.0)
    end

    assert_equal NEGATIVE_ENERGY, error.message
  end

  def ieee(name, z, energy, theta, phi)
    cs = send("dcsp_#{name}", z, energy, theta, phi)
    assert 0.0 < cs
    aw = atomic_weight(z)
    assert 0.0 < aw
    assert_equal cs * aw / AVOGNUM, send("dcspb_#{name}", z, energy, theta, phi)
  end

  def ieee_bad(name)
    error = assert_raises XrlInvalidArgumentError do
      send("dcspb_#{name}", -1, 10.0, Math::PI / 4.0, Math::PI / 4.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      send("dcspb_#{name}", ZMAX, 10.0, Math::PI / 4.0, Math::PI / 4.0)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      send("dcspb_#{name}", 26, 0.0, Math::PI / 4.0, Math::PI / 4.0)
    end

    assert_equal NEGATIVE_ENERGY, error.message
  end
end
