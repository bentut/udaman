Before do

  @expected_quarter_to_year_avgs   = { "2001-01-01"=>18/4.to_f, "2002-01-01"=>34/4.to_f }
  @expected_month_to_year_avgs     = { "2001-01-01"=>13.5, "2002-01-01"=>25.5 }
  @expected_month_to_quarter_avgs  = { "2000-07-01"=>9/3.to_f, "2000-10-01"=>18/3.to_f, 
                                       "2001-01-01"=>27/3.to_f, "2001-04-01"=>36/3.to_f, "2001-07-01"=>45/3.to_f, "2001-10-01"=>54/3.to_f,
                                       "2002-01-01"=>63/3.to_f, "2002-04-01"=>72/3.to_f, "2002-07-01"=>81/3.to_f, "2002-10-01"=>90/3.to_f, 
                                       "2003-01-01"=>99/3.to_f }
end

Then /^the measurements should equal the average of the (\d+) months in each of the complete quarters$/ do |arg1|
  @expected_month_to_quarter_avgs.each {|date,sum| @new_series.data.should include(date=>sum)}
end

Then /^the measurements should equal the average of the (\d+) months in each of the complete years$/ do |arg1|
  @expected_month_to_year_avgs.each {|date,sum| @new_series.data.should include(date=>sum)}
end

Then /^the measurements should equal the average of the (\d+) quarters in each of the complete years$/ do |arg1|
  @expected_quarter_to_year_avgs.each {|date,sum| @new_series.data.should include(date=>sum)}
end

When /^I aggregate the series by quarter\/average and store in a new series$/ do
  @new_series_name = "test_series_as_quarter@TEST.Q"
  @series_to_aggregate.aggregate_to :quarter, :average, @new_series_name
end

When /^I aggregate the series by year\/average and store in a new series$/ do
  @new_series_name = "test_series_as_years@TEST.A"
  @series_to_aggregate.aggregate_to :year, :average, @new_series_name
end

When /^I attempt to aggregate the series by month\/average and store in a new series$/ do
  @new_series_name = "test_series_as_months@TEST.M"
  @result_lambda = lambda{@series_to_aggregate.aggregate_to :month, :average, @new_series_name}
end

When /^I attempt to aggregate the series by quarter\/average and store in a new series$/ do
  @new_series_name = "test_series_as_quarters@TEST.Q"
  @result_lambda = lambda{@series_to_aggregate.aggregate_to :quarter, :average, @new_series_name}
end

