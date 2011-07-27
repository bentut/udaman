require 'spec_helper'
require 'spec_data_hash.rb'

describe SeriesExternalRelationship do

  describe "PROGNOZ OUPUT FILE" do
    before(:all) do
      @dh = get_data_hash
      @visns_output_path = "#{ENV["DATAFILES_PATH"]}/datafiles/prognoz_output_month1.xls"
      @visns_output_file = PrognozDataFile.new(:name => "test data file", :filename => @visns_output_path, :frequency => "month")
      results = @visns_output_file.load
    end
  
    before(:each) do
      @visns_output_file.save
      @visns = @dh.ns "VISNS@HI.M"
    end
  
    describe "FINDING PROGNOZ output file" do    
      it "should find the Prognoz Data File object that contains it's outputted series data if it exists " do
        @visns.find_prognoz_data_file.filename.should == @visns_output_path
      end
  
      it "should return nil if series is not found in any of the loaded prognoz data files" do
      end
  
    end
  end



end