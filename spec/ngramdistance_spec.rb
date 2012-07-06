require 'spec_helper'

describe NGramDistance do
  fixtures = [
    ["university", "univearsitty", 0.750000],
    ["university", "university", 1.0],
    ["hello", "jello",0.633333],
    ["hello", "heloll", 0.666667],
    ["hello", "saint", 0.0000],
    ["hello", "", 0.0000]
  ]
  
  fixtures2 = [
    ["hello hello", "hello",1.0],
    ["hello world hello", "hello world", 1.0]
  ]
  
  fixtures3 = [
    ["hello world", "world hello",1.0],
    ["hello world hello", "hello world", 0.647]
  ]

  fixtures.each do |w1, w2, d|
    it "should calculate a distance of #{d} between #{w1} and #{w2}" do
      NGramDistance.distance(w1, w2,ngram=3).should be_within(0.05).of( d)
      NGramDistance.distance(w2, w1,ngram=3).should be_within(0.05).of( d)
    end
  end
  
  
  fixtures2.each do |w1, w2, d|
    it "should calculate a distance of #{d} between #{w1} and #{w2}" do
      NGramDistance.token_set_distance(w1, w2).should be_within(0.05).of( d)
      NGramDistance.token_set_distance(w2, w1).should be_within(0.05).of( d)
    end
  end
  
  
  fixtures3.each do |w1, w2, d|
    it "should calculate a distance of #{d} between #{w1} and #{w2}" do
      NGramDistance.token_sort_distance(w1, w2).should be_within(0.05).of( d)
      NGramDistance.token_sort_distance(w2, w1).should be_within(0.05).of( d)
    end
  end
  
end
