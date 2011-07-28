Feature: Combine multiple series through arithmetic operations and store in a new series
	So that I can create transformed series
	as a data manager
	I want to apply constant transformations to series
	using arithmetic operations
	and store into a new series

	Scenario: Create a new series by adding a constant to each element of a series
		Given an existing series 
		And a constant 
		When I save their sum transformation in a new series
		Then I should be able to retrieve the new series from the database
		And it should have the same date range as the given series
		And the data should match the sum of the series element and the constant or be nil if value is missing for a given date
		
	Scenario: Create a new series by subtracting a constant from each element of a series 
		Given an existing series 
		And a constant
		When I save their difference transformation in a new series
		Then I should be able to retrieve the new series from the database
		And it should have the same date range as the given series
		And the data should match the difference of the series element and the constant or be nil if value is missing for a given date
				
	Scenario: Create a new series by multiplying each element of a series by a constant
		Given an existing series 
		And a constant
		When I save their product transformation in a new series
		Then I should be able to retrieve the new series from the database
		And it should have the same date range as the given series
		And the data should match the product of the series element and the constant or be nil if value is missing for a given date
				
	Scenario: Create a new series by dividing each element of a series by a constant
		Given an existing series 
		And a constant
		When I save their quotient transformation in a new series
		Then I should be able to retrieve the new series from the database
		And it should have the same date range as the given series
		And the data should match the quotient of the series element and the constant or be nil if value is missing for a given date
				
	# Scenario: Create a new series by performing combinations of arithmetic operations on the equivalent elements (by date) from multiple series
	# 	Given an existing series 
	# 	And 3 other series with equivalent frequencies
	# 	When operate on the elements of all 4 series and save the results in a new series
	# 	Then I should be able to retrieve the new series from the database
	# 	And it should have the same date range as the longest of the four series
	# 	And the data should match the calculation performed on the elements of the individual series or be nil if any series is missing a value for a given date