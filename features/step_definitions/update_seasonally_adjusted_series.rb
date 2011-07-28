Given /^a seasonally adjusted series$/ do
  @sa_update_path = "#{ENV["DATAFILES_PATH"]}/datafiles/sa_update.xls"
  @worksheet_name = "sadata"
  @sa_load_results = Series.load_all_sa_series_from @sa_update_path, @worksheet_name
  @sa_series_names = @sa_load_results[:headers] 
  @sa_series_name = @sa_series_names.first
#  puts @sa_series_name
end

Given /^a non\-seasonally adjusted counterpart with more recent observations$/ do
  @ns_update_path = "#{ENV["DATAFILES_PATH"]}/datafiles/ns_update.xls"
  @ns_load_results = Series.load_all_series_from @ns_update_path
  @ns_series_names = @ns_load_results[:headers] 
  @ns_series_name = @ns_series_names.first
#  puts @ns_series_name
end

When /^I update the seasonally adjusted series applying the factors additively$/ do
  @sa_series_name.ts= @sa_series_name.ts.apply_seasonal_adjustment :additive
  @sa_series = Series.get @sa_series_name
end

Then /^I should be able to retrieve the series from the database$/ do
  @sa_series_post_update = Series.get @sa_series_name
  @sa_series_post_update.should_not be_nil
end

Then /^the series should contain the same number of observations as its counterpart series$/ do
  @ns_series = Series.get @ns_series_name
#  puts "in cucumber check #{@sa_series.name} has a count of #{@sa_series.observation_count}"
#  puts "in cucumber check #{@ns_series.name} has a count of #{@ns_series.observation_count}"
  @sa_series.observation_count.should == @ns_series.observation_count
end

Then /^the observations that follow the last demetra adjusted value should equal the sum of the seasonal factor and the counterpart series observation$/ do
  sa_values = @sa_series.get_values_after @sa_series.last_demetra_datestring
  ns_values = @ns_series.get_values_after @sa_series.last_demetra_datestring
  @expected_values = Hash.new
  ns_values.each do |datestring,ns_value|
    date = Date.parse datestring
    @expected_values[datestring] = ns_value - @sa_series.factors[date.month.to_s]
  end
  @expected_values.each {|datestring,sa_value| @sa_series.data.should include(datestring=>sa_value.round(5))}
end

When /^I update the seasonally adjusted series applying the factors multiplicatively$/ do
  @sa_series_name.ts= @sa_series_name.ts.apply_seasonal_adjustment :multiplicative
  @sa_series = Series.get @sa_series_name
end

Then /^the observations that follow the last demetra adjusted value should equal the product of the seasonal factor and the counterpart series observation$/ do
  sa_values = @sa_series.get_values_after @sa_series.last_demetra_datestring
  ns_values = @ns_series.get_values_after @sa_series.last_demetra_datestring
  @expected_values = Hash.new
  ns_values.each do |datestring,ns_value|
    date = Date.parse datestring
    @expected_values[datestring] = (ns_value / @sa_series.factors[date.month.to_s])
  end
  @expected_values.each {|datestring,sa_value| @sa_series.data.should include(datestring=>sa_value.round(5))}
end

Given /^a seasonally adjusted \(additive\) series$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^a non\-seasonally adjusted counterpart with no more recent observations$/ do
  @ns_update_path = "#{ENV["DATAFILES_PATH"]}/datafiles/ns_update.xls"
  @ns_load_results = Series.load_all_series_from @ns_update_path
  @ns_series_names = @ns_load_results[:headers] 
  @ns_series_name = @ns_series_names.first
  @ns_series = Series.get @ns_series_name
  @sa_series = Series.get @sa_series_name
  ns_values = @ns_series.get_values_after @sa_series.last_demetra_datestring
  ns_values.keys.each do |datestring|
    @ns_series.data[datestring] = nil
  end
  @ns_series.save
end

When /^I update the seasonally adjusted series$/ do
  @sa_original_data = @sa_series.data.clone
  @sa_series_name.ts= @sa_series_name.ts.apply_seasonal_adjustment :multiplicative
  @sa_series = Series.get @sa_series_name
  
end

Then /^the data for the series should equal the data for the series before adjustment$/ do
  @sa_series.data.count.should == @sa_original_data.count
  @sa_series.data.each do |datestring, value|
    @sa_original_data.should include(datestring => value)
  end
end

Given /^a seasonally adjusted series with no counterpart series$/ do
  @sa_update_path = "#{ENV["DATAFILES_PATH"]}/datafiles/sa_update.xls"
  @worksheet_name = "sadata"
  @sa_load_results = Series.load_all_sa_series_from @sa_update_path, @worksheet_name
  @sa_series_names = @sa_load_results[:headers] 
  @sa_series_name = @sa_series_names.first
  @sa_series = Series.get @sa_series_name
end

When /^I attempt to update the series$/ do
  @result_lambda = lambda{@sa_series.apply_seasonal_adjustment :additive}
end

Then /^I should receive an error indicating a problem with the seasonal adjustment$/ do
  @result_lambda.should raise_error SeasonalAdjustmentException
end

Given /^a seasonally adjusted series with no seasonal factors$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^a non\-seasonally adjusted series$/ do
  @ns_update_path = "#{ENV["DATAFILES_PATH"]}/datafiles/ns_update.xls"
  @ns_load_results = Series.load_all_series_from @ns_update_path
  @ns_series_names = @ns_load_results[:headers] 
  @ns_series_name = @ns_series_names.first
  @sa_series = Series.get @ns_series_name
end

