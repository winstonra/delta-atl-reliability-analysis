-- create a table with the number of scheduled flights and on-time percentage for each destination, year, and quarter
CREATE OR REPLACE TABLE route_quarter AS
SELECT
    DEST,
    YEAR,
    QUARTER,
    COUNT(*) AS scheduled_flights,
    AVG(1 - ARR_DEL15) AS on_time_rate
FROM dl_atl
GROUP BY DEST, YEAR, QUARTER;

