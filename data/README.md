# Data

## Source
[BTS Reporting Carrier On-Time Performance (1987–present)](https://www.transtats.bts.gov/DL_SelectFields.aspx?gnoyr_VQ=FGJ&QO_fu146_anzr=b0-gvzr), U.S. Bureau of Transportation Statistics

## Coverage
- **Period:** July 2025 – June 2026 (12 months, Q3 2025 – Q2 2026)
- **Geography filter:** All (filtered to Delta departures from ATL during analysis)
- **Downloaded:** October 16, 2026

Raw files are not stored in this repo due to size. To reproduce, download each month from the link above with the fields below selected, and save as `data/raw/YYYY_MM.csv`.

## Fields selected

| Group | Fields |
|---|---|
| Time Period | Year, Quarter, Month, FlightDate |
| Airline | Reporting_Airline, Flight_Number_Reporting_Airline, Tail_Number |
| Origin | OriginAirportID, OriginAirportSeqID, OriginCityMarketID, Origin |
| Destination | DestAirportID, DestAirportSeqID, DestCityMarketID, Dest |
| Departure Performance | CRSDepTime, DepDelay, DepTimeBlk, TaxiOut |
| Arrival Performance | CRSArrTime, ArrDelay, ArrDel15 |
| Cancellations & Diversions | Cancelled, CancellationCode, Diverted |
| Flight Summaries | Distance |
| Cause of Delay | CarrierDelay, WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay |

## Notes
- Delay-cause minutes are only reported for flights arriving 15+ minutes late.
- "Delta-operated" = carrier code `DL` only; Delta Connection regional flights (e.g., Endeavor `9E`) are excluded.
