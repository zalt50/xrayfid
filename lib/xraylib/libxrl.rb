# frozen_string_literal: true

require "fiddle/import"
require "fast_underscore"

module Xraylib
  # Import xraylib functions from a shared library
  module Libxrl
    extend Fiddle::Importer

    lib_name = "libxrl.#{RbConfig::CONFIG["SOEXT"]}"
    begin
      dlload lib_name
    rescue Fiddle::DLError
      dlload "#{ENV["HOMEBREW_PREFIX"]}/lib/#{lib_name}" if ENV["HOMEBREW_PREFIX"]
    end

    ERROR_MEMORY           = 0
    ERROR_INVALID_ARGUMENT = 1
    ERROR_IO               = 2
    ERROR_TYPE             = 3
    ERROR_UNSUPPORTED      = 4
    ERROR_RUNTIME          = 5
  end
end
