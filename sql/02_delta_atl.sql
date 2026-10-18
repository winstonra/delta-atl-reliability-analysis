-- create a table only for Delta flights originating from Atlanta (ATL)
CREATE OR REPLACE TABLE dl_atl AS
SELECT * FROM flights 
WHERE OP_UNIQUE_CARRIER = 'DL' AND ORIGIN = 'ATL';

-- check how many Delta flights from Atlanta are in the table
SELECT COUNT(*) AS num_flights 
FROM dl_atl;