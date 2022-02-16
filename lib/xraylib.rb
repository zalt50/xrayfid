# frozen_string_literal: true

require_relative "xraylib/version"
require_relative "xraylib/const"
require_relative "xraylib/defs"
require_relative "xraylib/lines"
require_relative "xraylib/shells"
require_relative "xraylib/trans"
require "fiddle/import"
require "fast_underscore"

# Interface to xraylib for the interaction of X-rays with matter
module Xraylib
  class Error < StandardError; end

  # Import xraylib functions from a shared library
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

  Libxrl.extern "double CosKronTransProb(int Z, int trans, xrl_error **error);"
  def cos_kron_trans_prob(z, trans) = Libxrl.CosKronTransProb(z, trans, nil)

  %w[FluorYield AugerYield].each do |name|
    Libxrl.extern "double #{name}(int Z, int shell, xrl_error **error);"
    define_method(name.underscore) do |z, shell|
      Libxrl.send(name, z, shell, nil)
    end
  end
end
