-- find on-time rate for each time of day (decreases throughout the day)
CREATE OR REPLACE TABLE hub_block AS
SELECT
    DEP_TIME_BLK,
    AVG(1 - ARR_DEL15) AS hub_block_rate
FROM dl_atl
GROUP BY DEP_TIME_BLK
ORDER BY DEP_TIME_BLK;

-- join the hub_block on-time rate per hour to flagged_routes on-time rate per hour
CREATE OR REPLACE TABLE route_block_gap AS
SELECT
    d.DEST,
    d.DEP_TIME_BLK,
    COUNT(*) AS scheduled_flights,
    AVG(1 - d.ARR_DEL15) AS route_block_rate,
    h.hub_block_rate,
    AVG(1 - d.ARR_DEL15) - h.hub_block_rate AS block_gap
FROM dl_atl AS d
JOIN hub_block AS h
ON d.DEP_TIME_BLK = h.DEP_TIME_BLK
WHERE d.DEST IN (SELECT DEST FROM flagged_routes)
GROUP BY d.DEST, d.DEP_TIME_BLK, h.hub_block_rate
ORDER BY d.DEST, d.DEP_TIME_BLK;

-- create table to adjust to time_of_day, making sure the time of day isn't the reason for a route's underperformance
CREATE OR REPLACE TABLE route_time_adjusted AS
SELECT
    g.DEST,
    ROUND(100 * f.avg_gap, 1) AS original_gap_pts,
    ROUND(100 * SUM(g.scheduled_flights * g.block_gap) / SUM(g.scheduled_flights), 1) AS adjusted_gap_pts
FROM route_block_gap AS g
JOIN flagged_routes AS f
ON g.DEST = f.DEST
GROUP BY g.DEST, f.avg_gap;

--quick check
SELECT * FROM route_time_adjusted
ORDER BY adjusted_gap_pts ASC;
