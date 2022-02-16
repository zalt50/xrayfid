# frozen_string_literal: true

require_relative "xraylib/version"

require_relative "xraylib/const"
require_relative "xraylib/defs"
require_relative "xraylib/error"
require_relative "xraylib/libxrl"
require_relative "xraylib/lines"
require_relative "xraylib/shells"
require_relative "xraylib/trans"
require_relative "xraylib/util"

require "fast_underscore"

# Interface to xraylib for the interaction of X-rays with matter
module Xraylib
  class Error < StandardError; end

  module_function

  # Atomic weights and element densities
  %w[AtomicWeight ElementDensity].each do |name|
    Libxrl.extern "double #{name}(int Z, xrl_error **error);"
    define_method(name.underscore) do |z|
      error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
      ret = Libxrl.send(name, z, error)
      check_error(error.ptr) ? 0.0 : ret
    end
  end

  # Cross sections
  %w[CS CSb].each do |prefix|
    %w[Total Photo Rayl Compt].each do |name|
      Libxrl.extern "double #{prefix}_#{name}(int Z, double E, xrl_error **error);"
      define_method("#{prefix}_#{name}".downcase) do |z, energy|
        error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
        ret = Libxrl.send("#{prefix}_#{name}", z, energy, error)
        check_error(error.ptr) ? 0.0 : ret
      end
    end
    %w[FluorLine FluorShell].each do |name|
      Libxrl.extern "double #{prefix}_#{name}(int Z, int line, double E, xrl_error **error);"
      define_method("#{prefix.downcase}_#{name.underscore}") do |z, line, energy|
        error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
        ret = Libxrl.send("#{prefix}_#{name}", z, line, energy, error)
        check_error(error.ptr) ? 0.0 : ret
      end
    end
  end

  %w[Rayl Compt].each do |name|
    %w[DCS DCSb].each do |prefix|
      Libxrl.extern "double #{prefix}_#{name}(int Z, double E, double theta, xrl_error **error);"
      define_method("#{prefix}_#{name}".downcase) do |z, energy, theta|
        error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
        ret = Libxrl.send("#{prefix}_#{name}", z, energy, theta, error)
        check_error(error.ptr) ? 0.0 : ret
      end
    end
    %w[DCSP DCSPb].each do |prefix|
      Libxrl.extern "double #{prefix}_#{name}(int Z, double E, double theta, double phi, xrl_error **error);"
      define_method("#{prefix}_#{name}".downcase) do |z, energy, theta, phi|
        error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
        ret = Libxrl.send("#{prefix}_#{name}", z, energy, theta, phi, error)
        check_error(error.ptr) ? 0.0 : ret
      end
    end
  end

  Libxrl.extern "double CS_Energy(int z, double E, xrl_error **error);"
  def cs_energy(z, energy)
    error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
    ret = Libxrl.CS_Energy(z, energy, error)
    check_error(error.ptr) ? 0.0 : ret
  end

  # Fractional radiative rate
  Libxrl.extern "double RadRate(int Z, int line, xrl_error **error);"
  def rad_rate(z, line)
    error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
    ret = Libxrl.RadRate(z, line, error)
    check_error(error.ptr) ? 0.0 : ret
  end

  # Coster-Kronig transition probability
  Libxrl.extern "double CosKronTransProb(int Z, int trans, xrl_error **error);"
  def cos_kron_trans_prob(z, trans)
    error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
    ret = Libxrl.CosKronTransProb(z, trans, error)
    check_error(error.ptr) ? 0.0 : ret
  end

  # Atomic level width, fluorescence yield and Auger yield
  %w[AtomicLevelWidth AugerYield EdgeEnergy FluorYield JumpFactor].each do |name|
    error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
    Libxrl.extern "double #{name}(int Z, int shell, xrl_error **error);"
    define_method(name.underscore) do |z, shell|
      error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T)
      ret = Libxrl.send(name, z, shell, error)
      check_error(error.ptr) ? 0.0 : ret
    end
  end
end
