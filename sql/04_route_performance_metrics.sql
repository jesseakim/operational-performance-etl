-- ============================================================================
-- Route Performance Metrics
-- Combines base operational data with reporting groups and calculates
-- route-level planned vs. actual performance metrics.
-- ============================================================================

WITH route_performance_metrics AS (
    SELECT
        b.event_date,
        b.location_id,
        b.region,
        b.route_id,
        b.service_type,
        m.operation_type,
        m.service_group,
        b.route_group,

        b.planned_service_time,
        b.actual_service_time,
        b.planned_travel_time,
        b.actual_travel_time,
        b.planned_total_time,
        b.actual_total_time,

        b.service_time_variance,
        b.travel_time_variance,
        b.total_time_variance,

        ABS(b.service_time_variance) AS abs_service_time_variance,
        ABS(b.travel_time_variance) AS abs_travel_time_variance,

        b.unit_count,

CASE
    WHEN b.actual_time < b.paid_time - 30 THEN 1
    ELSE 0
END AS under_utilized_flag,

        1 AS route_count,

CASE
    WHEN b.is_split_route = 1 THEN 1
    ELSE 0
END AS split_flag,

        b.active_time,
        b.paid_time

    FROM route_base_data b
    LEFT JOIN service_type_mapping m
        ON b.service_type = m.service_type
)

SELECT *
FROM route_performance_metrics;
