**Global Resilience \& Health Systems Initiative Dashboard**



**INTRODUCTION**

This project presents a complete end-to-end health analytics solution developed using SQL and Power BI. The project analyzes global health performance during the Covid\_19 pandemic by examining fatality trends, vaccination coverage, healthcare pressure, equity gaps, population density risk, and government response across regions.



The entire data engineering, cleaning, transformation, KPI generation, and data modeling processes were performed in SQL using a multi-layered architecture approach (Bronze, Silver, and Gold layers). The final analytical views were then imported into Power BI for dashboard development and visualization.



**2.  PROJECT OBJECTIVE**

* Analyze global fatality trends over time
* Evaluate vaccination coverage across regions
* Measure healthcare system pressure
* Identify inequality in healthcare access
* Assess population density risk
* Examine government response and disease spread
* Compare regional health performance
* Generate actionable business insights



**TOOLS \& TECHNOLOGIES**

SQL

Power BI

Excel



**3.  🗄 SQL DATA ENGINEERING \& MODELLING**



The entire backend data preparation process was completed in SQL using a layered data architecture.



**i.  🥉 Bronze Layer — Raw Data Layer**

The Bronze Layer contains the raw imported dataset in its original form.



Tasks Performed

* Imported raw pandemic dataset
* Preserved original data structure
* Stored raw records for traceability and auditing
* Maintained unprocessed source data



**ii. 🥈 Silver Layer — Data Cleaning \& Transformation**



The Silver Layer was used for cleaning and transforming the raw data into structured analytical datasets.



Data Cleaning Performed...

* Removed duplicate records
* Handled missing and null values
* Standardized inconsistent values
* Corrected data formatting issues
* Converted data types
* Filtered invalid records
* Structured cleaned tables for analysis

 Data Transformation
 
* Aggregated regional metrics
* Created analytical columns
* Standardized continent and country data
* Generated transformed reporting tables



**iii. 🥇 Gold Layer — Analytical \& Business Layer**



The Gold Layer contains business-ready analytical views and KPI calculations used in Power BI.



KPIs Calculated in SQL...

* Fatality Rate
* Vaccination Coverage
* Equity Gap Index
* Population Density Risk Index
* Healthcare Pressure Index
* Reproduction Rate
* Government Response
  
Analytical Operations Performed
* Aggregations
* Trend analysis
* Regional comparisons
* Risk calculations
* Performance analysis
* Derived metric generation



**4.  SQL DATA MODELING**



Data modeling was fully implemented in SQL before importing into Power BI.



Modeling Process....

* Created structured analytical views
* Built relationships between datasets
* Organized reporting tables
* Optimized query structure for reporting
* Prepared star-schema compatible outputs for Power BI



The final SQL views served as the primary source for visualization in Power BI.



**5.  POWER BI DASHBOARD DEVELOPMENT**



The transformed SQL views were imported into Power BI for interactive dashboard visualization and analysis.



Power BI Features Used

* KPI Cards
* Line Charts
* Bar Charts
* Column Charts
* Scatter Plots
* Filled Map
* Slicers
* Cross-visual interactions
* Interactive filtering



**6.  DASHBORD PAGES**



**6.1  Page 1 — Global Health Performance Overview**



<img width="2836" height="1482" alt="page one" src="https://github.com/user-attachments/assets/3c0002c1-4dfe-4cda-8b9b-3527f5c0fa42" />




This page provides a high-level overview of:



1. Fatality Rate
2. Vaccination Coverage
3. Equity Gap
4. Population Density Risk
5. Healthcare Pressure
   
&#x20;  **Key Insights**

* Fatality rate declined significantly over time
* Vaccination coverage improved moderately
* Healthcare inequality remains high
* Healthcare pressure varies across regions



**6.2  Page 2 — Vaccination Impact \& Outcome Relationships**

<img width="2856" height="1502" alt="page 2" src="https://github.com/user-attachments/assets/e3f4eecd-8154-4cf9-bed6-3c1df3b955d1" />


This page explores relationships between:



1. Vaccination Coverage
2. Fatality Rate
3. Equity Gap
4. Reproduction Rate


&#x20;  **Key Insights**

* Higher vaccination is associated with lower fatality
* Disease spread reduced over time
* Inequality persists despite vaccination improvements
* Regional variations influence outcomes



**6.3  Page 3 — Risk \& System Analysis**

<img width="2582" height="1452" alt="3" src="https://github.com/user-attachments/assets/8e619e91-25de-4a25-8d30-cb20bb0bedeb" />


This page focuses on:



1. Population Density Risk
2. Government Response
3. Reproduction Rate
4. Healthcare Pressure

&#x20; **Key Insights**

* High density increases transmission risk
* Government response reduced over time
* Reproduction rate declined significantly
* Healthcare systems stabilized gradually





**7.  OVERALL FINDINGS**



* Global fatality rates declined over time
* Vaccination coverage improved but remains moderate
* Equity gaps indicate uneven healthcare access
* Population density contributes to transmission risk
* Healthcare pressure reduced gradually over time
* Regional differences strongly influence outcomes



**7.1  Limitations**

1. Some regions contain incomplete or missing data
2. Certain KPIs are derived analytical measures
3. Results may vary based on reporting quality across regions



**8.  RECOMMENDATIONS**

* Improve equitable vaccine distribution
* Strengthen healthcare systems
* Maintain effective government response
* Focus on high-density regions
* Improve data collection and reporting



**9. CONCLUSION**



Overall, global health outcomes improved over time, with declining fatality rates and reduced disease spread. However, healthcare inequality, regional disparities, and varying system capacities remain major challenges requiring continuous monitoring and stragetic intervention.

