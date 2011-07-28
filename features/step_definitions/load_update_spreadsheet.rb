Given /^a spreadsheet path to an existing spreadsheet$/ do
  @spreadsheetpath = "#{ENV["DATAFILES_PATH"]}/datafiles/jp_upd_a.xls"
end

When /^I load the update spreadsheet$/ do
  @load_results = Series.load_all_series_from @spreadsheetpath
  @series_names = @load_results[:headers]
end

Then /^series data should appear in the database$/ do
  datadump = Series.all
  datadump.should have_at_least(1).things
end

Then /^I should receive an array of the database series names from the update spreadsheet$/ do
  @series_names.should include('GDP@JP.A',	'GDPDEF@JP.A',	'GDPPC@JP.A',	'GDPPC_R@JP.A')
end

Then /^I should receive a message indicating the load was a success$/ do
  @load_results[:message].should == "success"
end


Given /^a spreadsheet path to a non\-existent document$/ do
  @spreadsheetpath = "#{ENV["DATAFILES_PATH"]}/datafiles/jp_upd_anon-existent.xls"
end

Then /^I should receive a message telling me that there is no spreadsheet by that name$/ do
  @load_results[:message].should == "The spreadsheet could not be found"
end

Given /^an existing spreadsheet that does not respect the update spreadsheet format$/ do
  @spreadsheetpath = "#{ENV["DATAFILES_PATH"]}/datafiles/ocupwkly.xls"
end

Then /^no series data should appear in the database$/ do
  datadump = Series.all
  datadump.should have(0).things
end

Then /^I should receive an empty array$/ do
  @series_names.should have(0).things
end

Then /^I should receive a message indicating that the spreadsheet is not formatted properly$/ do
  @load_results[:message].should == "The spreadsheet was not formatted properly"
end

Given /^a spreadsheet path to an existing spreadsheet with several usable sheets$/ do
  @spreadsheetpath = "#{ENV["DATAFILES_PATH"]}/datafiles/horizontal_update_spreadsheet.xls"
end

When /^I load the update spreadsheet and all other spreadsheets in the workbook$/ do
  @load_results = Series.load_all_series_from @spreadsheetpath
  @series_names = @load_results[:headers]
  @sheet_load_results = Hash.new
  worksheets = @load_results[:sheets]
  worksheets.each do |sheet|
    if ["hi", "HI", "hon", "HON", "mau","MAU","kau","KAU","haw","HAW"].include? sheet
      @sheet_load_results[sheet] = Series.load_all_series_from @spreadsheetpath, sheet
      @series_names = @series_names | @sheet_load_results[sheet][:headers]
    end
  end
end

Then /^I should receive an array of the database series names from all worksheets$/ do
  @series_names.should include('YCAGFA@HI.A',	'YCAGFA@HON.A',	'YCMNDRWD@HAW.A',	'YCGVST@KAU.A', 'YCMI@MAU.A')
end



