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

  fixtures.each do |w1, w2, d|
    it "should calculate a distance of #{d} between #{w1} and #{w2}" do
      NGramDistance.distance(w1, w2,3).should be_within(0.05).of( d)
      NGramDistance.distance(w2, w1,3).should be_within(0.05).of( d)
    end
  end
end
