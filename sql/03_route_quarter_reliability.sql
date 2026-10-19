-- create a table with the number of scheduled flights and on-time rate for each destination, year, and quarter
CREATE OR REPLACE TABLE route_quarter AS
SELECT
    DEST,
    YEAR,
    QUARTER,
    COUNT(*) AS scheduled_flights,
    AVG(1 - ARR_DEL15) AS on_time_rate
FROM dl_atl
GROUP BY DEST, YEAR, QUARTER;

-- find on-time rate for each quarter to compare with the on-time rate for each destination
CREATE OR REPLACE TABLE hub_quarter AS 
SELECT
    YEAR,
    QUARTER,
    COUNT(*) AS scheduled_flights,
    AVG(1 - ARR_DEL15) AS hub_on_time_rate
FROM dl_atl
GROUP BY YEAR, QUARTER
ORDER BY YEAR, QUARTER;
