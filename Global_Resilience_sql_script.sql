
--***BRONZE LAYER***--
--Creating a stagged table to host my raw dataset imported from a csv file
CREATE TABLE STG_GLOBAL_RESILIENCE (
    country VARCHAR2(255),
    report_date DATE,
    total_cases NUMBER,
    new_cases NUMBER,
    new_cases_smthd NUMBER,
    total_cases_per_mil NUMBER,
    new_cases_per_mil NUMBER,
    new_cases_smthd_per_mil NUMBER,
    total_deaths NUMBER,
    new_deaths NUMBER,
    new_deaths_smthd NUMBER,
    total_deaths_per_mil NUMBER,
    new_deaths_per_mil NUMBER,
    new_deaths_smthd_per_mil NUMBER,
    excess_mort NUMBER,
    excess_mort_cumul NUMBER,
    excess_mort_cumul_abs NUMBER,
    excess_mort_cumul_per_mil NUMBER,
    hosp_patients NUMBER,
    hosp_patients_per_mil NUMBER,
    weekly_hosp_adm NUMBER,
    weekly_hosp_adm_per_mil NUMBER,
    icu_patients NUMBER,
    icu_patients_per_mil NUMBER,
    weekly_icu_adm NUMBER,
    weekly_icu_adm_per_mil NUMBER,
    stringency_index NUMBER,
    reproduction_rate NUMBER,
    total_tests NUMBER,
    new_tests NUMBER,
    total_tests_per_thou NUMBER,
    new_tests_per_thou NUMBER,
    new_tests_smthd NUMBER,
    new_tests_smthd_per_thou NUMBER,
    positive_rate NUMBER,
    tests_per_case NUMBER,
    total_vacc NUMBER,
    people_vacc NUMBER,
    people_fully_vacc NUMBER,
    total_boosters NUMBER,
    new_vacc NUMBER,
    new_vacc_smthd NUMBER,
    total_vacc_per_hun NUMBER,
    people_vacc_per_hun NUMBER,
    people_fully_vacc_per_hun NUMBER,
    total_boosters_per_hun NUMBER,
    new_vacc_smthd_per_mil NUMBER,
    new_people_vacc_smthd NUMBER,
    new_people_vacc_smthd_per_hun NUMBER,
    code VARCHAR2(255),
    continent VARCHAR2(255),
    population NUMBER,
    population_density NUMBER,
    median_age NUMBER,
    life_expectancy NUMBER,
    gdp_per_capita NUMBER,
    extreme_poverty NUMBER,
    diabetes_prevalence NUMBER,
    handwashing_facilities NUMBER,
    hospital_beds_per_thou NUMBER,
    human_dev_index NUMBER
);
-- SQL loader line of code to load/import csv flat file to my stagged table
--sqlldr userid=JOSEPH/JOSEPH@XE control='MY_CONTROL.ctl' log=load.log

--Checking if the dataset has been loaded into the stagged table
SELECT *
FROM JOSEPH.STG_GLOBAL_RESILIENCE;

--***SILVER LAYER***---

--creating a new table I will clean and use for my KPI
CREATE TABLE GLOBAL_RESILIENCE AS
SELECT country,code, continent, report_date, population,  
total_cases, total_deaths, icu_patients, hosp_patients, 
weekly_hosp_adm, reproduction_rate, people_fully_vacc, 
people_fully_vacc_per_hun, positive_rate, stringency_index, 
population_density, total_cases_per_mil
FROM STG_GLOBAL_RESILIENCE;

COMMIT;

--checking to see the dataset in my new table GLOBAL_RESILIENCE
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE;


--**********************************************************
--Data Cleaning and Data Transformation
--Taking care of NULL values

--creating an additional column for our flag
ALTER TABLE GLOBAL_RESILIENCE
ADD FLAG_INDEX NUMBER;

COMMIT;

--updating the flag_index column with 1 for rows with atleast 1 null value
-- and 0 for rows with atleast 1 non-null value  so as to filter out imputed
--data from original data

--for non-null values
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET FLAG_INDEX = 0
WHERE code IS NOT NULL OR population IS NOT NULL OR 
continent IS NOT NULL OR total_cases IS NOT NULL OR total_deaths IS NOT NULL OR
icu_patients IS NOT NULL OR hosp_patients IS NOT NULL OR weekly_hosp_adm IS NOT NULL OR
reproduction_rate IS NOT NULL OR people_fully_vacc IS NOT NULL OR 
people_fully_vacc_per_hun IS NOT NULL OR positive_rate IS NOT NULL OR
stringency_index IS NOT NULL OR population_density IS NOT NULL OR 
total_cases_per_mil IS NOT NULL;

