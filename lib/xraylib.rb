# frozen_string_literal: true

require_relative "xraylib/version"
require "fiddle/import"

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
    extern "double CS_Total(int Z, double E, xrl_error **error);"
    extern "double CS_Photo(int Z, double E, xrl_error **error);"
    extern "double CS_Rayl(int Z, double E, xrl_error **error);"
    extern "double CS_Compt(int Z, double E, xrl_error **error);"
  end

  module_function

  # Atomic weights
  def atomic_weight(z) = Libxrl.AtomicWeight(z, nil)

  # Element densities
  def element_density(z) = Libxrl.ElementDensity(z, nil)

  # Cross sections
  def cs_total(z, energy) = Libxrl.CS_Total(z, energy, nil)
  def cs_photo(z, energy) = Libxrl.CS_Photo(z, energy, nil)
  def cs_rayl(z, energy) = Libxrl.CS_Rayl(z, energy, nil)
  def cs_compt(z, energy) = Libxrl.CS_Compt(z, energy, nil)
end
