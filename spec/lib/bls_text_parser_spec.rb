require 'spec_helper'

describe BlsTextParser do
  # it "should read in a text file" do
  # end
  # it "should skip a prescribed number of lines" do
  # end
  it "should read all data rows into a hash with the series code as the key" do
    btp = BlsTextParser.new("spec/datafiles/specs/blstextfile.txt")
    data_hash = btp.get_data_hash
    data_hash.count.should > 3
    data_hash.keys.index("SMS15000000000000001").should_not be_nil
    data_hash.keys.index("SMS15000001500000001").should_not be_nil
  end
  it "should create a hash with monthly data if available as value for each code key" do
    btp = BlsTextParser.new("spec/datafiles/specs/blstextfile.txt")
    data_hash = btp.get_data_hash
    data_hash["SMU15000000000000001"]["M"].class.should == Hash
    data_hash["SMU15000000000000001"]["M"].keys.index("1964-01-01").should_not be_nil
    data_hash["SMU15000000000000001"]["M"].keys.index("1964-12-01").should_not be_nil
    data_hash["SMU15000000000000001"]["M"].keys.index("1963-01-01").should_not be_nil
    data_hash["SMU15000000000000001"]["M"]["1964-12-01"].should == "211.4"
    data_hash["SMU15000000000000001"]["M"]["1964-06-01"].should == "214.6"
    
  end
  
  it "should create a hash with annual data if available as value for each code key" do
    btp = BlsTextParser.new("spec/datafiles/specs/blstextfile.txt")
    data_hash = btp.get_data_hash
    data_hash["SMU15000000000000001"]["A"].class.should == Hash
    data_hash["SMU15000000000000001"]["A"].keys.index("1964-01-01").should_not be_nil
    data_hash["SMU15000000000000001"]["A"].keys.index("1963-01-01").should_not be_nil
    data_hash["SMU15000000000000001"]["A"]["1963-01-01"].should == "207.8"
  end

  it "should create a hash with quarterly data if available as value for each code key" do
    btp = BlsTextParser.new("spec/datafiles/specs/blstextfile.txt")
    data_hash = btp.get_data_hash
    data_hash["SMU15000000000000001"]["Q"].class.should == Hash
    data_hash["SMU15000000000000001"]["Q"].keys.index("1964-01-01").should_not be_nil
    data_hash["SMU15000000000000001"]["Q"].keys.index("1963-01-01").should_not be_nil
  end
  
end