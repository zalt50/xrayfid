# frozen_string_literal: true

require "test_helper"

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
end
