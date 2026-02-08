# Hotel Bookings Analysis

## Project Description
This project focuses on **exploratory data analysis (EDA)** of the Hotel Booking Demand dataset to understand **customer behavior, revenue potential, Average Daily Rate (ADR), customer retention, and cancellation patterns** across market segments, hotel types, and years.

The analysis was conducted using **Excel, Python, and SQL**, with each tool serving a specific role in the workflow.

---

## Dataset
- **Source:** Kaggle – Hotel Booking Demand Dataset  
- **Records:** 119,000+ hotel bookings  

---

## Part 1: Exploratory Data Analysis with Excel

This phase focused on initial data exploration and visualization to uncover patterns, identify data quality issues, and generate early business insights. The cleaned dataset was later exported as a CSV file for Python and SQL analysis.

### Key Questions Answered
- How does waiting time relate to reservation outcomes?
- Which customer types are most reliable?
- Are repeated guests more likely to complete bookings?
- How does ADR vary by market segment and hotel type?

### Tools Used
- Pivot Tables  
- Pivot Charts  
- Slicers  

---

### Data Cleaning & Preparation (Excel)
The following steps were performed:

- Removed **31,994 duplicate rows** to ensure unique bookings
- Filled missing values in key columns
- Converted numeric columns stored as text to proper numeric formats
- Created helper columns:
  - `cancelled_status`
  - `total_guest`
  - `repeated_status`
- Identified (but did not remove) outliers:
  - `lead_time > 500`
  - `total_guest = 0`
  - `days_in_waiting_list > 50`
  - `adr ≤ 0`

---

### Key Insights (Excel)

#### Waiting Time & Reservation Outcomes
- Most bookings have **zero waiting time**
- Longer waiting times are associated with higher cancellation rates, especially for **Transient customers**
- Contract and Group customers show higher checkout rates but limited reliance on waiting lists

#### Customer Retention
- First-time guests dominate all customer types
- Repeated guests show significantly lower cancellation rates
- Repeated Contract guests display relatively high cancellation rates, requiring further investigation

#### ADR Analysis
- Direct bookings generate the highest ADR for **City Hotels**
- Online Travel Agents (OTA) generate the highest ADR for **Resort Hotels**
- Complimentary segments contribute minimal ADR

 **Excel File:**  
[1_hotel_bookings_exploratory_data_analysis.xlsx](1_Hotel Booking Demand Project/1_with_Excel/1_hotel_bookings_exploratory_data_analysis.xlsx)

 **Dashboard Preview:**  
![Hotel Booking Dashboard](1_Hotel Booking Demand Project/1_with_Excel/hotel_bookings_dashboard.png)

---

## Part 2: Data Analysis with Python

### Tools Used
- VS Code  
- Jupyter Notebook  
- Pandas  
- Matplotlib  
- Seaborn  

---

### Overview
- lead_time and days_in_waiting_list are heavily right-skewed
- Outliers exist in total_guest and adr
- One negative ADR value was identified as a data error and removed
- Extreme ADR values were retained due to minimal impact
- Missing values exist in country and agent
- Zero ADR values were filtered only for ADR specific analysis

---

### Lead Time & Cancellation Analysis
**Questions:**
1. Does booking lead time affect cancellation?
2. Does lead time influence cancellation across customer types?

**Insights:**
- Longer lead times generally increase cancellation likelihood
- Lead time is a stronger predictor for **Group and Contract customers**

---

### ADR & Pricing Patterns
**Questions:**
- Which market segments and hotel types show the highest revenue potential?
- How does ADR vary by month?
- Was there variation in ADR across years?

**Insights:**
- City Hotels have higher average ADR
- Direct bookings lead ADR for City Hotels
- OTAs lead ADR for Resort Hotels
- Complimentary and Undefined segments generate the least ADR
- City Hotels show relatively stable ADR across months
- Resort Hotels display strong seasonality, peaking in August
- Median ADR remains stable across years, with high-value outliers increasing variability
- Missing ADR months were identified and visualized

---

## Part 3: SQL Analysis

### Purpose
SQL (PostgreSQL) was used to validate insights, perform efficient aggregations, and replicate Python results using structured queries. Analysis focused on **revenue generating potential (adr > 0)**.

---

### Business Questions Answered
- Which hotel types have the highest booking volume?
- Which customer types have the highest cancellation risk?
- How does lead time affect cancellation across customer types?
- Which market segments generate the highest ADR?
- How does ADR vary across years?

---

### Key Insights
- City Hotels receive the highest booking volume
- Transient customers have the highest cancellation rates
- Longer lead times increase cancellation risk
- Repeated guests show stronger retention behavior
- Direct bookings generate the highest ADR for City Hotels
- OTAs generate the highest ADR for Resort Hotels
- Mean and median ADR reveal stable pricing with occasional high-value outliers

---

### Methodology
- Aggregations performed using 'GROUP BY'
- Median ADR calculated using 'PERCENTILE_CONT(0.5)'
- Revenue-focused filtering applied (adr > 0)
- SQL logic aligned with Python analysis for consistency

---

## Summary
Bookings are dominated by Transient and first-time guests, who also account for most cancellations. Repeated guests demonstrate stronger retention potential.

City Hotels achieve higher ADR primarily through Direct bookings, while Resort Hotels benefit more from OTA channels. ADR remains generally stable across years, with seasonal patterns and occasional high-value bookings.

---

## Repository Contents
- Excel dashboards and analysis files  
- Python notebooks  
- SQL scripts  

---

## Author
**Abigail Oyelowo**
