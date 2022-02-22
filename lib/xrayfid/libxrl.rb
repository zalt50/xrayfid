# frozen_string_literal: true

require "fiddle/import"
require "pathname"

module Xrayfid
  # Import xraylib functions from a shared library
  module Libxrl
    extend Fiddle::Importer

    libdir = ENV["XRAYLIB_DIR"] ? Pathname.new(ENV["XRAYLIB_DIR"]) + "lib" : ""
    dlload (libdir + "libxrl.#{RbConfig::CONFIG["SOEXT"]}").to_s
  end
end
