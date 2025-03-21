# SAS Titanic Data Project
## Project Overview
This project explores the Titanic dataset using SAS to analyze passenger survival patterns. The focus is on data cleaning, formatting, and generating summary statistics through SQL and DATA step procedures.

## Tech Stack
- SAS (Base SAS, SAS Studio - ODA)
- DATA Processing (`PROC IMPORT`, `PROC CONTENTS`, conditional logic)
- Statistical Analysis (`PROC SQL`, aggregations, calculated fields)
- Output & Formatting (`PROC PRINT`, `PROC FORMAT`)
- Error Handling (Handling missing/invalid values in data)

## Project Structures
- `SAS_Titanic_Data_Project.sas`: Main script
- `SAS_Titanic_Data_Project.pdf`: Output and results
- `titanic.csv`: titanic dataset used for analysis (instructor-provided)
- `README.md`: Project documentation

## Analysis Pipeline
**Data Preparation**
- Imported Titanic dataset into SAS
- Sotred permanent dataset in SAS library

**Exploratory Analysis**
- Summarized total observations and variable metadata
- Counted numeric vs. character variables

**Formatting & Transformation**
- Created custom formats for `PClass` and `Embarked`
- Labeled categorical variables for readability

**Class-Based Survival Analysis**
- Calculated death counts by class
- Computed death rated per 1,000 passengers using `PROC SQL`

**Additional Processing**
- Derived new variables from `SASHELP.CLASS`
- Handled invalid data without triggering SAS errors

## Key Insights
- First-class passengers had the highest survival rate, while third-class had the most fatalities
- Death rate analysis revealed clear socio-economic disparities
- Higher passenger class correlated with higher survival rate
- Custom formatting improve intepretability of results
- Clean error handling ensured smooth execution and output export
- `PROC SQL` and `Data Step` integration provided efficient summary reporting 
