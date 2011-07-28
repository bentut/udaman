Feature: Combine multiple series through arithmetic operations and store in a new series
	So that I can create composite series
	as a data manager
	I want to combine an arbitrary number of series
	using arithmetic operations
	and store into a new series

	Scenario: Create a new series by adding each element of one series to the equivalent element (by date) of another series
		Given an existing series 
		And another series with equivalent units and frequency 
		When I save their sum in a new series
		Then I should be able to retrieve the new series from the database
		And it should have the same date range as the longest series
		And the data should match the sums of the elements of the individual series or be nil if either series is missing a value for a given date
		
	Scenario: Create a new series by subtracting each element of one series from equivalent element (by date) of another series
		Given an existing series 
		And another series with equivalent units and frequency 
		When I save their difference in a new series
		Then I should be able to retrieve the new series from the database
		And it should have the same date range as the longest series
		And the data should match the difference of the elements of the individual series or be nil if either series is missing a value for a given date
		
	Scenario: Create a new series by multiplying each element of one series to the equivalent element (by date) of another series
		Given an existing series 
		And another series with equivalent frequency
		When I save their product in a new series
		Then I should be able to retrieve the new series from the database
		And it should have the same date range as the longest series
		And the data should match the products of the elements of the individual series or be nil if either series is missing a value for a given date
		
	Scenario: Create a new series by dividing each element of one series by the equivalent element (by date) of another series
		Given an existing series 
		And another series with equivalent frequency 
		When I save their quotient in a new series
		Then I should be able to retrieve the new series from the database
		And it should have the same date range as the longest series
		And the data should match the quotients of the elements of the individual series or be nil if either series is missing a value for a given date
		
	Scenario: Create a new series by performing combinations of arithmetic operations on the equivalent elements (by date) from multiple series
		Given an existing series 
		And 3 other series with equivalent frequencies
		When operate on the elements of all 4 series and save the results in a new series
		Then I should be able to retrieve the new series from the database
		And it should have the same date range as the longest of the four series
		And the data should match the calculation performed on the elements of the individual series or be nil if any series is missing a value for a given date