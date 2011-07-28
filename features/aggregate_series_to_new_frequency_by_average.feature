Feature: Aggregate Series by average and store in a new series
	So that I can compare and operate on data collected at different frequencies
	as a data manager
	I want to be able to convert higher frequencies 
	to lower frequencies by averaging their components
	and storing in a new series

	Scenario: Aggregate to quarterly measurement by averaging months
		Given a series measured at a monthly frequency
		When I aggregate the series by quarter/average and store in a new series
		Then I should be able to retrieve the new series from the database
		And the measurements should equal the average of the 3 months in each of the complete quarters
		
	Scenario: Aggregate to annual measurement by averaging quarters
		Given a series measured at a monthly frequency
		When I aggregate the series by year/average and store in a new series
		Then I should be able to retrieve the new series from the database
		And the measurements should equal the average of the 12 months in each of the complete years
	
	Scenario: Aggregate to annual measurement by averaging quarters
		Given a series measured at a quarterly frequency
		When I aggregate the series by year/average and store in a new series
		Then I should be able to retrieve the new series from the database
		And the measurements should equal the average of the 4 quarters in each of the complete years
	
	Scenario: Unsuccessfully convert quarterly to monthly
		Given a series measured at a quarterly frequency
		When I attempt to aggregate the series by month/average and store in a new series
		Then the aggregation attempt should cause an AggregationException Error
		And I should not be able to retrieve that series from the database

	Scenario: Unsuccessfully convert annual to monthly
		Given a series measured at an annual frequency
		When I attempt to aggregate the series by month/average and store in a new series
		Then the aggregation attempt should cause an AggregationException Error
		And I should not be able to retrieve that series from the database
		
	Scenario: Unsuccessfully convert annual to quarterly
		Given a series measured at an annual frequency
		When I attempt to aggregate the series by quarter/average and store in a new series
		Then the aggregation attempt should cause an AggregationException Error
		And I should not be able to retrieve that series from the database
