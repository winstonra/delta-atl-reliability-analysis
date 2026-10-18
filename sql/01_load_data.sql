-- Load all 12 monthly BTS CSVs into one table
CREATE OR REPLACE TABLE flights AS
SELECT *
FROM read_csv('raw_data/*.csv', union_by_name = true);

-- Check: flights per month (expect 12 months, ~500k-630k each)
SELECT YEAR, MONTH, COUNT(*) AS num_flights
FROM flights
GROUP BY YEAR, MONTH
ORDER BY YEAR, MONTH;