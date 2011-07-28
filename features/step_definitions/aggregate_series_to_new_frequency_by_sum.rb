Before do
  #define all the expected results hashes
  @expected_quarter_to_year_sums  = { "2001-01-01"=>18, "2002-01-01"=>34 }
  @expected_month_to_year_sums    = { "2001-01-01"=>162, "2002-01-01"=>306 }
  @expected_month_to_quarter_sums = { "2000-07-01"=>9, "2000-10-01"=>18, 
                                      "2001-01-01"=>27, "2001-04-01"=>36, "2001-07-01"=>45, "2001-10-01"=>54,
                                      "2002-01-01"=>63, "2002-04-01"=>72, "2002-07-01"=>81, "2002-10-01"=>90, 
                                      "2003-01-01"=>99 }
  
end


Given /^a series measured at a monthly frequency$/ do
  @series_to_aggregate = Series.create_dummy("monthly_test_series@TEST.M", :month, "2000-05-01", 1, 36)
  @series_to_aggregate.save
end

Given /^a series measured at an annual frequency$/ do
  @series_to_aggregate = Series.create_dummy("annual_test_series@TEST.A", :year, "2000-01-01", 1, 12)
  @series_to_aggregate.save
end

Given /^a series measured at a quarterly frequency$/ do
  @series_to_aggregate = Series.create_dummy("quarterly_test_series@TEST.Q", :quarter, "2000-04-01", 1, 12)
  @series_to_aggregate.save
end

When /^I aggregate the series by quarter\/sum and store in a new series$/ do
  @new_series_name = "test_series_as_quarters@TEST.Q"
  @series_to_aggregate.aggregate_to :quarter, :sum, @new_series_name
end

When /^I aggregate the series by year\/sum and store in a new series$/ do
  @new_series_name = "test_series_as_years@TEST.A"
  @series_to_aggregate.aggregate_to :year, :sum, @new_series_name
end

When /^I aggregate the series by month\/sum and store in a new series$/ do
  @new_series_name = "test_series_as_months@TEST.M"
  @series_to_aggregate.aggregate_to(:month, :sum, @new_series_name)
end

When /^I attempt to aggregate the series by month\/sum and store in a new series$/ do
  @new_series_name = "test_series_as_months@TEST.M"
  @result_lambda = lambda{@series_to_aggregate.aggregate_to(:month, :sum, @new_series_name)}
end

When /^I attempt to aggregate the series by quarter\/sum and store in a new series$/ do
  @new_series_name = "test_series_as_quarters@TEST.M"
  @result_lambda = lambda{@series_to_aggregate.aggregate_to :quarter, :sum, @new_series_name}
end


Then /^I should be able to retrieve the new series from the database$/ do
  @new_series = Series.first :conditions => {:name=>@new_series_name}
  @new_series.should_not be_nil
end

Then /^the measurements should equal the sums of the (\d+) months in each of the complete quarters$/ do |arg1|
  @expected_month_to_quarter_sums.each {|date,sum| @new_series.data.should include(date=>sum)}
end

Then /^the measurements should equal the sums of the (\d+) months in each of the complete years$/ do |arg1|
  @expected_month_to_year_sums.each {|date,sum| @new_series.data.should include(date=>sum)}
end

Then /^the measurements should equal the sums of the (\d+) quarters in each of the complete years$/ do |arg1|
  @expected_quarter_to_year_sums.each {|date,sum| @new_series.data.should include(date=>sum)}
end

Then /^the aggregation attempt should cause an AggregationException Error$/ do
  @result_lambda.should raise_error AggregationException
end

Then /^I should not be able to retrieve that series from the database$/ do
  #not sure this test does anything because I don't think the Lambdas let database writing happen
  @new_series = Series.first :conditions => {:name=>@new_series_name}
  @new_series.should be_nil
end

