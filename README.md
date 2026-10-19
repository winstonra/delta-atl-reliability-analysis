# Delta ATL Route Reliability Analysis

Which Delta routes out of Hartsfield-Jackson Atlanta International Airport (ATL) underperform the ATL network average in operational reliability? What contributes to that underperformance, and what actions could improve it?

---

## Scope

- **Flights:** Delta-operated domestic flights departing ATL
- **Time period:** Most recent 12 complete months, analyzed by quarter
- **Data:** [BTS On-Time Performance](https://www.transtats.bts.gov/) (every US domestic flight, with delays, cancellations, and delay causes)
- **Minimum volume:** At least 100 scheduled flights per route per quarter

---

## 1. Defining Reliability

**On-time arrival rate (A15):** share of completed flights arriving less than 15 minutes late

$$\text{OTP}_{15} = \frac{\text{completed flights arriving} < 15 \text{ min late}}{\text{completed flights}}$$

### What counts as an underperforming route

A route is flagged if it meets **all** of the following:

- At least 100 scheduled flights in the quarter
- On-time arrival rate at least **5 percentage points below** the ATL network average (network average weighted by flights, not by route)
- This happens in **at least 2 of the 4 quarters**

For every flagged route, I also compare it against ATL flights in the **same departure-time window** to check whether the gap persists after accounting for time of day.

---

## 2. Identifying Causes

For each flagged route, delay minutes are broken down by cause:

$$\text{Share}_c = \frac{\text{delay minutes from cause } c}{\text{total delay minutes}} \times 100$$

**Causes (from BTS):**
- Carrier
- Weather
- National Aviation System (NAS)
- Security
- Late-arriving aircraft

From the dominant causes, I examine factors such as time of day, season, and congestion to form a hypothesis about what drives each gap.

---

## 3. Impact & Recommendations

- **Where is the problem?** Which Delta routes consistently underperform, and by how much?
- **What explains it?** Are the gaps tied to carrier delays, weather, NAS, late-arriving aircraft, or particular departure windows?
- **What should Delta do?** Which changes are worth investigating, and what improvement could reasonably be expected?

---

## Tools & Workflow

**SQL**
- Filter and clean the flight records
- Aggregate by route, quarter, and departure-time window
- Calculate reliability metrics and baseline gaps
- Rank routes and compare delay causes

**Excel**
- Pivot tables for route and quarterly comparisons
- Bar charts showing the largest reliability gaps
- Stacked bars for delay-cause composition
- A dashboard with filters for quarter, route, and metric
