# frozen_string_literal: true

require_relative "xraylib/version"
require_relative "xraylib/lines"
require_relative "xraylib/shells"
require "fiddle/import"
require "fast_underscore"

module Xraylib
  class Error < StandardError; end

  AVOGNUM = 0.602214129   # Avogadro number (mol-1 * barn-1 * cm2)
  KEV2ANGST = 12.39841930 # keV to angstrom-1 conversion factor
  MEC2 = 510.998928       # electron rest mass (keV)
  RE2 = 0.079407877       # square of classical electron radius (barn)
  R_E = 2.8179403267e-15  # Classical electron radius (m)

  KA_LINE = 0
  KB_LINE = 1
  LA_LINE = 2
  LB_LINE = 3

  KA1_LINE = KL3_LINE
  KA2_LINE = KL2_LINE
  KA3_LINE = KL1_LINE
  KB1_LINE = KM3_LINE
  KB2_LINE = KN3_LINE
  KB3_LINE = KM2_LINE
  KB4_LINE = KN5_LINE
  KB5_LINE = KM5_LINE

  LA1_LINE = L3M5_LINE
  LA2_LINE = L3M4_LINE
  LB1_LINE = L2M4_LINE
  LB2_LINE = L3N5_LINE
  LB3_LINE = L1M3_LINE
  LB4_LINE = L1M2_LINE
  LB5_LINE = L3O45_LINE
  LB6_LINE = L3N1_LINE
  LB7_LINE = L3O1_LINE
  LB9_LINE = L1M5_LINE
  LB10_LINE = L1M4_LINE
  LB15_LINE = L3N4_LINE
  LB17_LINE = L2M3_LINE
  LG1_LINE = L2N4_LINE
  LG2_LINE = L1N2_LINE
  LG3_LINE = L1N3_LINE
  LG4_LINE = L1O3_LINE
  LG5_LINE = L2N1_LINE
  LG6_LINE = L2O4_LINE
  LG8_LINE = L2O1_LINE
  LE_LINE = L2M1_LINE
  LH_LINE = L2M1_LINE
  LL_LINE = L3M1_LINE
  LS_LINE = L3M3_LINE
  LT_LINE = L3M2_LINE
  LU_LINE = L3N6_LINE
  LV_LINE = L2N6_LINE

  MA1_LINE = M5N7_LINE
  MA2_LINE = M5N6_LINE
  MB_LINE = M4N6_LINE
  MG_LINE = M3N5_LINE

  FL12_TRANS = 1
  FL13_TRANS = 2
  FLP13_TRANS = 3
  FL23_TRANS = 4
  FM12_TRANS = 5
  FM13_TRANS = 6
  FM14_TRANS = 7
  FM15_TRANS = 8
  FM23_TRANS = 9
  FM24_TRANS = 10
  FM25_TRANS = 11
  FM34_TRANS = 12
  FM35_TRANS = 13
  FM45_TRANS = 14

  module Libxrl
    extend Fiddle::Importer

    lib_name = "libxrl.#{RbConfig::CONFIG["SOEXT"]}"
    begin
      dlload lib_name
    rescue Fiddle::DLError
      dlload "#{ENV["HOMEBREW_PREFIX"]}/lib/#{lib_name}" if ENV["HOMEBREW_PREFIX"]
    end
  end

  module_function

  # Atomic weights
  Libxrl.extern "double AtomicWeight(int Z, xrl_error **error);"
  def atomic_weight(z) = Libxrl.AtomicWeight(z, nil)

  # Element densities
  Libxrl.extern "double ElementDensity(int Z, xrl_error **error);"
  def element_density(z) = Libxrl.ElementDensity(z, nil)

  # Cross sections
  %w[CS CSb].each do |prefix|
    %w[Total Photo Rayl Compt].each do |name|
      Libxrl.extern "double #{prefix}_#{name}(int Z, double E, xrl_error **error);"
      define_method("#{prefix}_#{name}".downcase) do |z, energy|
        Libxrl.send("#{prefix}_#{name}", z, energy, nil)
      end
    end
    %w[FluorLine FluorShell].each do |name|
      Libxrl.extern "double #{prefix}_#{name}(int Z, int line, double E, xrl_error **error);"
      define_method("#{prefix.downcase}_#{name.underscore}") do |z, line, energy|
        Libxrl.send("#{prefix}_#{name}", z, line, energy, nil)
      end
    end
  end

  %w[Rayl Compt].each do |name|
    %w[DCS DCSb].each do |prefix|
      Libxrl.extern "double #{prefix}_#{name}(int Z, double E, double theta, xrl_error **error);"
      define_method("#{prefix}_#{name}".downcase) do |z, energy, theta|
        Libxrl.send("#{prefix}_#{name}", z, energy, theta, nil)
      end
    end
    %w[DCSP DCSPb].each do |prefix|
      Libxrl.extern "double #{prefix}_#{name}(int Z, double E, double theta, double phi, xrl_error **error);"
      define_method("#{prefix}_#{name}".downcase) do |z, energy, theta, phi|
        Libxrl.send("#{prefix}_#{name}", z, energy, theta, phi, nil)
      end
    end
  end

  Libxrl.extern "double CS_Energy(int z, double E, xrl_error **error);"
  def cs_energy(z, energy) = Libxrl.CS_Energy(z, energy, nil)

  Libxrl.extern "double RadRate(int Z, int line, xrl_error **error);"
  def rad_rate(z, line) = Libxrl.RadRate(z, line, nil)
end
