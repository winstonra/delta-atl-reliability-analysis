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

-- create table to find underperforming routes by comparing on-time rates of routes to the hub on-time rate for each quarter
CREATE OR REPLACE TABLE route_quarter_gap AS
SELECT 
    r.DEST,
    r.YEAR,
    r.QUARTER,
    r.scheduled_flights,
    r.on_time_rate,
    h.hub_on_time_rate,
    r.on_time_rate - h.hub_on_time_rate AS gap,
    CASE
        WHEN r.scheduled_flights >= 100
        AND r.on_time_rate - h.hub_on_time_rate <= -0.05
        THEN 1 ELSE 0
    END AS is_underperforming
FROM route_quarter AS r
JOIN hub_quarter AS h
ON r.YEAR = h.YEAR AND r.quarter = h.quarter;

-- ensure same number of rows in route_quarter and route_quarter_gap
SELECT
    (SELECT COUNT(*) FROM route_quarter) AS before_join,
    (SELECT COUNT(*) FROM route_quarter_gap) AS after_join;

-- quick check, what are the top 20 underperforming routes by gap
SELECT
    DEST,
    YEAR,
    QUARTER,
    scheduled_flights,
    ROUND(100 * gap, 1) as gap_pts,
FROM route_quarter_gap
WHERE scheduled_flights >= 100
ORDER BY gap_pts ASC
LIMIT 20;

