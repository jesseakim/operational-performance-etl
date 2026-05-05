# Metric Definitions

## Planned Service Time
The expected time allocated to complete service-related work.

## Actual Service Time
The observed time spent completing service-related work.

## Service Time Variance
Definition:
planned_service_time - actual_service_time

---

## Planned Travel Time
The expected time allocated for travel between tasks or locations.

## Actual Travel Time
The observed time spent traveling.

## Travel Time Variance
Definition:
planned_travel_time - actual_travel_time

---

## Under Utilization Rate
The percentage of entities where actual time used is significantly lower than allocated time.

Definition:
under_utilized_count / route_count

---

## Anomaly Score
A standardized measure of how far a metric deviates from its historical median using interquartile range (IQR).

Definition:
(metric_value - median_value) / IQR

---

## Alert Status

Classification based on anomaly score:

- Red Alert: Absolute anomaly score >= 3  
- Amber Alert: Absolute anomaly score >= 2  
- In Goal: Below anomaly thresholds  
