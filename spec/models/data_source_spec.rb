require 'spec_helper'


#Most of this functionality seems to be more related to series, but maybe that's ok

describe DataSource do
  before(:all) do
    @data1_hash = "YSTWTR@HI.A".tsn.load_from("#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls").data
    @data1_no_nil = @data1_hash.clone
    @data1_no_nil.delete_if {|key,value| value.nil?}

    @data2_hash = "YSTWTT@HI.A".tsn.load_from("#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls").data
    @data2_no_nil = @data2_hash.clone
    @data2_no_nil.delete_if {|key,value| value.nil?}
  end
    
  it "should create a source when append syntax is used" do
    "YSTWTR@HI.A".ts_append_eval %Q|"YSTWTR@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|
    "YSTWTR@HI.A".ts.data_sources.count.should == 1
    "YSTWTR@HI.A".ts.data_sources.first.eval.should_not be_nil
    "YSTWTR@HI.A".ts.data_sources.first.description.should == "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"
    "YSTWTR@HI.A".ts.data_sources.first.series_id.should == "YSTWTR@HI.A".ts.id
    "YSTWTR@HI.A".ts.identical_to?("YSTWTR@HI.A".ts.data_sources.first.data).should be_true
    
  end
  
  it "should have two sources when eval syntax is followed by append syntax" do
    Series.store("YSTWTR@HI.A", Series.new(:data => @data1_hash),"desc1", %Q|"YSTWTR@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)
    Series.store("YSTWTR@HI.A", Series.new(:data => @data2_hash),"desc2", %Q|"YSTWTT@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)    
    "YSTWTR@HI.A".ts.data_sources.count.should == 2
  end
     
  it "should delete all dependent data points if it is deleted and regenerate the data hash for the series" do
    "YSTWTR@HI.A".ts_eval= %Q|"YSTWTR@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|
    
    "YSTWTR@HI.A".ts.data_points.count.should == @data1_no_nil.count
    "YSTWTR@HI.A".ts.data_sources[0].data_points.count.should == @data1_no_nil.count
#    "YSTWTR@HI.A".ts.print_data_points
    
    "YSTWTR@HI.A".ts_append_eval %Q|"YSTWTT@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|
    "YSTWTR@HI.A".ts.data_sources.count.should == 2
#    "YSTWTR@HI.A".ts.print_data_points
    
    ds0 = "YSTWTR@HI.A".ts.data_sources_by_last_run[0]
    ds1 = "YSTWTR@HI.A".ts.data_sources_by_last_run[1]
    dps0 = ds0.data_points
    dps1 = ds1.data_points
    
    "YSTWTR@HI.A".ts.data_points.count.should == @data1_no_nil.count + @data2_no_nil.count
    dps0.count.should == @data1_no_nil.count
    dps1.count.should == @data2_no_nil.count
        
    DataPoint.find(dps0[0].id).should_not be_nil
    DataPoint.find(dps1[0].id).should_not be_nil
    ds1.delete
    "YSTWTR@HI.A".ts.data_sources.count.should == 1
#    "YSTWTR@HI.A".ts.print_data_points
    
    ds0 = "YSTWTR@HI.A".ts.data_sources_by_last_run[0]    
    
    "YSTWTR@HI.A".ts.data_points.count.should == @data1_no_nil.count
    ds0.data_points.count.should == @data1_no_nil.count
    
    DataPoint.where(:id => dps1[0].id).first.should be_nil
    DataPoint.find(dps0[0].id).should_not be_nil
  end
    

  it "should recognize that a source with the exact same eval statement is the same and use the same source" do
    Series.store("YSTWTR@HI.A", Series.new(:data => @data1_hash),"desc1", %Q|"YSTWTR@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)
    source = "YSTWTR@HI.A".ts.data_sources[0]
    Series.store("YSTWTR@HI.A", Series.new(:data => @data1_hash),"desc1", %Q|"YSTWTR@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)
    "YSTWTR@HI.A".ts.data_sources.count.should == 1
    source.id.should == "YSTWTR@HI.A".ts.data_sources[0].id
  end

  it "should be able to retrieve series in order of earliest last run to latest last run" do
    Series.store("YSTWTR@HI.A", Series.new(:data => @data1_hash),"desc1", %Q|"YSTWTR@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)
    Series.store("YSTWTR@HI.A", Series.new(:data => @data2_hash),"desc2", %Q|"YSTWTT@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)    
    sleep 1
    "YSTWTR@HI.A".ts_append_eval %Q|"YSTWTG@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls "|
    "YSTWTR@HI.A".ts.data_sources.count.should == 3
    ("YSTWTR@HI.A".ts.data_sources.sort_by(&:last_run)[0].last_run < "YSTWTR@HI.A".ts.data_sources.sort_by(&:last_run)[-1].last_run).should be_true
  end

  
  it "should be able to reload series data from a source" do
    # Series.store("YSTWTR@HI.A", Series.new(:data => @data2_hash),nil,"desc2", %Q|"YSTWTT@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)    
    # Series.store("YSTWTR@HI.A", Series.new(:data => @data1_hash),nil,"desc1", %Q|"YSTWTR@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)
    
    "YSTWTR@HI.A".ts_append_eval %Q|"YSTWTT@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|
    "YSTWTR@HI.A".ts_append_eval %Q|"YSTWTR@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|
    
    ds_first = "YSTWTR@HI.A".ts.data_sources_by_last_run[0]
    ds_second = "YSTWTR@HI.A".ts.data_sources_by_last_run[1]
    
    "YSTWTR@HI.A".ts.data_sources_by_last_run[0].id.should == ds_first.id    
    "YSTWTR@HI.A".ts.identical_to?(ds_first.data).should be_false
    "YSTWTR@HI.A".ts.identical_to?(ds_second.data).should be_true
    
    sleep 2 #need to create separation between current time and the original time that the sources were run
    ds_first.reload_source
    
    "YSTWTR@HI.A".ts.data_sources_by_last_run[0].id.should == ds_second.id    
    "YSTWTR@HI.A".ts.identical_to?(ds_first.data).should be_true
    "YSTWTR@HI.A".ts.identical_to?(ds_second.data).should be_false
  end
  
    #turn off "setting" data sources. Now that we can delete sources and data points. All sources should be appended
   it "should mark data points as history if they are attached to current data source, but the date is not in the source data hash" do
     #Series.store(series_name, series, mode, desc=nil, eval_statement=nil)
     delete_date = "2000-01-01"
     dummy_series = "YSTWTT@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"

     Series.store("YSTWTR@HI.A", dummy_series, "dummy series description", "dummy")

     new_data = dummy_series.data.clone
     new_data.delete(delete_date)
     new_series = Series.new(:data => new_data)
     Series.store("YSTWTR@HI.A", new_series, "dummy series description", "dummy")

     history = "YSTWTR@HI.A".ts.data_points.where(:date_string => delete_date).first.history
     history.should_not be_nil
     history.localtime.to_date.should == Time.now.to_date
   end

  it "should be able to determine a color for itself" do
    Series.store("YSTWTR@HI.A", Series.new(:data => @data2_hash),"desc2", %Q|"YSTWTT@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)    
    Series.store("YSTWTR@HI.A", Series.new(:data => @data1_hash),"desc1", %Q|"YSTWTR@HI.A".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/gsp_upd.xls"|)
    
    ds_first = "YSTWTR@HI.A".ts.data_sources_by_last_run[0]
    ds_second = "YSTWTR@HI.A".ts.data_sources_by_last_run[1]
    
    ds_first.color.should == "FFCC99"
    ds_second.color.should == "CCFFFF"
  end
  
end

