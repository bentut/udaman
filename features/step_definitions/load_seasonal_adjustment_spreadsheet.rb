Given /^a spreadsheet path to an existing seasonally adjusted output spreadsheet$/ do
  @spreadsheetpath = "#{ENV["DATAFILES_PATH"]}/datafiles/sa_update.xls"
end

Given /^the name of a worksheet where the output can be found$/ do
  @worksheet_name = "Demetra_Results_fa"
end

When /^I load the seasonally adjusted output spreadsheet$/ do
  @load_results = Series.load_all_sa_series_from @spreadsheetpath, @worksheet_name
  @series_names = @load_results[:headers]
end

Then /^I should receive an array of the seasonally adjusted database series names derived from the names of the non\-seasonally adjusted series$/ do
  @series_names.should include('EMN@HI.M',	'EIF@HI.M',	'EAG@HI.M')
end

Then /^each series should indicate it is seasonally adjusted$/ do
  @series_names.each do |series_name|
    db_series = Series.first :conditions => {:name=>series_name, :seasonally_adjusted=>true}
    db_series.should_not be_nil
  end
end

Given /^a spreadsheet path to an existing seasonally adjusted output spreadsheet and the name of a worksheet that does not respect the spreadsheet format$/ do
  @spreadsheetpath = "#{ENV["DATAFILES_PATH"]}/datafiles/sa_update.xls"
  @worksheet_name = "SOURCE_NOTE"
end

Given /^a spreadsheet path to a non\-existent seasonally adjusted output spreadsheet$/ do
  @spreadsheetpath = "#{ENV["DATAFILES_PATH"]}/datafiles/bls_swefwefwea.xls"
end
