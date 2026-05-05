WITH route_base_data AS (
    SELECT
        CAST(event_date AS DATE) AS event_date,
        location_id,
        region,
        route_id,
        service_type,
        route_group,

        planned_service_time,
        actual_service_time,

        planned_travel_time,
        actual_travel_time,

        planned_total_time,
        actual_total_time,

        service_time_variance,
        travel_time_variance,
        total_time_variance,

        unit_count,
        planned_time,
        actual_time,
        paid_time,

        is_split_route,
        active_time

    FROM source_operational_data
    WHERE event_date BETWEEN DATEADD(week, -21, DATE_TRUNC('week', CURRENT_DATE))
        AND DATE_TRUNC('week', CURRENT_DATE) + INTERVAL '6 days'
)
SELECT *
FROM route_base_data;
