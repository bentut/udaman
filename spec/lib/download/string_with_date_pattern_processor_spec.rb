require 'spec_helper'

describe StringWithDatePatternProcessor do    
  it "should compute a single date element pattern correctly" do
    swdpp = StringWithDatePatternProcessor.new("BLS_HIWI%Y.XLS")
    swdpp.compute("1990-01-01").should == "BLS_HIWI1990.XLS"
    swdpp.compute("1990-05-01").should == "BLS_HIWI1990.XLS"
    swdpp.compute("1994-01-01").should == "BLS_HIWI1994.XLS"
  end
  
  it "should compute a two date element pattern correctly" do
    swdpp = StringWithDatePatternProcessor.new("Tour_%b%y.XLS")
    swdpp.compute("2011-03-01").should == "Tour_Mar11.XLS"
    swdpp.compute("2011-04-01").should == "Tour_Apr11.XLS"
    swdpp.compute("2010-05-01").should == "Tour_May10.XLS"
  end
  
  it "should compute a three date element pattern correctly" do
    swdpp = StringWithDatePatternProcessor.new("Tax_%b%y/%mcollec.XLS")
    swdpp.compute("2011-03-01").should == "Tax_Mar11/03collec.XLS"
    swdpp.compute("2011-04-01").should == "Tax_Apr11/04collec.XLS"
    swdpp.compute("2010-05-01").should == "Tax_May10/05collec.XLS"
  end

end