--for null values
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET FLAG_INDEX = 1
WHERE code IS NULL OR population IS NULL OR 
continent IS NULL OR total_cases IS NULL OR total_deaths IS NULL OR
icu_patients IS NULL OR hosp_patients IS NULL OR weekly_hosp_adm IS NULL OR
reproduction_rate IS NULL OR people_fully_vacc IS NULL OR 
people_fully_vacc_per_hun IS NULL OR positive_rate IS NULL OR
stringency_index IS NULL OR population_density IS NULL OR 
total_cases_per_mil IS NULL;

COMMIT;

--check if the population column has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE POPULATION IS NULL;

--fill up the population null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET POPULATION = 0
WHERE POPULATION IS NULL;
 
--check if the total_cases column has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE TOTAL_CASES IS NULL;

--fill up the total_cases null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET TOTAL_CASES = 0
WHERE TOTAL_CASES IS NULL;

--check if TOTAL_DEATHS has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE TOTAL_DEATHS IS NULL;
 
--fill up the TOTAL_DEATHS null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET TOTAL_DEATHS = 0
WHERE TOTAL_DEATHS IS NULL;

--check if ICU_PATIENTS has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE ICU_PATIENTS IS NULL;

--fill up the ICU_PATIENTS null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET ICU_PATIENTS = 0
WHERE ICU_PATIENTS IS NULL;

--check if HOSP_PATIENTS has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE HOSP_PATIENTS IS NULL;

--fill up the HOSP_PATIENTS null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET HOSP_PATIENTS = 0
WHERE HOSP_PATIENTS IS NULL;

--check if WEEKLY_HOSP_ADM has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE WEEKLY_HOSP_ADM IS NULL;

--fill up the HOSP_PATIENTS null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET WEEKLY_HOSP_ADM = 0
WHERE WEEKLY_HOSP_ADM IS NULL;

--check if REPRODUCTION_RATE has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE REPRODUCTION_RATE IS NULL;

--fill up the REPRODUCTION_RATE null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET REPRODUCTION_RATE = 0
WHERE REPRODUCTION_RATE IS NULL;

--check if PEOPLE_FULLY_VACC has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE PEOPLE_FULLY_VACC IS NULL;

--fill up the PEOPLE_FULLY_VACC null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET PEOPLE_FULLY_VACC = 0
WHERE PEOPLE_FULLY_VACC IS NULL;

--check if the PEOPLE_FULLY_VACC_PER_HUN has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE PEOPLE_FULLY_VACC_PER_HUN IS NULL;

--fill up the PEOPLE_FULLY_VACC_PER_HUN null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET PEOPLE_FULLY_VACC_PER_HUN = 0
WHERE PEOPLE_FULLY_VACC_PER_HUN IS NULL;

SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE;

--check if POSITIVE_RATE has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE POSITIVE_RATE IS NULL;

--fill up the POSITIVE_RATE null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET POSITIVE_RATE = 0
WHERE POSITIVE_RATE IS NULL;

--check if STRINGENCY_INDEX has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE STRINGENCY_INDEX IS NULL;

--fill up the STRINGENCY_INDEX null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET STRINGENCY_INDEX = 0
WHERE STRINGENCY_INDEX IS NULL;

--check if POPULATION_DENSITY has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE POPULATION_DENSITY IS NULL;

--fill up the POPULATION_DENSITY null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET POPULATION_DENSITY = 0
WHERE POPULATION_DENSITY IS NULL;

--check if TOTAL_CASES_PER_MIL has null values
SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE TOTAL_CASES_PER_MIL IS NULL;

--fill up the TOTAL_CASES_PER_MIL null values with 0
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET TOTAL_CASES_PER_MIL = 0
WHERE TOTAL_CASES_PER_MIL IS NULL;

--CHECKING FOR CONTRIES WITH NO CONTINENT
SELECT DISTINCT COUNTRY, CONTINENT
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE CONTINENT IS NULL;

SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE;

--fill up the  CONTRIES WITH NO CONTINENT with Others
UPDATE JOSEPH.GLOBAL_RESILIENCE
SET CONTINENT = 'Others'
WHERE CONTINENT IS NULL;

SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE;

SELECT DISTINCT COUNTRY, CONTINENT
FROM GLOBAL_RESILIENCE
WHERE CONTINENT = 'Others';

--checking countries with no code
SELECT DISTINCT COUNTRY, CODE
FROM JOSEPH.GLOBAL_RESILIENCE
WHERE CODE IS NULL;

--fill up the countries with no code
UPDATE GLOBAL_RESILIENCE
SET CODE = 'SCL'
WHERE COUNTRY = 'Scotland';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'UMIC'
WHERE COUNTRY = 'Upper-middle-income countries';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'WCSJS'
WHERE COUNTRY = 'World excl. China, South Korea, Japan and Singapore';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'LIC'
WHERE COUNTRY = 'Low-income countries';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'WAL'
WHERE COUNTRY = 'Wales';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'LMIC'
WHERE COUNTRY = 'Lower-middle-income countries';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'NIRL'
WHERE COUNTRY = 'Northern Ireland';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'SO2020'
WHERE COUNTRY = 'Summer Olympics 2020';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'ACH'
WHERE COUNTRY = 'Asia excl. China';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'HIC'
WHERE COUNTRY = 'High-income countries';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'WCH'
WHERE COUNTRY = 'World excl. China';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'ENG'
WHERE COUNTRY = 'England';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'EWAL'
WHERE COUNTRY = 'England and Wales';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'WO2022'
WHERE COUNTRY = 'Winter Olympics 2022';

UPDATE GLOBAL_RESILIENCE
SET CODE = 'WCS'
WHERE COUNTRY = 'World excl. China and South Korea';

SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE;

COMMIT;


--*** TAKING CARE OF DUPLICATE VALUES **---
--checking for duplicates in the whole table, using  country, continent,and REPORT_DATE columns

SELECT country, continent, report_date, population,  
total_cases, total_deaths, icu_patients, hosp_patients, 
weekly_hosp_adm, reproduction_rate, people_fully_vacc, 
people_fully_vacc_per_hun, positive_rate, stringency_index, 
population_density, total_cases_per_mil, COUNT(*)

FROM GLOBAL_RESILIENCE

GROUP BY country, continent, report_date, population,  
total_cases, total_deaths, icu_patients, hosp_patients, 
weekly_hosp_adm, reproduction_rate, people_fully_vacc, 
people_fully_vacc_per_hun, positive_rate, stringency_index, 
population_density, total_cases_per_mil, REPORT_DATE
HAVING COUNT(*) > 1;

COMMIT;

SELECT *
FROM  GLOBAL_RESILIENCE
WHERE (country, report_date) IN (
    SELECT country, report_date
    FROM  GLOBAL_RESILIENCE
    GROUP BY country, report_date
    HAVING COUNT(*) > 1
);

--Trimming all the text columns

UPDATE GLOBAL_RESILIENCE
SET country = TRIM(country);

UPDATE GLOBAL_RESILIENCE
SET continent = TRIM(continent);

UPDATE GLOBAL_RESILIENCE
SET code = TRIM(code);


COMMIT;

SELECT *
FROM JOSEPH.GLOBAL_RESILIENCE;

--***GOLD LAYER***---

--*** Data Modelling ***---
--** STAR-SCHEMA MODEL *** 1 Location Dimension, 1 Date Dimension and 1 Facts table---

-- 1. Location Dimension
CREATE TABLE Dim_Location (
     country    VARCHAR2(255) NOT NULL,
     code       VARCHAR2(255) PRIMARY KEY,
     continent  VARCHAR2(255)
);

COMMIT;

-- 1 Date Dimension
-- Includes specialized columns for Power BI time-intelligence

CREATE TABLE Dim_Date (
    report_date   DATE PRIMARY KEY,
    month_name    VARCHAR2(255),
    yearly        NUMBER, 
    quarterly     VARCHAR2(255) 
);

COMMIT;

