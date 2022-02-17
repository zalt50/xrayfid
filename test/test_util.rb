# frozen_string_literal: true

require "test_helper"

class TestXrayfid < Minitest::Test
  def test_sizeof_error_code
    assert 0 < ::Xrayfid::Libxrl::SIZEOF_ERRORCODE
  end
end
