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
  end

  AVOGNUM = 0.602214129   # Avogadro number (mol-1 * barn-1 * cm2)
  KEV2ANGST = 12.39841930 # keV to angstrom-1 conversion factor
  MEC2 = 510.998928       # electron rest mass (keV)
  RE2 = 0.079407877       # square of classical electron radius (barn)
  R_E = 2.8179403267e-15  # Classical electron radius (m)

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
end
