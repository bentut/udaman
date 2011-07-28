Before do
    @expected_sums                 = { "2000-07-01"=>nil, "2000-10-01"=>4, 
                                       "2001-01-01"=>6, "2001-04-01"=>8, "2001-07-01"=>10, "2001-10-01"=>12,
                                       "2002-01-01"=>14, "2002-04-01"=>16, "2002-07-01"=>18, "2002-10-01"=>20, 
                                       "2003-01-01"=>22, "2003-04-01"=>nil }
                                       
    @expected_differences          = { "2000-07-01"=>nil, "2000-10-01"=>0, 
                                       "2001-01-01"=>0, "2001-04-01"=>0, "2001-07-01"=>0, "2001-10-01"=>0,"2002-01-01"=>0, 
                                       "2002-04-01"=>0, "2002-07-01"=>0, "2002-10-01"=>0, "2003-01-01"=>0, "2003-04-01"=>nil }
                                         
    @expected_products             = { "2000-07-01"=>nil, "2000-10-01"=>2*2, 
                                       "2001-01-01"=>3*3, "2001-04-01"=>4*4, "2001-07-01"=>5*5, "2001-10-01"=>6*6,
                                       "2002-01-01"=>7*7, "2002-04-01"=>8*8, "2002-07-01"=>9*9, "2002-10-01"=>10*10, 
                                       "2003-01-01"=>11*11, "2003-04-01"=>nil }
                                       
    @expected_quotients            = { "2000-07-01"=>nil, "2000-10-01"=>2/2.to_f, 
                                       "2001-01-01"=>3/3.to_f, "2001-04-01"=>4/4.to_f, "2001-07-01"=>5/5.to_f, "2001-10-01"=>6/6.to_f,
                                       "2002-01-01"=>7/7.to_f, "2002-04-01"=>8/8.to_f, "2002-07-01"=>9/9.to_f, "2002-10-01"=>10/10.to_f, 
                                       "2003-01-01"=>11/11.to_f, "2003-04-01"=>nil }
                                       
    @expected_calculation_results  = { "2000-07-01"=>nil, "2000-10-01"=>2/2.to_f+2*2, 
                                       "2001-01-01"=>3/3.to_f+3*3, "2001-04-01"=>4/4.to_f+4*4, "2001-07-01"=>5/5.to_f+5*5, "2001-10-01"=>6/6.to_f+6*6,
                                       "2002-01-01"=>7/7.to_f+7*7, "2002-04-01"=>8/8.to_f+8*8, "2002-07-01"=>9/9.to_f+9*9, "2002-10-01"=>10/10.to_f+10*10, 
                                       "2003-01-01"=>11/11.to_f+11*11, "2003-04-01"=>nil }
end

Given /^an existing series$/ do
  @series_1 = Series.create_dummy("quarterly_test_series@TEST.Q", :quarter, "2000-04-01", 1, 12)
  @series_1.units = "dollars"
  @series_1.save
end

Given /^another series with equivalent units and frequency$/ do
  @series_2 = Series.create_dummy("quarterly_test_series_shorter@TEST.Q", :quarter, "2000-04-01", 2, 11)
  @series_2.units = "dollars"
  @series_2.save
end

Given /^another series with equivalent frequency$/ do
  @series_2 = Series.create_dummy("quarterly_test_series_shorter@TEST.Q", :quarter, "2000-04-01", 2, 11)
  @series_2.units = "people"
  @series_2.save
end

Given /^(\d+) other series with equivalent frequencies$/ do |arg1|
  @series_2 = Series.create_dummy("quarterly_test_series_2@TEST.Q", :quarter, "2000-04-01", 2, 11)
  @series_2.units = "dollars"
  @series_2.save

  @series_3 = Series.create_dummy("quarterly_test_series_3@TEST.Q", :quarter, "2000-04-01", 2, 11)
  @series_3.units = "dollars"
  @series_3.save

  @series_4 = Series.create_dummy("quarterly_test_series_4@TEST.Q", :quarter, "2000-04-01", 2, 11)
  @series_4.units = "dollars"
  @series_4.save
end

When /^I save their sum in a new series$/ do
  @new_series_name = "sum_series@TEST.Q"
  @new_series = @series_1 + @series_2
  @new_series.name = @new_series_name
  @new_series.save
end

When /^I save their difference in a new series$/ do
  @new_series_name = "difference_series@TEST.Q"
  @new_series = @series_1 - @series_2
  @new_series.name = @new_series_name
  @new_series.save
end

When /^operate on the elements of all (\d+) series and save the results in a new series$/ do |arg1|
  @new_series_name = "multiple_operations_series@TEST.Q"
  @new_series = @series_1 / @series_2 + @series_3 * @series_4 
  @new_series.name = @new_series_name
  @new_series.save
end

When /^I save their product in a new series$/ do
  @new_series_name = "product_series@TEST.Q"
  @new_series = @series_1 * @series_2
  @new_series.name = @new_series_name
  @new_series.save
end

When /^I save their quotient in a new series$/ do
  @new_series_name = "quotient_series@TEST.Q"
  @new_series = @series_1 / @series_2
  @new_series.name = @new_series_name
  @new_series.save
end

Then /^it should have the same date range as the longest series$/ do
  @longest_series = @series_1.data.length > @series_2.data.length ? @series_1 : @series_2
  @new_series.data.length.should == @longest_series.data.length
end

Then /^the data should match the sums of the elements of the individual series or be nil if either series is missing a value for a given date$/ do
  @expected_sums.each {|date,sum| @new_series.data.should include(date=>sum)}
end

Then /^the data should match the difference of the elements of the individual series or be nil if either series is missing a value for a given date$/ do
  @expected_differences.each {|date,difference| @new_series.data.should include(date=>difference)}
end

Then /^the data should match the products of the elements of the individual series or be nil if either series is missing a value for a given date$/ do
  @expected_products.each {|date,product| @new_series.data.should include(date=>product)}
end

Then /^the data should match the quotients of the elements of the individual series or be nil if either series is missing a value for a given date$/ do
  @expected_quotients.each {|date,quotient| @new_series.data.should include(date=>quotient)}
end

Then /^it should have the same date range as the longest of the four series$/ do
  @longest_series = @series_1.data.length > @series_2.data.length ? @series_1 : @series_2
  @longest_series = @longest_series.data.length > @series_3.data.length ? @longest_series : @series_3
  @longest_series = @longest_series.data.length > @series_4.data.length ? @longest_series : @series_4
  @new_series.data.length.should == @longest_series.data.length
end

Then /^the data should match the calculation performed on the elements of the individual series or be nil if any series is missing a value for a given date$/ do
  @expected_calculation_results.each {|date,result| @new_series.data.should include(date=>result)}
end

