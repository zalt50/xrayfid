# frozen_string_literal: true

require "test_helper"

class TestXrayfid < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Xrayfid::VERSION
  end
end