-- 1 Fact Table
CREATE TABLE Fact_Resilience (
    fact_id                    NUMBER PRIMARY KEY,
    code                       VARCHAR2(255) NOT NULL,
    report_date                DATE NOT NULL,
    population                 NUMBER,
    population_density         NUMBER,
    total_cases                NUMBER,
    total_deaths               NUMBER,
    total_cases_per_mil        NUMBER,
    reproduction_rate          NUMBER,
    icu_patients               NUMBER,
    hosp_patients              NUMBER,
    weekly_hosp_adm            NUMBER,
    people_fully_vacc          NUMBER,
    people_fully_vacc_per_hun  NUMBER,
    positive_rate              NUMBER,
    stringency_index           NUMBER,
    flag_index                 NUMBER(1),

    -- Define Foreign Key Constraints
    CONSTRAINT fk_location FOREIGN KEY (code) REFERENCES Dim_Location(code),
    CONSTRAINT fk_date FOREIGN KEY (report_date) REFERENCES Dim_Date(report_date)
);

--create our sequence for our facts table primary key
CREATE SEQUENCE fact_id_seq START WITH 1 INCREMENT BY 1;

--Create Indexing for Performance
CREATE INDEX idx_fact_code ON Fact_Resilience(code);

CREATE INDEX idx_fact_date ON Fact_Resilience(report_date);

-- *************************** ------
--Populate the Loaction Dimenstion table

INSERT INTO Dim_Location (country, code, continent)
SELECT DISTINCT country, code, continent
FROM GLOBAL_RESILIENCE;

COMMIT;

SELECT *
FROM DIM_LOCATION;


--populate the Date Dimension table

INSERT INTO Dim_Date (report_date)
SELECT DISTINCT report_date
FROM GLOBAL_RESILIENCE;

-- Use EXTRACT for the YEARLY column as a Number Data type
UPDATE Dim_Date
SET yearly = EXTRACT(YEAR FROM report_date);

-- Populate the month and quarterly date clumns using TO_CHAR function
UPDATE Dim_Date
SET month_name = TRIM(TO_CHAR(report_date, 'Month')),
    quarterly  = 'Q' || TO_CHAR(report_date, 'Q');

COMMIT;

SELECT *
FROM Dim_Date;

--populate the facts table

INSERT INTO Fact_Resilience (
fact_id,
code,
report_date,
population,
population_density,
total_cases,
total_deaths,
total_cases_per_mil,
reproduction_rate,
icu_patients,
hosp_patients,
weekly_hosp_adm,
people_fully_vacc,
people_fully_vacc_per_hun,
positive_rate,
stringency_index,
flag_index
    
)
SELECT 
    fact_id_seq.NEXTVAL, -- This generates the ID automatically
 code,
report_date,
population,
population_density,
total_cases,
total_deaths,
total_cases_per_mil,
reproduction_rate,
icu_patients,
hosp_patients,
weekly_hosp_adm,
people_fully_vacc,
people_fully_vacc_per_hun,
positive_rate,
stringency_index,
flag_index
FROM GLOBAL_RESILIENCE;

COMMIT;
-----****************** END OF DATA MODELLING ****--------


--- **** TASK 2 AND TASK 3 (EDA) **** -----------

-- KPI 1: CASE FATALITY RATE (CFR)
-- Multiplied by 100 to get percentage; NULLIF prevents division by zero

CREATE VIEW vw_FATALITY_RATE AS
SELECT 
     l.code,l.country, l.continent, 
    d.report_date, d.month_name, d.yearly,
    ROUND((f.total_deaths / NULLIF(f.total_cases, 0)) * 100, 2) AS FATALITY_RATE,
     f.flag_index
FROM Fact_Resilience f
JOIN Dim_Location l ON f.code = l.code
JOIN Dim_Date d ON f.report_date = d.report_date
WHERE f.total_cases >= f.total_deaths AND f.total_cases > 1;


SELECT 
    country, 
    continent, 
    -- Average rate helps identify the typical severity in that country
    ROUND(AVG(FATALITY_RATE), 2) as avg_fatality_rate,
    -- Max rate identifies the highest point of risk during the outbreak
    ROUND(MAX(FATALITY_RATE), 2) as peak_fatality_rate,
    -- Count helps you see how much data is backing this country's metric
    COUNT(report_date) as days_recorded
FROM vw_fatality_rate
GROUP BY country, continent
HAVING MAX(FATALITY_RATE) >= 100
ORDER BY avg_fatality_rate DESC;


-- KPI 2: Healthcare Pressure Index

CREATE VIEW vw_healthcare_pressure AS
SELECT 
    l.code, l.country, l.continent, 
    d.report_date, d.month_name, d.yearly,
    (NVL(f.icu_patients, 0) + NVL(f.hosp_patients, 0)) AS pressure_index,
    f.flag_index
