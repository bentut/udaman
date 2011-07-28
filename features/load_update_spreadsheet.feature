Feature: Load Update Spreadsheet
	So that I can keep data updated
	as a data manager
	I want to be able to specify a spreadsheet to upload from
	at any time

	Scenario: Load an existing spreadsheet when connected to the server
	
		Given a spreadsheet path to an existing spreadsheet
		When I load the update spreadsheet
		Then series data should appear in the database
		And I should receive an array of the database series names from the update spreadsheet
		And I should receive a message indicating the load was a success
		
	Scenario: Load an existing spreadsheet with several sheets the database is interested in
		
		Given a spreadsheet path to an existing spreadsheet with several usable sheets
		When I load the update spreadsheet and all other spreadsheets in the workbook
		Then series data should appear in the database
		And I should receive an array of the database series names from all worksheets

	Scenario: Load a nonexistent spreadsheet or an existing spreadsheet when not connected to the server
	
		Given a spreadsheet path to a non-existent document
		When I load the update spreadsheet
		Then I should receive a message telling me that there is no spreadsheet by that name

	Scenario: Load an incorrectly formatted spreadsheet
	
		Given an existing spreadsheet that does not respect the update spreadsheet format
		When I load the update spreadsheet
		Then no series data should appear in the database
		And I should receive an empty array
		And I should receive a message indicating that the spreadsheet is not formatted properly