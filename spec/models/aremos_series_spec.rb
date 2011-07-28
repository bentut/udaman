require 'spec_helper'
require 'spec_data_hash.rb'
#lop

describe AremosSeries do
  it "(AremosSeries) should read in a single annual series from TSD file into AremosSeries objects" do
    AremosSeries.load_tsd "#{ENV["DATAFILES_PATH"]}/datafiles/specs/single_tsd/A_DATA_TOUR.TSD"
    s = AremosSeries.first
    s.name.should == "NAIV@HI.A"
    s.frequency.should == "A"
    s.description.should_not be_nil
    s.start.should == "1999-01-01"
    s.end.should == "2010-01-01"
    s.aremos_data.count.should == 12
    s.data.count.should == 12
    s.data["1999-01-01"].should == 1.390833
    s.data["2010-01-01"].should == 1.259582
    s.aremos_update_date.should == Date.parse("2011-03-09")
  end
  
  it "(AremosSeries) should read in a single quarterly series from TSD file into AremosSeries objects" do
    AremosSeries.load_tsd "#{ENV["DATAFILES_PATH"]}/datafiles/specs/single_tsd/Q_DATA_TOUR.TSD"
    s = AremosSeries.first
    s.name.should == "NAIVCANNS@HI.Q"
    s.frequency.should == "Q"
    s.description.should_not be_nil
    s.start.should == "1999-01-01"
    s.end.should == "2010-10-01"
    s.aremos_data.count.should == 48
    s.data.count.should == 48
    s.data["1999-01-01"].should == 1.160000
    s.data["2010-10-01"].should == 1.318489
    s.aremos_update_date.should == Date.parse("2011-03-14")
  end
  
  it "(AremosSeries) should read in a single monthly series from TSD file into AremosSeries objects" do
    AremosSeries.load_tsd "#{ENV["DATAFILES_PATH"]}/datafiles/specs/single_tsd/M_DATA_TOUR.TSD"
    s = AremosSeries.first
    s.name.should == "NAIVCANNS@HI.M"
    s.frequency.should == "M"
    s.description.should_not be_nil
    s.start.should == "1999-01-01"
    s.end.should == "2011-01-01"
    s.aremos_data.count.should == 145
    s.data.count.should == 145
    s.data["1999-01-01"].should == 1.250000
    s.data["2011-01-01"].should == 1.296820
    s.aremos_update_date.should == Date.parse("2011-03-09")
  end
  
  it "(AremosSeries) should read in a single weekly series from TSD file into AremosSeries objects" do
    AremosSeries.load_tsd "#{ENV["DATAFILES_PATH"]}/datafiles/specs/single_tsd/W_DATA_TOUR.TSD"
    s = AremosSeries.first
    s.name.should == "OCUP%NS@HAW.W"
    s.frequency.should == "W"
    s.description.should_not be_nil
    s.start.should == "2007-01-01"
    s.end.should == "2011-02-06"
    s.aremos_data.count.should == 214
    s.data.count.should == 214
    s.data["2007-01-01"].should == 81.10000
    s.data["2011-01-31"].should == 60.90000
    s.aremos_update_date.should == Date.parse("2011-03-07")
  end
  
  it "(AremosSeries) should read in a single daily series from TSD file into AremosSeries objects" do
    AremosSeries.load_tsd "#{ENV["DATAFILES_PATH"]}/datafiles/specs/single_tsd/D_DATA_TOUR.TSD"
    s = AremosSeries.first
    s.name.should == "PCDMNS@HAW.D"
    s.frequency.should == "D"
    s.description.should_not be_nil
    s.start.should == "2001-01-18"
    s.end.should == "2011-02-27"
    # s.aremos_data.each do |value|
    #   puts "#{value}"
    # end
    # s.data.each do |date,value|
    #   puts "#{date}: #{value}"
    # end
    s.aremos_data.count.should == 3693
    s.data.count.should == 3693
    s.data["2001-01-18"].should == 0.628000
    s.data["2011-02-27"].should == 2.419681
    s.aremos_update_date.should == Date.parse("2011-03-07")
  end
  
  it "(AremosSeries) should read in the contents of a TSD file into AremosSeries objects" do
    AremosSeries.load_tsd "#{ENV["DATAFILES_PATH"]}/datafiles/specs/DATA_TOUR_MULTI_FREQUENCY.TSD"
    loaded_series = AremosSeries.all
    loaded_series.count.should == 8
  end
  
  it "should return nil if you try to access a series by name that does not exist" do
    AremosSeries.get("doesnotexist@HI.M").should be_nil
  end
  
  it "should access series by name with frequency suffix" do
    AremosSeries.load_tsd "#{ENV["DATAFILES_PATH"]}/datafiles/specs/single_tsd/A_DATA_TOUR.TSD"
    s = AremosSeries.get("NAIV@HI.A")
    s.should_not be_nil
    s.data.count.should == 12
  end
  
  it "should be able to load a file twice without crashing" do
    AremosSeries.load_tsd "#{ENV["DATAFILES_PATH"]}/datafiles/specs/single_tsd/A_DATA_TOUR.TSD"
    AremosSeries.all.count.should == 1
    s = AremosSeries.first
    create1 = s.created_at
    update1 = s.updated_at


    sleep 2
    AremosSeries.load_tsd "#{ENV["DATAFILES_PATH"]}/datafiles/specs/single_tsd/A_DATA_TOUR.TSD"
    AremosSeries.all.count.should == 1
    s = AremosSeries.first
    s.created_at.should == create1
    s.updated_at.should > update1
  end
  
end