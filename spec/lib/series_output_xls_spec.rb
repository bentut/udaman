require 'spec_helper'

describe SeriesOutputXls do
  before (:each) do
    output_path = "#{ENV["DATAFILES_PATH"]}/datafiles/series_output_test.xls"
    @sox = SeriesOutputXls.new(output_path)
    @ones_data = { 
        "2001-01-01" => 1, "2002-01-01" => 1, "2003-01-01" => 1, "2004-01-01" => 1, "2005-01-01" => 1, "2006-01-01" => 1,
        "2007-01-01" => 1, "2008-01-01" => 1, "2009-01-01" => 1, "2010-01-01" => 1, "2011-01-01" => 1, "2012-01-01" => 1
    }
    @twos_data = { 
        "1995-01-01" => 2, "1996-01-01" => 2, "1997-01-01" => 2, "1998-01-01" => 2, "1999-01-01" => 2, "2000-01-01" => 2,
        "2001-01-01" => 2, "2002-01-01" => 2, "2003-01-01" => 2, "2004-01-01" => 2, "2005-01-01" => 2, "2006-01-01" => 2
        
    }
    @threes_data = { 
        "2007-01-01" => 3, "2008-01-01" => 3, "2009-01-01" => 3, "2010-01-01" => 3, "2011-01-01" => 3, "2012-01-01" => 3,
        "2013-01-01" => 3, "2014-01-01" => 3, "2015-01-01" => 3, "2016-01-01" => 3, "2017-01-01" => 3, "2018-01-01" => 3
    }
  end

  it "should be able to be able to add new series and data to the writing output" do
    @sox.add_data("ONES@TEST.M", @ones_data)
    @sox.series.count.should == 1
    @sox.series["ONES@TEST.M"].each {|date_string, value| value.should == @ones_data[date_string]}
  end
  
  it "should be able to calculate date range to print from the series present" do
    @sox.add_data("ONES@TEST.M", @ones_data)
    @sox.add_data("TWOS@TEST.M", @twos_data)
    @sox.add_data("THREES@TEST.M", @threes_data)
    @sox.dates.count.should == 24
    @sox.dates[0].should == "1995-01-01"
    @sox.dates[23].should == "2018-01-01"    
  end
  
  it "should not write a file if no data is present" do
    no_file_path = "#{ENV["DATAFILES_PATH"]}/datafiles/no_file.xls"
    sox_no_data = SeriesOutputXls.new(no_file_path)
    sox_no_data.write_xls
    File.exists?("#{ENV["DATAFILES_PATH"]}/datafiles/no_file.xls").should be_false
  end
  
   
  it "should write a file with the correct data" do
    @sox.add_data("ONES@TEST.M", @ones_data)
    @sox.add_data("TWOS@TEST.M", @twos_data)
    @sox.add_data("THREES@TEST.M", @threes_data)
    @sox.write_xls
    File.exists?(@sox.output_path).should be_true
  end
  
  #could also test the adding pattern, but was tested in practice. Perhaps can add if this starts to fail later
  
end