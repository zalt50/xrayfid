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
    end
  end

  module_function

  # Atomic weights
  def atomic_weight(z) = Libxrl.AtomicWeight(z, nil)

  # Element densities
  def element_density(z) = Libxrl.ElementDensity(z, nil)

  # Cross sections
  Libxrl.singleton_methods.select { |sym| /^CS_/ =~ sym }.each do |sym|
    define_method(sym.to_s.underscore) do |z, energy|
      Libxrl.send(sym, z, energy, nil)
    end
  end
end
