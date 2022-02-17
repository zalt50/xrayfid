# frozen_string_literal: true

require_relative "libxrl"

module Xrayfid
  class XrlMemoryError < RuntimeError; end
  class XrlInvalidArgumentError < RuntimeError; end
  class XrlIOError < RuntimeError; end
  class XrlTypeError < RuntimeError; end
  class XrlUnsupportedError < RuntimeError; end
  class XrlRuntimeError < RuntimeError; end

  module Libxrl
    ERROR_MEMORY           = 0
    ERROR_INVALID_ARGUMENT = 1
    ERROR_IO               = 2
    ERROR_TYPE             = 3
    ERROR_UNSUPPORTED      = 4
    ERROR_RUNTIME          = 5

    extern "void xrl_error_free(xrl_error *error);"
  end

  private

  def check_error(error)
    unless error.null?
      code = error[0, Libxrl::SIZEOF_ERRORCODE].unpack1("I!")
      Libxrl.xrl_error_free(error)
      case code
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
