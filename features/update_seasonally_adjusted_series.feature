Feature: Update seasonally adjusted series when new observations are imported
	So that I can update seasonally adjusted series with new data observations without running the full adjustment algorithm in demetra
	as a data manager
	I want to specify a seasonally adjusted series to update
	at any time

	Scenario: Update a series with new observations (additive)
		Given a seasonally adjusted series
		And a non-seasonally adjusted counterpart with more recent observations
		When I update the seasonally adjusted series applying the factors additively
		Then I should be able to retrieve the series from the database
		And the series should contain the same number of observations as its counterpart series
		And the observations that follow the last demetra adjusted value should equal the sum of the seasonal factor and the counterpart series observation
 
	Scenario: Update a series with new observations (multiplicative)
		Given a seasonally adjusted series
		And a non-seasonally adjusted counterpart with more recent observations
		When I update the seasonally adjusted series applying the factors multiplicatively
		Then I should be able to retrieve the series from the database
		And the series should contain the same number of observations as its counterpart series
		And the observations that follow the last demetra adjusted value should equal the product of the seasonal factor and the counterpart series observation
	

	Scenario: Update a series with no new observations
		Given a seasonally adjusted series
		And a non-seasonally adjusted counterpart with no more recent observations
		When I update the seasonally adjusted series
		Then I should be able to retrieve the series from the database
		And the data for the series should equal the data for the series before adjustment
		
	Scenario: Attempt to update a series where non-seasonally adjusted series cannot be found
		Given a seasonally adjusted series with no counterpart series
		When I attempt to update the series
		Then I should receive an error indicating a problem with the seasonal adjustment

	# Scenario: Attempt to update a series where seasonal factors are not available
	# 	Given a seasonally adjusted series with no seasonal factors
	# 	When I attempt to update the series
	# 	Then I should receive an error indicating a problem with the seasonal adjustment

	Scenario: Attempt to update a series that is not seasonally adjusted 
		Given a non-seasonally adjusted series
		When I attempt to update the series
		Then I should receive an error indicating a problem with the seasonal adjustment
		
	# 
	# Scenario: Update a series with new observations (additive) using series factor-application default
	# 	Given a seasonally adjusted series(additive)
	# 	And a non-seasonally adjusted counterpart with more recent observations
	# 	When I update the seasonally adjusted series applying the factors additively
	# 	Then I should be able to retrieve the series from the database
	# 	And the series should contain the same number of observations as its counterpart series
	# 	And the observations that follow the last demetra adjusted value should equal the sum of the seasonal factor and the counterpart series observation
	# 
	# Scenario: Update a series with new observations (multiplicative) using series factor-application default
	# 	Given a seasonally adjusted series (multiplicative)
	# 	And a non-seasonally adjusted counterpart with more recent observations
	# 	When I update the seasonally adjusted series applying the factors multiplicatively
	# 	Then I should be able to retrieve the series from the database
	# 	And the series should contain the same number of observations as its counterpart series
	# 	And the observations that follow the last demetra adjusted value should equal the
