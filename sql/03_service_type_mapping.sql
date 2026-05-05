-- ============================================================================
-- Service Type Mapping
-- Standardizes operational categories into reporting groups.
-- ============================================================================

WITH service_type_mapping AS (
    SELECT DISTINCT
        service_type,

        CASE
            WHEN service_type ILIKE '%premium%'
              OR service_type ILIKE '%specialized%'
              OR service_type ILIKE '%enhanced%'
                THEN 'Specialized Operations'
            ELSE 'Core Operations'
        END AS operation_type,

        CASE
            WHEN service_type ILIKE '%single%'
              OR service_type ILIKE '%standard%'
                THEN 'Standard Route'
            WHEN service_type ILIKE '%multi%'
              OR service_type ILIKE '%helper%'
              OR service_type ILIKE '%specialized%'
                THEN 'Assisted Route'
            WHEN service_type ILIKE '%rapid%'
              OR service_type ILIKE '%express%'
                THEN 'Expedited Route'
            ELSE 'Other'
        END AS service_group

    FROM source_operational_data
    WHERE event_date BETWEEN DATEADD(week, -21, DATE_TRUNC('week', CURRENT_DATE))
        AND DATE_TRUNC('week', CURRENT_DATE) + INTERVAL '6 days'
)

SELECT *
FROM service_type_mapping;
