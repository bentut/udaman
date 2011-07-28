Before do
    @expected_csums                 = { "2000-07-01"=>3, "2000-10-01"=>4, 
                                       "2001-01-01"=>5, "2001-04-01"=>6, "2001-07-01"=>7, "2001-10-01"=>8,
                                       "2002-01-01"=>9, "2002-04-01"=>10, "2002-07-01"=>11, "2002-10-01"=>12, 
                                       "2003-01-01"=>13, "2003-04-01"=>14 }
                                       
    @expected_cdifferences          = { "2000-07-01"=>-1, "2000-10-01"=>0, 
                                       "2001-01-01"=>1, "2001-04-01"=>2, "2001-07-01"=>3, "2001-10-01"=>4,"2002-01-01"=>5, 
                                       "2002-04-01"=>6, "2002-07-01"=>7, "2002-10-01"=>8, "2003-01-01"=>9, "2003-04-01"=>10 }
                                         
    @expected_cproducts             = { "2000-07-01"=>1*2, "2000-10-01"=>2*2, 
                                       "2001-01-01"=>3*2, "2001-04-01"=>4*2, "2001-07-01"=>5*2, "2001-10-01"=>6*2,
                                       "2002-01-01"=>7*2, "2002-04-01"=>8*2, "2002-07-01"=>9*2, "2002-10-01"=>10*2, 
                                       "2003-01-01"=>11*2, "2003-04-01"=>12*2 }
                                       
    @expected_cquotients            = { "2000-07-01"=>1/2.to_f, "2000-10-01"=>2/2.to_f, 
                                       "2001-01-01"=>3/2.to_f, "2001-04-01"=>4/2.to_f, "2001-07-01"=>5/2.to_f, "2001-10-01"=>6/2.to_f,
                                       "2002-01-01"=>7/2.to_f, "2002-04-01"=>8/2.to_f, "2002-07-01"=>9/2.to_f, "2002-10-01"=>10/2.to_f, 
                                       "2003-01-01"=>11/2.to_f, "2003-04-01"=>12/2.to_f }
                                       
    @expected_ccalculation_results  = { "2000-07-01"=>nil, "2000-10-01"=>2/2.to_f+2*2, 
                                       "2001-01-01"=>3/3.to_f+3*3, "2001-04-01"=>4/4.to_f+4*4, "2001-07-01"=>5/5.to_f+5*5, "2001-10-01"=>6/6.to_f+6*6,
                                       "2002-01-01"=>7/7.to_f+7*7, "2002-04-01"=>8/8.to_f+8*8, "2002-07-01"=>9/9.to_f+9*9, "2002-10-01"=>10/10.to_f+10*10, 
                                       "2003-01-01"=>11/11.to_f+11*11, "2003-04-01"=>nil }
end

Given /^a constant$/ do
  @constant = 2.0
end

When /^I save their sum transformation in a new series$/ do
  @new_series_name = "sum_series@TEST.Q"
  @new_series = Series.store(@new_series_name, @series_1 + @constant)
end

Then /^it should have the same date range as the given series$/ do
  @new_series.data.length.should == @series_1.data.length
end

Then /^the data should match the sum of the series element and the constant or be nil if value is missing for a given date$/ do
  @expected_csums.each {|date,sum| @new_series.data.should include(date=>sum)}
end

When /^I save their difference transformation in a new series$/ do
  @new_series_name = "diff_series@TEST.Q"
  @new_series = Series.store(@new_series_name, @series_1 - @constant)
end

Then /^the data should match the difference of the series element and the constant or be nil if value is missing for a given date$/ do
  @expected_cdifferences.each {|date,sum| @new_series.data.should include(date=>sum)}
end

When /^I save their product transformation in a new series$/ do
  @new_series_name = "product_series@TEST.Q"
  @new_series = Series.store(@new_series_name, @series_1 * @constant)
end

Then /^the data should match the product of the series element and the constant or be nil if value is missing for a given date$/ do
  @expected_cproducts.each {|date,sum| @new_series.data.should include(date=>sum)}  
end

When /^I save their quotient transformation in a new series$/ do
  @new_series_name = "product_series@TEST.Q"
  @new_series = Series.store(@new_series_name, @series_1 / @constant)
end

Then /^the data should match the quotient of the series element and the constant or be nil if value is missing for a given date$/ do
  @expected_cquotients.each {|date,sum| @new_series.data.should include(date=>sum)}
end
