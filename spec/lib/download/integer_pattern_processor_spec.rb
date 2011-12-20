require 'spec_helper'

describe IntegerPatternProcessor do  
  it "should compute the index for an increment pattern correctly" do
    ip = IntegerPatternProcessor.new("increment:37:1")
    ip.compute(2).should == 39
  end
end