FROM Fact_Resilience f
JOIN Dim_Location l ON f.code = l.code
JOIN Dim_Date d ON f.report_date = d.report_date;

SELECT *
FROM vw_healthcare_pressure
;


SELECT *
FROM VW_HEALTHCARE_PRESSURE;


SELECT 
    country, 
    continent, 
    
    ROUND(AVG(PRESSURE_INDEX), 2) as AVG_PRESSURE_INDEX,
    
    ROUND(MAX(PRESSURE_INDEX), 2) as PEAK_PRESSURE_INDEX,
  
    COUNT(report_date) as days_recorded
FROM VW_HEALTHCARE_PRESSURE
GROUP BY country, continent
ORDER BY AVG_PRESSURE_INDEX DESC;

COMMIT;

--KPI 3 Reproduction Rate (Speed of Spread)

CREATE VIEW vw_reproduction_rate AS
SELECT 
    l.code, l.country, l.continent, 
    d.report_date, d.month_name, d.yearly,
    f.reproduction_rate,f.flag_index
FROM Fact_Resilience f
JOIN Dim_Location l ON f.code = l.code
JOIN Dim_Date d ON f.report_date = d.report_date;

--KPI 4 Vaccination Rate

CREATE VIEW vw_vaccination_rate AS
SELECT 
    l.code, l.country, l.continent, 
    d.report_date, d.month_name, d.yearly,
    ROUND((f.people_fully_vacc / NULLIF(f.population, 0)) * 100, 2) AS vax_rate_pct,
    f.flag_index
FROM Fact_Resilience f
JOIN Dim_Location l ON f.code = l.code
JOIN Dim_Date d ON f.report_date = d.report_date;

SELECT DISTINCT CONTINENT
FROM vw_vaccination_rate
WHERE VAX_RATE_PCT IS NULL;


-- KPI 5 Positivity Rate

CREATE VIEW vw_positivity_rate AS
SELECT 
    l.code, l.country, l.continent, 
    d.report_date, d.month_name, d.yearly,
    f.positive_rate, f.flag_index
FROM Fact_Resilience f
JOIN Dim_Location l ON f.code = l.code
JOIN Dim_Date d ON f.report_date = d.report_date;

-- KPI 6 Weekly Hospital Admission Surge Rate

CREATE VIEW vw_hosp_surge AS
SELECT 
    l.code, l.country, l.continent, 
    d.report_date, d.month_name, d.yearly,
    ROUND(((f.weekly_hosp_adm - LAG(f.weekly_hosp_adm) OVER (PARTITION BY f.code ORDER BY f.report_date)) 
    / NULLIF(LAG(f.weekly_hosp_adm) OVER (PARTITION BY f.code ORDER BY f.report_date), 0)) * 100, 2) AS surge_rate_pct,
    f.flag_index
FROM Fact_Resilience f
JOIN Dim_Location l ON f.code = l.code
JOIN Dim_Date d ON f.report_date = d.report_date;


-- KPI 7 Government Response (Stringency Index)

CREATE VIEW vw_stringency AS
SELECT 
    l.code, l.country, l.continent, 
    d.report_date, d.month_name, d.yearly,
    f.stringency_index, f.flag_index
FROM Fact_Resilience f
JOIN Dim_Location l ON f.code = l.code
JOIN Dim_Date d ON f.report_date = d.report_date;

--KPI 8 Population Density Risk Score

CREATE VIEW vw_density_risk AS
SELECT 
    l.code, l.country, l.continent, 
    d.report_date, d.month_name, d.yearly,
    ROUND(f.population_density * f.total_cases_per_mil, 2) AS risk_score,
    f.flag_index
FROM Fact_Resilience f
JOIN Dim_Location l ON f.code = l.code
JOIN Dim_Date d ON f.report_date = d.report_date;

SELECT *
FROM vw_density_risk;

--KPI 9 Vaccine Equity Gap

CREATE VIEW vw_equity_gap AS
SELECT 
    l.code, l.country, l.continent, 
    d.report_date, d.month_name, d.yearly,
    ROUND(MAX(f.people_fully_vacc_per_hun) OVER (PARTITION BY f.report_date) - 
    f.people_fully_vacc_per_hun, 2) AS equity_gap_points,
    f.flag_index
FROM Fact_Resilience f
JOIN Dim_Location l ON f.code = l.code
JOIN Dim_Date d ON f.report_date = d.report_date;

COMMIT;

select distinct continent
from global_resilience;