# frozen_string_literal: true

require_relative "xraylib/version"
require_relative "xraylib/lines"
require_relative "xraylib/shells"
require "fiddle/import"
require "fast_underscore"

module Xraylib
  class Error < StandardError; end

  module Libxrl
    extend Fiddle::Importer

    lib_name = "libxrl.#{RbConfig::CONFIG["SOEXT"]}"
    begin
      dlload lib_name
    rescue Fiddle::DLError
      dlload "#{ENV["HOMEBREW_PREFIX"]}/lib/#{lib_name}" if ENV["HOMEBREW_PREFIX"]
    end

    # Atomic weights
    extern "double AtomicWeight(int Z, xrl_error **error);"

    # Element densities
    extern "double ElementDensity(int Z, xrl_error **error);"

    # Cross sections
    %w[Total Photo Rayl Compt].each do |name|
      extern "double CS_#{name}(int Z, double E, xrl_error **error);"
      extern "double CSb_#{name}(int Z, double E, xrl_error **error);"
    end

    %w[FluorLine FluorShell].each do |name|
      extern "double CS_#{name}(int Z, int line, double E, xrl_error **error);"
      extern "double CSb_#{name}(int Z, int line, double E, xrl_error **error);"
    end

    %w[Rayl Compt].each do |name|
      extern "double DCS_#{name}(int Z, double E, double theta, xrl_error **error);"
      extern "double DCSb_#{name}(int Z, double E, double theta, xrl_error **error);"
      extern "double DCSP_#{name}(int Z, double E, double theta, double phi, xrl_error **error);"
      extern "double DCSPb_#{name}(int Z, double E, double theta, double phi, xrl_error **error);"
    end

    extern "double CS_Energy(int z, double E, xrl_error **error);"
  end

  AVOGNUM = 0.602214129   # Avogadro number (mol-1 * barn-1 * cm2)
  KEV2ANGST = 12.39841930 # keV to angstrom-1 conversion factor
  MEC2 = 510.998928       # electron rest mass (keV)
  RE2 = 0.079407877       # square of classical electron radius (barn)
  R_E = 2.8179403267e-15  # Classical electron radius (m)

  module_function

  # Atomic weights
  def atomic_weight(z) = Libxrl.AtomicWeight(z, nil)

  # Element densities
  def element_density(z) = Libxrl.ElementDensity(z, nil)

  # Cross sections
  %w[Total Photo Rayl Compt].each do |name|
    define_method("cs_#{name.downcase}") do |z, energy|
      Libxrl.send("CS_#{name}", z, energy, nil)
    end
    define_method("csb_#{name.downcase}") do |z, energy|
      Libxrl.send("CSb_#{name}", z, energy, nil)
    end
  end

  %w[FluorLine FluorShell].each do |name|
    define_method("cs_#{name.underscore}") do |z, line, energy|
      Libxrl.send("CS_#{name}", z, line, energy, nil)
    end
    define_method("csb_#{name.underscore}") do |z, line, energy|
      Libxrl.send("CSb_#{name}", z, line, energy, nil)
    end
  end

  %w[Rayl Compt].each do |name|
    define_method("dcs_#{name.downcase}") do |z, energy, theta|
      Libxrl.send("DCS_#{name}", z, energy, theta, nil)
    end
    define_method("dcsb_#{name.downcase}") do |z, energy, theta|
      Libxrl.send("DCSb_#{name}", z, energy, theta, nil)
    end
    define_method("dcsp_#{name.downcase}") do |z, energy, theta, phi|
      Libxrl.send("DCSP_#{name}", z, energy, theta, phi, nil)
    end
    define_method("dcspb_#{name.downcase}") do |z, energy, theta, phi|
      Libxrl.send("DCSPb_#{name}", z, energy, theta, phi, nil)
    end
  end

  def cs_energy(z, energy) = Libxrl.CS_Energy(z, energy, nil)
end
