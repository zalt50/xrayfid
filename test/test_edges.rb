# frozen_string_literal: true

require "test_helper"
require "error_messages"

class TestXrayfid < Minitest::Test
  include Xrayfid

  def test_edge_energy_method_26
    assert_in_delta 7.112, edge_energy(26, K_SHELL), 1e-6
  end

  def test_edge_energy_method_1
    assert_in_delta 0.0136, edge_energy(1, K_SHELL), 1e-6
  end

  def test_edge_energy_method_92
    assert_in_delta 115.602, edge_energy(92, K_SHELL), 1e-6
  end

  def test_edge_energy_method_92_n7
    assert_in_delta 0.379, edge_energy(92, N7_SHELL), 1e-6
  end

  def test_edge_energy_method_92_p5
    assert_in_delta 0.0057, edge_energy(92, P5_SHELL), 1e-6
  end

  def test_edge_energy_method_bad
    error = assert_raises XrlInvalidArgumentError do
      edge_energy(0, K_SHELL)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      edge_energy(ZMAX + 1, K_SHELL)
    end

    assert_equal Z_OUT_OF_RANGE, error.message

    error = assert_raises XrlInvalidArgumentError do
      edge_energy(26, -1)
    end

    assert_equal UNKNOWN_SHELL, error.message

    error = assert_raises XrlInvalidArgumentError do
      edge_energy(26, SHELLNUM)
    end

    assert_equal UNKNOWN_SHELL, error.message

    error = assert_raises XrlInvalidArgumentError do
      edge_energy(26, P5_SHELL)
    end

    assert_equal INVALID_SHELL, error.message
  end
end
