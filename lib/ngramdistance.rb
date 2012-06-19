require 'ffi'

module NGramDistance
  extend FFI::Library

  # Try loading in order.
  library = File.dirname(__FILE__) + "/../ext/ngramdistance/ngramdistance"
  candidates = ['.bundle', '.dylib', ''].map { |ext| library + ext }
  ffi_lib(candidates)
  
  attach_function :distance, :ngramdistance, [:string, :string, :int, :int], :float
end
