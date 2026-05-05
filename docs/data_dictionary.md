# Data Dictionary

## event_date
Date associated with the operational record.

## location_id
Identifier for the operational location.

## region
High-level grouping used to segment data geographically or operationally.

## route_id
Unique identifier representing an individual route or operational unit.

## service_type
Raw category describing the type of operation or service.

## route_group
Grouping used to categorize similar routes or operational flows.

## operation_type
Standardized grouping of service types (e.g., Core vs Specialized).

## service_group
Higher-level classification of service behavior (e.g., Standard, Assisted, Expedited).

## planned_service_time
Expected time allocated for service-related activities.

## actual_service_time
Observed time spent on service-related activities.

## planned_travel_time
Expected time allocated for travel.

## actual_travel_time
Observed time spent traveling.

## planned_total_time
Total expected time for the operation.

## actual_total_time
Total observed time for the operation.

## service_time_variance
Difference between planned and actual service time.

## travel_time_variance
Difference between planned and actual travel time.

## total_time_variance
Difference between planned and actual total time.

## unit_count
Number of units processed (e.g., deliveries, tasks, items).

## planned_time
Total planned operational time.

## actual_time
Total actual operational time.

## paid_time
Time allocated or compensated for the operation.

## under_utilized_flag
Indicator showing whether actual time used is significantly lower than allocated time.

## route_count
Count of operational routes or units.

## split_flag
Indicator for whether an operation was split into multiple segments.

## active_time
Time actively spent performing the operation.

## year_week
Year and week identifier used for aggregation.

## operation_type
Standardized grouping of service types.

## metric_name
Name of the calculated metric used in anomaly detection.

## metric_value
Value of the metric being evaluated.

## median_value
Median value of the metric over a rolling window.

## iqr_value
Interquartile range used for anomaly scoring.

## anomaly_score
Standardized deviation from the median.

## alert_status
Classification of performance based on anomaly thresholds.
