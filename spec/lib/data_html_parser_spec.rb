require 'spec_helper'

describe DataHtmlParser do
  before(:all) do
    @dhp = DataHtmlParser.new
    #have to fix this to make static
    @bls_text = @dhp.get_bls_series('CES0000000001',"M")
  end
  it "should connect to a website with optional post parameters and return a parseable object" do
    @dhp.doc.class.should == Nokogiri::HTML::Document
  end
  
  it "should be able to extract the relevant BLS portion of a webpage" do
    blstext = "\r\n Employment, Hours, and Earnings from the Current"
    @dhp.bls_text.length.should == 25902 #starts_with?(blstext).should be_true
  end
  
  it "should be able to convert a year and month combo into a date" do
    @dhp.get_date("1992","M05").should == "1992-05-01"
    @dhp.get_date("1992","M10").should == "1992-10-01"
    @dhp.get_date("1992","M12").should == "1992-12-01"
  end
  
  it "should be able to convert a year and semi combo into a date" do
    @dhp.get_date("1992","S1").should == "1992-01-01"
    @dhp.get_date("1992","S2").should == "1992-06-01"

  end
  
  it "should be able to convert a year and month 13 combo into the correct date" do
    @dhp.get_date("1992","M13").should == "1992-01-01"
  end
  
  it "should be able to extract series data from download" do
    data = @dhp.data
    data.class.should == Hash
    data.keys.should == ["M"]
    data["M"].count.should == 872
    data["M"]["2009-06-01"].should == 130493
  end

end