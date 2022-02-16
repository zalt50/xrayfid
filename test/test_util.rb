# frozen_string_literal: true

require "test_helper"

class TestXraylib < Minitest::Test
  def test_sizeof_error_code
    assert 0 < ::Xraylib::Libxrl::SIZEOF_ERRORCODE
  end
end
