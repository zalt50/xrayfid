# frozen_string_literal: true

require_relative "xrayfid/version"

require_relative "xrayfid/auger"
require_relative "xrayfid/const"
require_relative "xrayfid/defs"
require_relative "xrayfid/error"
require_relative "xrayfid/libxrl"
require_relative "xrayfid/lines"
require_relative "xrayfid/shells"
require_relative "xrayfid/trans"

require "fast_underscore"

# Interface to xraylib for the interaction of X-rays with matter
module Xrayfid
  module_function

  # Atomic weights and element densities
  %w[AtomicWeight ElementDensity].each do |name|
    Libxrl.extern "double #{name}(int Z, xrl_error **error);"
    define_method(name.underscore) do |z|
      Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
        ret = Libxrl.send(name, z, error)
        ret unless error_exist?(error)
      end
    end
  end

  # Cross sections
  %w[CS CSb].each do |prefix|
    %w[Total Photo Rayl Compt].each do |name|
      Libxrl.extern "double #{prefix}_#{name}(int Z, double E, xrl_error **error);"
      define_method("#{prefix}_#{name}".downcase) do |z, energy|
        Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
          ret = Libxrl.send("#{prefix}_#{name}", z, energy, error)
          ret unless error_exist?(error)
        end
      end
    end
    %w[FluorLine FluorShell].each do |name|
      Libxrl.extern "double #{prefix}_#{name}(int Z, int line, double E, xrl_error **error);"
      define_method("#{prefix.downcase}_#{name.underscore}") do |z, line, energy|
        Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
          ret = Libxrl.send("#{prefix}_#{name}", z, line, energy, error)
          ret unless error_exist?(error)
        end
      end
    end
  end

  %w[Rayl Compt].each do |name|
    %w[DCS DCSb].each do |prefix|
      Libxrl.extern "double #{prefix}_#{name}(int Z, double E, double theta, xrl_error **error);"
      define_method("#{prefix}_#{name}".downcase) do |z, energy, theta|
        Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
          ret = Libxrl.send("#{prefix}_#{name}", z, energy, theta, error)
          ret unless error_exist?(error)
        end
      end
    end
    %w[DCSP DCSPb].each do |prefix|
      Libxrl.extern "double #{prefix}_#{name}(int Z, double E, double theta, double phi, xrl_error **error);"
      define_method("#{prefix}_#{name}".downcase) do |z, energy, theta, phi|
        Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
          ret = Libxrl.send("#{prefix}_#{name}", z, energy, theta, phi, error)
          ret unless error_exist?(error)
        end
      end
    end
  end

  Libxrl.extern "double CS_Energy(int z, double E, xrl_error **error);"
  def cs_energy(z, energy)
    Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
      ret = Libxrl.CS_Energy(z, energy, error)
      ret unless error_exist?(error)
    end
  end

  # Fractional radiative rate
  %w[LineEnergy RadRate].each do |name|
    Libxrl.extern "double #{name}(int Z, int line, xrl_error **error);"
    define_method(name.underscore) do |z, line|
      Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
        ret = Libxrl.send(name, z, line, error)
        ret unless error_exist?(error)
      end
    end
  end

  # Coster-Kronig transition probability
  Libxrl.extern "double CosKronTransProb(int Z, int trans, xrl_error **error);"
  def cos_kron_trans_prob(z, trans)
    Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
      ret = Libxrl.CosKronTransProb(z, trans, error)
      ret unless error_exist?(error)
    end
  end

  # Atomic level width, fluorescence yield and Auger yield
  %w[AtomicLevelWidth AugerYield EdgeEnergy FluorYield JumpFactor].each do |name|
    Libxrl.extern "double #{name}(int Z, int shell, xrl_error **error);"
    define_method(name.underscore) do |z, shell|
      Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
        ret = Libxrl.send(name, z, shell, error)
        ret unless error_exist?(error)
      end
    end
  end

  # Auger non-radiative rates
  Libxrl.extern "double AugerRate(int Z, int auger_trans, xrl_error **error);"
  def auger_rate(z, auger_trans)
    Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
      ret = Libxrl.AugerRate(z, auger_trans, error)
      ret unless error_exist?(error)
    end
  end

  # Element symbol that coressponds with atomic number
  Libxrl.extern "void xrlFree(void *);"
  Libxrl.extern "char* AtomicNumberToSymbol(int Z, xrl_error **error);"
  def atomic_number_to_symbol(z)
    Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
      ret_ptr = Libxrl.AtomicNumberToSymbol(z, error)
      unless error_exist?(error)
        ret = ret_ptr.to_s
        Libxrl.xrlFree(ret_ptr)
        ret
      end
    end
  end

  # Atomic number that corresponds with element symbol
  Libxrl.extern "int SymbolToAtomicNumber(const char *symbol, xrl_error **error);"
  def symbol_to_atomic_number(symbol)
    Fiddle::Pointer.malloc(Fiddle::SIZEOF_INTPTR_T, Fiddle::RUBY_FREE) do |error|
      ret = Libxrl.SymbolToAtomicNumber(symbol, error)
      ret unless error_exist?(error)
    end
  end
end
