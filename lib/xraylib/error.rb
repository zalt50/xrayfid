# frozen_string_literal: true

require_relative "libxrl"

module Xraylib
  class XrlMemoryError < RuntimeError; end
  class XrlInvalidArgumentError < RuntimeError; end
  class XrlIOError < RuntimeError; end
  class XrlTypeError < RuntimeError; end
  class XrlUnsupportedError < RuntimeError; end
  class XrlRuntimeError < RuntimeError; end

  private

  def check_error(error)
    unless error.null?
      case error[0, Libxrl::SIZEOF_ERRORCODE].unpack1("I!")
      when Libxrl::ERROR_MEMORY
        raise XrlMemoryError
      when Libxrl::ERROR_INVALID_ARGUMENT
        raise XrlInvalidArgumentError
      when Libxrl::ERROR_IO
        raise XrlIOError
      when Libxrl::ERROR_TYPE
        raise XrlTypeError
      when Libxrl::ERROR_UNSUPPORTED
        raise XrlUnsupportedError
      when Libxrl::ERROR_RUNTIME
        raise XrlRuntimeError
      end
    end
  end
end
