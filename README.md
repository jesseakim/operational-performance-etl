# Operational Performance ETL

## Overview

This project implements a SQL-based ETL pipeline that transforms raw operational route data into structured performance metrics. The pipeline focuses on comparing planned versus actual outcomes to evaluate efficiency, utilization, and operational variance across a network.

It is designed to reflect real-world data workflows, where raw inputs are standardized, transformed, and aggregated into business-ready outputs for analysis and monitoring.

---

## Objectives

* Transform raw route-level data into structured datasets
* Compare planned vs. actual performance metrics
* Identify operational variance and efficiency gaps
* Support performance monitoring and analysis

---

## Pipeline Design

The ETL process follows a staged approach:

**1. Data Preparation**

* Standardizes date and time dimensions
* Filters relevant operational data

**2. Data Transformation**

* Maps service types and operational groupings
* Structures data for metric calculations

**3. Metric Calculation**

* Planned vs. actual service time
* Planned vs. actual transit time
* Route-level performance indicators

**4. Aggregation & Output**

* Produces datasets for reporting and analysis
* Supports time-based trend evaluation

---

## Key Metrics

* Service Time (Planned vs. Actual)
* Transit Time (Planned vs. Actual)
* Route Count
* Split Route Indicator
* Operational Variance

---

## Project Structure

```id="readme-structure"
sql/
  01_date_helpers.sql
  02_route_base_data.sql
  03_service_type_mapping.sql
  04_route_time_metrics.sql
  05_anomaly_scoring.sql

docs/
  metric_definitions.md
  data_dictionary.md
  sanitization_notes.md

sample_output/
  route_time_metrics_sample.csv
```

---

## Use Cases

* Evaluate operational efficiency across time and regions
* Identify gaps between planning and execution
* Support performance reporting workflows
* Serve as a foundation for anomaly detection systems

---

## Notes

All data sources, table names, and identifiers have been generalized to preserve confidentiality while maintaining the structure and logic of the pipeline.
