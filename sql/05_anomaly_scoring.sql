-- ============================================================================
-- Anomaly Scoring
-- Aggregates route performance metrics weekly and applies IQR-based anomaly logic.
-- ============================================================================

WITH weekly_metrics AS (
    SELECT
        year_week,
        region,
        operation_type,

        SUM(planned_travel_time) AS planned_travel_time,
        SUM(actual_travel_time) AS actual_travel_time,

        SUM(planned_service_time) AS planned_service_time,
        SUM(actual_service_time) AS actual_service_time,

        SUM(under_utilized_flag) AS under_utilized_count,
        SUM(route_count) AS route_count

    FROM route_performance_metrics
    GROUP BY
        year_week,
        region,
        operation_type
),

weekly_metric_calculations AS (
    SELECT
        year_week,
        region,
        operation_type,

        (planned_travel_time - actual_travel_time)::FLOAT
            / NULLIF(actual_travel_time, 0) AS travel_time_variance_pct,

        (planned_service_time - actual_service_time)::FLOAT
            / NULLIF(actual_service_time, 0) AS service_time_variance_pct,

        under_utilized_count::FLOAT
            / NULLIF(route_count, 0) AS under_utilization_rate,

        ROW_NUMBER() OVER (
            PARTITION BY region, operation_type
            ORDER BY year_week
        ) AS row_num

    FROM weekly_metrics
),

metric_stats AS (
    SELECT
        a.year_week,
        a.region,
        a.operation_type,
        'Travel Time Variance %' AS metric_name,
        a.travel_time_variance_pct AS metric_value,

        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY b.travel_time_variance_pct
        ) AS median_value,

        PERCENTILE_CONT(0.75) WITHIN GROUP (
            ORDER BY b.travel_time_variance_pct
        ) AS q3_value,

        PERCENTILE_CONT(0.25) WITHIN GROUP (
            ORDER BY b.travel_time_variance_pct
        ) AS q1_value

    FROM weekly_metric_calculations a
    LEFT JOIN weekly_metric_calculations b
        ON a.region = b.region
        AND a.operation_type = b.operation_type
        AND b.row_num BETWEEN a.row_num - 20 AND a.row_num
    GROUP BY
        a.year_week,
        a.region,
        a.operation_type,
        a.travel_time_variance_pct

    UNION ALL

    SELECT
        a.year_week,
        a.region,
        a.operation_type,
        'Service Time Variance %' AS metric_name,
        a.service_time_variance_pct AS metric_value,

        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY b.service_time_variance_pct
        ) AS median_value,

        PERCENTILE_CONT(0.75) WITHIN GROUP (
            ORDER BY b.service_time_variance_pct
        ) AS q3_value,

        PERCENTILE_CONT(0.25) WITHIN GROUP (
            ORDER BY b.service_time_variance_pct
        ) AS q1_value

    FROM weekly_metric_calculations a
    LEFT JOIN weekly_metric_calculations b
        ON a.region = b.region
        AND a.operation_type = b.operation_type
        AND b.row_num BETWEEN a.row_num - 20 AND a.row_num
    GROUP BY
        a.year_week,
        a.region,
        a.operation_type,
        a.service_time_variance_pct

    UNION ALL

    SELECT
        a.year_week,
        a.region,
        a.operation_type,
        'Under Utilization Rate' AS metric_name,
        a.under_utilization_rate AS metric_value,

        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY b.under_utilization_rate
        ) AS median_value,

        PERCENTILE_CONT(0.75) WITHIN GROUP (
            ORDER BY b.under_utilization_rate
        ) AS q3_value,

        PERCENTILE_CONT(0.25) WITHIN GROUP (
            ORDER BY b.under_utilization_rate
        ) AS q1_value

    FROM weekly_metric_calculations a
    LEFT JOIN weekly_metric_calculations b
        ON a.region = b.region
        AND a.operation_type = b.operation_type
        AND b.row_num BETWEEN a.row_num - 20 AND a.row_num
    GROUP BY
        a.year_week,
        a.region,
        a.operation_type,
        a.under_utilization_rate
),

scored_metrics AS (
    SELECT
        year_week,
        region,
        operation_type,
        metric_name,
        metric_value,
        median_value,
        q3_value - q1_value AS iqr_value,

        (metric_value - median_value)
            / NULLIF(q3_value - q1_value, 0) AS anomaly_score,

        CASE
            WHEN ABS((metric_value - median_value)
                / NULLIF(q3_value - q1_value, 0)) >= 3
                THEN 'Red Alert'

            WHEN ABS((metric_value - median_value)
                / NULLIF(q3_value - q1_value, 0)) >= 2
                THEN 'Amber Alert'

            ELSE 'In Goal'
        END AS alert_status

    FROM metric_stats
)

SELECT *
FROM scored_metrics
ORDER BY region, operation_type, metric_name, year_week;
