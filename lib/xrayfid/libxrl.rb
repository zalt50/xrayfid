# frozen_string_literal: true

require "fiddle/import"

module Xrayfid
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
end
