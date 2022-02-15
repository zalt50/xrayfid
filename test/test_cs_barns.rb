# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  def test_cs_total_method
    assert_equal 0.3717235309719578, Xraylib.cs_total(26, 100.0)
  end

  def test_cs_photo_method
    assert_equal 0.20443433907301226, Xraylib.cs_photo(26, 100.0)
  end

  def test_cs_rayl_method
    assert_equal 0.0376750946443608, Xraylib.cs_rayl(26, 100.0)
  end

  def test_cs_compt_method
    assert_equal 0.12961409725458475, Xraylib.cs_compt(26, 100.0)
  end
end
