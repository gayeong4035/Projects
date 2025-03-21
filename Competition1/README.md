# Competition 1
## Flu Shot Learning - Predict H1N1 and Seasonal Flu Vaccines

## Project Overview
This project is part of **[DrivenData Flu Shot Learning - Predict H1N1 and Seasonal Flu Vaccines]**.
The goal is to predict the likelihood of individuals receiving H1N1 and Seasonal flu vaccines based on demographic and behavioral data.

## Tech Stack
- Python
- Progressing
- Modeling
- Evaluation
- Submission: creating submission.csv for DrivenData

## Results
- Overall Model Performance: Achieved a ROC AUC 0.8317, demonstrating a competitive model.

## Project Structures
- Competition1: Main folder for Flu Shot Learning competition
- Data: Stores processed data & final submission (`submission.csv`)
- Scripts: Contains Python script for model training & prediction (`flu_shot_model.py`)
- README.md: Project documentation

## Model Training & Prediction Pipeline
1. Data Processing
- Handled missing values (median for numerical, mode/Unknown for categorical)
- Applied one-hot encoding and ensured feature alignment

2. Model Training
- Trained Random Forest Classifier (`n_estimators=100`)
- Two models:
  - `model_h1n1` → Predicts H1N1 vaccine uptake
  - `model_seasonal` → Predicts Seasonal flu vaccine uptake

3. Prediction & Evaluation
- Evaluated using ROC AUC
- Final Score: 0.8317

4. Final Submission
- Created `submission.csv` with model predictions

## Key Insights
- Handling missing data improved performance (median/mode strategy)
- One-hot encoding & feature alignment were crucial for consistency
- Demographic & health-related factors strongly influenced vaccine uptake
- Random Forest provided solid results with minimul tuning (ROC AUC '0.8317')









