require 'spec_helper'

describe DataPoint do
  before(:each) do
    @s = Series.create
  end
  
  #redo tests above without the update function
  it "should not change datapoint if value and source_id are unchanged" do
    ds = DataSource.create
    dp = DataPoint.create(:series_id => @s.id, :date_string => "2011-03-01", :value => 100.0, :data_source_id => ds.id, :current => true)
    dp.upd(100, ds)
    dpu = @s.data_points[0]
    dpu.id.should == dp.id
    dpu.value.should == dp.value
    dpu.current.should == dp.current
    dpu.data_source_id.should == dp.data_source_id
  end
  
  it "should update a data points source_id if source_id is different" do
    ds1 = DataSource.create
    ds2 = DataSource.create
    dp = DataPoint.create(:series_id => @s.id, :date_string => "2011-03-01", :value => 100.0, :data_source_id => ds1.id, :current => true)
    dp.upd(100, ds2)
    
    dpu = @s.data_points[0]
    dpu.id.should == dp.id
    dpu.value.should == dp.value
    dpu.current.should == dp.current

    dpu.data_source_id.should == ds2.id
    dpu.data_source_id.should_not == ds1.id
  end
  
  # it "should be able to clone itself but assign a new value, source_id" do
  # end
  
  it "should mark itself as non-current and spawn a new data point if the value of the data point changes" do
    ds1 = DataSource.create
    dp = DataPoint.create(:series_id => @s.id, :date_string => "2011-03-01", :value => 100.0, :data_source_id => ds1.id, :current => true)
    dp.upd(200, ds1)
    DataPoint.count.should == 2
    @s.current_data_points.count.should == 1
    @s.data_points.count.should == 2
  end
    
  it "should make it's 'next of kin' data point current if it's being deleted" do
    ds1 = DataSource.create
    dp = DataPoint.create(:series_id => @s.id, :date_string => "2011-03-01", :value => 100.0, :data_source_id => ds1.id, :current => true)

    dp1 = dp.upd(200, ds1)
    
    @s.data_points.count.should == 2
    @s.current_data_points.count.should == 1
    
    @s.current_data_points[0].delete

    @s.data_points.count.should == 1
    @s.current_data_points.count.should == 1    
    @s.current_data_points[0].id.should == dp.id

    sleep 1  
    dp = DataPoint.where(:current => true).first
    dp2 = dp.upd(300, ds1)
      
    sleep 1
    dp3 = dp2.upd(400, ds1)

  
    @s.current_data_points[0].delete

    @s.data_points.count.should == 2
    @s.current_data_points.count.should == 1    
    @s.current_data_points[0].id.should == dp2.id
    
  end
end

