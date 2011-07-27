require 'spec_helper'


describe SeriesSharing do

  describe "perform COMPOSITE, MEAN CORRECTION, AND SHARING series transformations" do
    it "should calculate county series by calculating shares of county values over the sum of counties" do
      Series.load_all_series_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/ECT.xls"
      "ECT@HI.M".ts_append_eval %Q|"ECTSA@HI.M".ts|
      shared = "ECT@HI.M".ts.aa_county_share_for("HON")
      "ECT_CALC@HON.M".ts.identical_to?(shared.data).should be_true
    end

    it "should load a seasonally adjusted series and do annual mean correction in one step" do 
      Series.load_all_series_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/ECT.xls"
      "VISJPDEMETRA@HI.M".ts_append_eval %Q|"VISJPDEMETRANS@HI.M".ts|
      "VISJPDEMETRANS@HI.M".ts_append_eval %Q|"VISJPNS@HI.M".ts|

      "VISJPDEMETRA@HI.M".ts= "VISJPDEMETRA@HI.M".ts.load_mean_corrected_sa_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/ECT.xls", "Sheet1"
      "VISJPDEMETRA@HI.M".ts= "VISJPDEMETRA@HI.M".ts.apply_seasonal_adjustment :multiplicative
      "VISJP_CALC@HI.M".ts.identical_to?("VISJPDEMETRA@HI.M".ts.data).should be_true
    end
  
    it "should calculate county series by calculating county value over the state value and mean correcting annually" do 
      Series.load_all_series_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/ECT.xls"
      shared = "VISJP@HI.M".ts.mc_ma_county_share_for("HON")
      "VISJP_CALC@HON.M".ts.identical_to?(shared.data).should be_true
    end
  end

end