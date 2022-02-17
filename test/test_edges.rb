# frozen_string_literal: true

require "test_helper"

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
end
