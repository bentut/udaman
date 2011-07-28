Feature: Aggregate Series by sum and store in new series
	So that I can compare and operate on data collected at frequencies
	as a data manager
	I want to be able to convert higher frequencies
	to lower frequencies by summing their components
	and storing in a new series
	
	Scenario: Aggregate to quarterly measurement by summing months
		Given a series measured at a monthly frequency
		When I aggregate the series by quarter/sum and store in a new series
		Then I should be able to retrieve the new series from the database
		And the measurements should equal the sums of the 3 months in each of the complete quarters
		
	Scenario: Aggregate to annual measurement by summing months
		Given a series measured at a monthly frequency
		When I aggregate the series by year/sum and store in a new series
		Then I should be able to retrieve the new series from the database
		And the measurements should equal the sums of the 12 months in each of the complete years
		
	Scenario: Aggregate to annual measurement by summing quarters	
		Given a series measured at a quarterly frequency
		When I aggregate the series by year/sum and store in a new series
		Then I should be able to retrieve the new series from the database
		And the measurements should equal the sums of the 4 quarters in each of the complete years
		
	Scenario: Unsuccessfully convert quarterly to monthly
		Given a series measured at a quarterly frequency
		When I attempt to aggregate the series by month/sum and store in a new series
		Then the aggregation attempt should cause an AggregationException Error
		And I should not be able to retrieve that series from the database

	Scenario: Unsuccessfully convert annual to monthly
		Given a series measured at an annual frequency
		When I attempt to aggregate the series by month/sum and store in a new series
		Then the aggregation attempt should cause an AggregationException Error
		And I should not be able to retrieve that series from the database
		
	Scenario: Unsuccessfully convert annual to quarterly
		Given a series measured at an annual frequency
		When I attempt to aggregate the series by quarter/sum and store in a new series
		Then the aggregation attempt should cause an AggregationException Error
		And I should not be able to retrieve that series from the database
