-- ============================================================================
-- Date Helper
-- Creates standardized date dimensions for route performance reporting.
-- ============================================================================

WITH date_helper AS (
    SELECT DISTINCT
        CAST(route_date AS DATE) AS route_date,

        TO_CHAR(route_date + INTERVAL '1 day', 'IYYY-') 
            || LPAD(TO_CHAR(route_date + INTERVAL '1 day', 'IW'), 2, '0') 
            AS year_week,

        TO_CHAR(route_date, 'YYYY-') 
            || LPAD(TO_CHAR(route_date, 'MM'), 2, '0') 
            AS year_month,

        TO_CHAR(route_date, 'YYYY-') 
            || LPAD(TO_CHAR(route_date, 'Q'), 2, '0') 
            AS year_quarter

    FROM source_route_details
    WHERE route_date BETWEEN DATEADD(week, -21, DATE_TRUNC('week', CURRENT_DATE))
        AND DATE_TRUNC('week', CURRENT_DATE) + INTERVAL '6 days'
)
SELECT *
FROM date_helper;
