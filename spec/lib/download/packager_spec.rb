require 'spec_helper'

describe Packager do
    
  before (:each) do
    @dsd = mock "data_source_download"
    @dsd.stub(:download).and_return({:status => 200})
    @dsd.stub(:url).and_return("http://broken_download.com")
    DataSourceDownload.stub!(:get).and_return(@dsd)
    @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern.xls")
  end
  
  it "should add definitions " do
    p = Packager.new
    p.definitions.should be_nil
    options = %Q|{ :file_type => "xls", :start_date => "2000-01-01", :sheet => "increment_col_a", :row => 2, :col => "increment:3:1", :frequency => "A" }|
    p.add_definitions({"TEST@HI.A" => %Q|"TEST@HI.A".tsn.load_from_download "HANDLE@TEST.COM", #{options}|})
    p.definitions.count.should == 1
    p.add_definitions({
      "TEST2@HI.A" => %Q|"TEST2@HI.A".tsn.load_from_download "HANDLE@TEST.COM", #{options}|,
      "TEST3@HI.A" => %Q|"TEST3@HI.A".tsn.load_from_download "HANDLE@TEST.COM", #{options}|
    })
    p.definitions.count.should == 3 
    p.add_definitions({"TEST@HI.A" => %Q|"TEST2@HI.A".tsn.load_from_download "HANDLE@TEST.COM", #{options}|})
    p.definitions.count.should == 3 
  end
  
  it "should get return series data when requested" do
    p = Packager.new
    
    p.stub(:eval).and_return(Series.create_dummy("dummy", :year, "2000-01-01",0,3))

    p.add_definitions({
      "TEST@HI.A" => %Q|stub eval|,
      "TEST2@HI.A" => %Q|stub eval|,
      "TEST3@HI.A" => %Q|stub eval|
    })

    dfd = p.get_data_from_definitions

    dfd.count.should == 3
    dfd["TEST@HI.A"].should == {"2000-01-01" => 0, "2001-01-01" => 1, "2002-01-01" => 2, "2003-01-01" => 3 }
    dfd["TEST2@HI.A"].should == {"2000-01-01" => 0, "2001-01-01" => 1, "2002-01-01" => 2, "2003-01-01" => 3 }
    dfd["TEST3@HI.A"].should == {"2000-01-01" => 0, "2001-01-01" => 1, "2002-01-01" => 2, "2003-01-01" => 3 }
  end
  
  it "should raise an error if download results are accessed before series are evaluated" do
    p = Packager.new
    lambda { dr = p.download_results }.should raise_error(RuntimeError, "download results have not been set")
  end

  it "should populate download results" do
    p = Packager.new
    
    options = %Q|{ :file_type => "xls", :start_date => "2000-01-01", :sheet => "increment_col_a", :row => 2, :col => "increment:3:1", :frequency => "A" }|
    p.add_definitions({
      "TEST@HI.A" => %Q|"TEST@HI.A".tsn.load_from_download "HANDLE@TEST.COM", #{options}|,
      "TEST2@HI.A" => %Q|"TEST2@HI.A".tsn.load_from_download "HANDLE2@TEST.COM", #{options}|,
      "TEST3@HI.A" => %Q|"TEST3@HI.A".tsn.load_from_download "HANDLE@TEST.COM", #{options}|
    })

    p.get_data_from_definitions
    dr = p.download_results

    dr.count.should == 2
    dr["HANDLE@TEST.COM"].should == {:status => 200}
    dr["HANDLE2@TEST.COM"].should == {:status => 200}
  end
  
  it "should produce definitions when requested" do
     p = Packager.new

      options = %Q|{ :file_type => "xls", :start_date => "2000-01-01", :sheet => "increment_col_a", :row => 2, :col => "increment:3:1", :frequency => "A" }|
      p.add_definitions({
        "TEST@HI.A" => %Q|"TEST@HI.A".tsn.load_from_download "HANDLE@TEST.COM", #{options}|,
        "TEST2@HI.A" => %Q|"TEST2@HI.A".tsn.load_from_download "HANDLE@TEST.COM", #{options}|,
        "TEST3@HI.A" => %Q|"TEST3@HI.A".tsn.load_from_download "HANDLE@TEST.COM", #{options}|
      })

      d = p.definitions

      d.count.should == 3
      d["TEST@HI.A"].should  == %Q|"TEST@HI.A".tsn.load_from_download "HANDLE@TEST.COM", { :file_type => "xls", :start_date => "2000-01-01", :sheet => "increment_col_a", :row => 2, :col => "increment:3:1", :frequency => "A" }|
      d["TEST2@HI.A"].should == %Q|"TEST2@HI.A".tsn.load_from_download "HANDLE@TEST.COM", { :file_type => "xls", :start_date => "2000-01-01", :sheet => "increment_col_a", :row => 2, :col => "increment:3:1", :frequency => "A" }|
      d["TEST3@HI.A"].should == %Q|"TEST3@HI.A".tsn.load_from_download "HANDLE@TEST.COM", { :file_type => "xls", :start_date => "2000-01-01", :sheet => "increment_col_a", :row => 2, :col => "increment:3:1", :frequency => "A" }|
  end
  
  it "should write definitions to database" do
      p = Packager.new
      Series.create_dummy("dummy@HI.A", :year, "2000-01-01",0,3)

      options = %Q|{ :file_type => "xls", :start_date => "2000-01-01", :sheet => "increment_col_a", :row => 2, :col => "increment:3:1", :frequency => "A" }|
      p.add_definitions({
        "TEST@HI.A" => %Q|"dummy@HI.A".ts|,
        "TEST2@HI.A" => %Q|"dummy@HI.A".ts|,
        "TEST3@HI.A" => %Q|"dummy@HI.A".ts|
      })

      p.write_definitions_to "udaman"
      "TEST@HI.A".ts.data.should == {"2000-01-01" => 0, "2001-01-01" => 1, "2002-01-01" => 2, "2003-01-01" => 3 }
      "TEST2@HI.A".ts.data.should == {"2000-01-01" => 0, "2001-01-01" => 1, "2002-01-01" => 2, "2003-01-01" => 3 }
      "TEST3@HI.A".ts.data.should == {"2000-01-01" => 0, "2001-01-01" => 1, "2002-01-01" => 2, "2003-01-01" => 3 }
  end
  
  it "should write definitions to a file" do
    p = Packager.new
    p.stub(:eval).and_return(Series.create_dummy("dummy", :year, "2000-01-01",0,3))

    p.add_definitions({
      "TEST@HI.A" => %Q|stub definition|,
      "TEST2@HI.A" => %Q|stub definition|,
      "TEST3@HI.A" => %Q|stub definition|
    })
    
    filename = "#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/packager_test.xls"
    p.write_definitions_to filename
    
    File::exists?(filename).should be_true
    "TEST@HI.A".tsn.load_from(filename).data.should == {"2000-01-01" => 0, "2001-01-01" => 1, "2002-01-01" => 2, "2003-01-01" => 3 }
    "TEST2@HI.A".tsn.load_from(filename).data.should == {"2000-01-01" => 0, "2001-01-01" => 1, "2002-01-01" => 2, "2003-01-01" => 3 }
    "TEST3@HI.A".tsn.load_from(filename).data.should == {"2000-01-01" => 0, "2001-01-01" => 1, "2002-01-01" => 2, "2003-01-01" => 3 }
    File::delete filename
    File::exists?(filename).should be_false
  end
    
end