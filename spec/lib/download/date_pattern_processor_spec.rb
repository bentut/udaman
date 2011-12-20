require 'spec_helper'

#figure out what to do with error conditions in these tests
describe DatePatternProcessor do  
  
  it "should compute the index of a given date for an annual pattern" do
    dpp = DatePatternProcessor.new("2000-01-01", "A", false)
    dpp.compute_index_for_date("2005-01-01").should == 5
  end

  it "should compute the index of a given date for an semi-annual pattern" do
    dpp = DatePatternProcessor.new("2000-01-01", "S", false)
    dpp.compute_index_for_date("2005-01-01").should == 10
  end
  
  it "should compute the index of a given date for an quarterly pattern" do
    dpp = DatePatternProcessor.new("2000-01-01", "Q", false)
    dpp.compute_index_for_date("2005-01-01").should == 20
  end
  
  it "should compute the index of a given date for an monthly pattern" do
    dpp = DatePatternProcessor.new("2000-01-01", "M", false)
    dpp.compute_index_for_date("2005-01-01").should == 60
  end
  
  it "should compute the index of a given date for an weekly pattern" do
    dpp = DatePatternProcessor.new("2000-01-01", "W", false)  
    dpp.compute_index_for_date("2000-01-15").should == 2
  end
  
  it "should compute the index of a given date for an daily pattern" do
    dpp = DatePatternProcessor.new("2000-01-01", "D", false)  
    dpp.compute_index_for_date("2000-01-16").should == 15
  end
  
  it "should compute the date for a given index for a weekday pattern in reverse" do
    dpp = DatePatternProcessor.new("2011-08-26", "WD", true) #friday
    dpp.compute(32).should == "2011-07-13"
    dpp.compute(5).should == "2011-08-19"
    dpp = DatePatternProcessor.new("2011-08-25", "WD", true) #thursday
    dpp.compute(31).should == "2011-07-13"
    dpp.compute(5).should == "2011-08-18"
    dpp = DatePatternProcessor.new("2011-08-24", "WD", true) #wednesday
    dpp.compute(30).should == "2011-07-13"
    dpp.compute(5).should == "2011-08-17"
    dpp = DatePatternProcessor.new("2011-08-23", "WD", true) #tuesday
    dpp.compute(29).should == "2011-07-13"
    dpp.compute(5).should == "2011-08-16"
    dpp = DatePatternProcessor.new( "2011-08-22", "WD", true) #monday
    dpp.compute(28).should == "2011-07-13"
    dpp.compute(5).should == "2011-08-15"
  end
  
  it "should compute the index of a given date for a weekday pattern in reverse" do
    dpp = DatePatternProcessor.new("2011-08-26", "WD", true) #friday
    dpp.compute_index_for_date("2011-07-13").should == 32
    dpp.compute_index_for_date("2011-08-19").should == 5
    dpp = DatePatternProcessor.new("2011-08-25", "WD", true) #thursday
    dpp.compute_index_for_date("2011-07-13").should == 31
    dpp.compute_index_for_date("2011-08-18").should == 5
    dpp = DatePatternProcessor.new("2011-08-24", "WD", true) #wednesday
    dpp.compute_index_for_date("2011-07-13").should == 30
    dpp.compute_index_for_date("2011-08-17").should == 5
    dpp = DatePatternProcessor.new("2011-08-23", "WD", true) #tuesday
    dpp.compute_index_for_date("2011-07-13").should == 29
    dpp.compute_index_for_date("2011-08-16").should == 5
    dpp = DatePatternProcessor.new("2011-08-22", "WD", true) #monday
    dpp.compute_index_for_date("2011-07-13").should == 28
    dpp.compute_index_for_date("2011-08-15").should == 5
  end
  
end
