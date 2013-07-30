require 'ffi'
require 'set'
module NGramDistance
  PROPOSITIONAL=0
  BINARY=1
  COMPLEX=2
  extend FFI::Library

  # Try loading in order.
  library = File.dirname(__FILE__) + "/../ext/ngramdistance/ngramdistance"
  candidates = ['.bundle', ".#{FFI::Platform::LIBSUFFIX}"].map { |ext| library + ext }
  ffi_lib(candidates)
  
  attach_function :distance_private, :ngramdistance, [:string, :string, :int, :int], :float
  
  def self.distance(source,target,ngram=3,mode=PROPOSITIONAL)
    distance_private(source,target,ngram,mode)
  end
  
  def self.token_set_distance(source,target,regex=' ',ngram=3,mode=PROPOSITIONAL)
    if source.nil? or target.nil?
      if(source == targer)
        return 1.0
      end
      return 0.0
    end
    return distance(token_set(source,regex),token_set(target,regex),ngram,mode)
  end
  
  def self.token_sort_distance(source, target,regex=' ',ngram=3,mode=PROPOSITIONAL)
    if source.nil? or target.nil?
      if(source == targer)
        return 1.0
      end
      return 0.0
    end
    return distance(token_sort(source,regex),token_sort(target,regex),ngram,mode)
  end
  
  private
  
  def self.token_set(source,regex)
    set = SortedSet.new
    tokens = source.split(regex)
    tokens.each do |token|
      set.add token
    end
    return set.to_a.join(' ')
  end

  def self.token_sort(source, regex)
    tokens = source.split(regex)
    tokens.sort!
    return tokens.join(' ')
  end  
end
