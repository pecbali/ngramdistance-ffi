require 'ffi'

module NGramDistance
  PROPOSITIONAL=0
  BINARY=1
  COMPLEX=2
  extend FFI::Library

  # Try loading in order.
  library = File.dirname(__FILE__) + "/../ext/ngramdistance/ngramdistance"
  candidates = ['.bundle', '.dylib', ''].map { |ext| library + ext }
  ffi_lib(candidates)
  
  attach_function :distance_private, :ngramdistance, [:string, :string, :int, :int], :float
  
  def self.distance(source,target,ngram=3,mode=PROPOSITIONAL)
    distance_private(source,target,ngram,mode)
  end
end
