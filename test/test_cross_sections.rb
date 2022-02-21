# frozen_string_literal: true

require "test_helper"
require "error_messages"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_cs_photo_method
    assert_in_delta 11.451033638148562, cs_photo(10, 10.0), 1e-4
  end

  def test_cs_compt_method
    assert_in_delta 0.11785269096475783, cs_compt(10, 10.0), 1e-4
  end

  def test_cs_rayl_method
    assert_in_delta 0.39841164641058013, cs_rayl(10, 10.0), 1e-4
  end

  def test_cs_total_method
    cs_photo = cs_photo(10, 10.0)
    cs_compt = cs_compt(10, 10.0)
    cs_rayl = cs_rayl(10, 10.0)
    assert_in_delta cs_photo + cs_compt + cs_rayl, cs_total(10, 10.0), 1e-3
  end

  def test_cs_energy
    assert_in_delta 11.420221747941419, cs_energy(10, 10.0), 1e-4
  end

  def test_cs_bad_z_neg
    %i[cs_photo cs_compt cs_rayl cs_total cs_energy].each do |method|
      error = assert_raises XrlInvalidArgumentError do
        send(method, -1, 10.0)
      end

      assert_equal Z_OUT_OF_RANGE, error.message
    end
  end

  def test_cs_bad_z_max
    %i[cs_photo cs_compt cs_rayl cs_total cs_energy].each do |method|
      error = assert_raises XrlInvalidArgumentError do
        send(method, ZMAX, 10.0)
      end

      assert_equal Z_OUT_OF_RANGE, error.message
    end
  end

  def test_cs_bad_energy_0
    %i[cs_photo cs_compt cs_rayl cs_total cs_energy].each do |method|
      error = assert_raises XrlInvalidArgumentError do
        send(method, 26, 0.0)
      end

      assert_equal NEGATIVE_ENERGY, error.message
    end
  end

  def test_cs_bad_energy_neg_1
    %i[cs_photo cs_compt cs_rayl cs_total cs_energy].each do |method|
      error = assert_raises XrlInvalidArgumentError do
        send(method, 26, -1.0)
      end

      assert_equal NEGATIVE_ENERGY, error.message
    end
  end

  def test_cs_bad_energy_max
    { cs_photo: 1001, cs_compt: 801, cs_rayl: 801, cs_total: 801, cs_energy: 20_001 }.each do |method, max|
      error = assert_raises XrlInvalidArgumentError do
        send(method, 26, max)
      end

      assert_equal SPLINT_X_TOO_HIGH, error.message
    end
  end

  def test_cs_bad_energy_min
    { cs_photo: 0.09, cs_compt: 0.09, cs_rayl: 0.09, cs_total: 0.09, cs_energy: 0.9 }.each do |method, max|
      error = assert_raises XrlInvalidArgumentError do
        send(method, 26, max)
      end

      assert_equal SPLINT_X_TOO_LOW, error.message
    end
  end
end
