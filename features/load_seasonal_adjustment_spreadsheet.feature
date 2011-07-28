Feature: Load a seasonal adjustment output spreadsheet
	So that I can use seasonally adjusted series
	as a data manager
	I want to be able to specify a spreadsheet that contains the output from a demetra seasonal adjustment routine
	at any time
	
	Scenario: Load a seasonally adjusted output spreadsheet with a worksheet specified
		Given a spreadsheet path to an existing seasonally adjusted output spreadsheet
		And the name of a worksheet where the output can be found
		When I load the seasonally adjusted output spreadsheet
		Then series data should appear in the database
		And I should receive an array of the seasonally adjusted database series names derived from the names of the non-seasonally adjusted series
		And each series should indicate it is seasonally adjusted
#		And each series should have seasonal factors
#		And each series should indicate whether the factors are to be applied as additive or multiplicative factors
		And I should receive a message indicating the load was a success
		
	Scenario: Load a seasonally adjusted output spreadsheet with no worksheet specified
		Given a spreadsheet path to an existing seasonally adjusted output spreadsheet
		When I load the seasonally adjusted output spreadsheet
		Then series data should appear in the database
		And I should receive an array of the seasonally adjusted database series names derived from the names of the non-seasonally adjusted series
		And each series should indicate it is seasonally adjusted
#		And each series should have seasonal factors
#		And each series should indicate whether the factors are to be applied as additive or multiplicative factors
		And I should receive a message indicating the load was a success
		
	Scenario: Attempt to load an incorrectly formatted spreadsheet
		Given a spreadsheet path to an existing seasonally adjusted output spreadsheet and the name of a worksheet that does not respect the spreadsheet format
		When I load the seasonally adjusted output spreadsheet
		Then no series data should appear in the database
		And I should receive an empty array
		And I should receive a message indicating that the spreadsheet is not formatted properly
	
	Scenario: Attempt to load a spreadsheet that cannot be found
		Given a spreadsheet path to a non-existent seasonally adjusted output spreadsheet
		When I load the seasonally adjusted output spreadsheet
		Then no series data should appear in the database
		And I should receive an empty array
		And I should receive a message telling me that there is no spreadsheet by that name