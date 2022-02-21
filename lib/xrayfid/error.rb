# frozen_string_literal: true

require_relative "libxrl"

module Xrayfid
  class Error < StandardError; end
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

  def error_exist?(error)
    return false if error.ptr.null?

    code = error.ptr[0, Fiddle::SIZEOF_INT].unpack1("I!")
    message = (error.ptr + Fiddle::ALIGN_INTPTR_T).ptr.to_s
    Libxrl.xrl_error_free(error.ptr)
    case code
    when Libxrl::ERROR_MEMORY
      raise XrlMemoryError, message
    when Libxrl::ERROR_INVALID_ARGUMENT
      raise XrlInvalidArgumentError, message
    when Libxrl::ERROR_IO
      raise XrlIOError, message
    when Libxrl::ERROR_TYPE
      raise XrlTypeError, message
    when Libxrl::ERROR_UNSUPPORTED
      raise XrlUnsupportedError, message
    when Libxrl::ERROR_RUNTIME
      raise XrlRuntimeError, message
    end
  end
end
