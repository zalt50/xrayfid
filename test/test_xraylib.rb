# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Xraylib::VERSION
  end

  def test_calling_libxrl_function
    assert_equal 12.01, Xraylib::Libxrl.AtomicWeight(6, nil)
  end
end
