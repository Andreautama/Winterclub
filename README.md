# World Happiness Report 2019 - Linear Regression Analysis

Regression analysis in R using the 2019 World Happiness Report dataset to predict country happiness scores.

---

## Overview

The goal is to figure out which factors best predict a country's happiness score. The analysis covers data cleaning, correlation checks, and fitting a few linear regression models to compare performance.

Data source: [World Happiness Report 2019](https://worldhappiness.report/)

---

## Dataset

| File | Description |
|------|-------------|
| `2019.csv` | World Happiness Report 2019 |

### Variables Used

| Column | Description |
|--------|-------------|
| `Score` | Happiness score (target) |
| `GDP.per.capita` | Economic output per person |
| `Social.support` | Perceived social support |
| `Healthy.life.expectancy` | Healthy life expectancy at birth |
| `Freedom.to.make.life.choices` | Perceived freedom in life decisions |
| `Perceptions.of.corruption` | Perceived corruption level |
| `Generosity` | Generosity index |

---

## Requirements

```r
install.packages("ggplot2")    # plotting
install.packages("reshape2")   # reshape correlation matrix
install.packages("rafalib")    # multi-panel layout
install.packages("Metrics")    # MAE, MSE, RMSE
```

---

## How to Run

1. Download or clone the repo.
2. Put `2019.csv` in your working directory.
3. Run the script:

```r
setwd("path/to/your/project")
source("happiness_analysis.R")
```

---

## Steps

### 1. Data Loading and Inspection
- Load with `read.csv()`
- Check missing values using `colSums(is.na())`
- Check for duplicates
- Check column types with `sapply()`

### 2. Preprocessing
- Select the 7 relevant columns
- Standardize all features with `scale()`

### 3. Exploratory Data Analysis
- Correlation heatmap across all variables
- Sorted correlation table against `Score`
- Scatter plots with regression lines for each feature vs. Score

### 4. Train/Test Split
- 70% train, 30% test
- `set.seed(1)` for reproducibility

### 5. Models

| Model | Predictors |
|-------|-----------|
| Model 1 | All 6 features |
| Model 2 | `GDP.per.capita`, `Healthy.life.expectancy`, `Social.support` |
| Model 3 | `Freedom.to.make.life.choices`, `GDP.per.capita`, `Generosity`, `Healthy.life.expectancy` |

### 6. Evaluation

| Metric | What it measures |
|--------|-----------------|
| MAE | Mean Absolute Error |
| MSE | Mean Squared Error |
| RMSE | Root Mean Squared Error |

### 7. Visualization
- Actual vs. Predicted Score plots for Model 1 and Model 2

---

## Example Output

```
MAE:  0.xxxx
MSE:  0.xxxx
RMSE: 0.xxxx
```

Lower values across all three metrics mean a better fit.

---

## File Structure

```
project/
├── 2019.csv
├── happiness_analysis.R
└── README.md
```

---

## Notes

- Features are z-score scaled before modeling.
- After renaming, columns are sorted alphabetically, so double-check the order before running models.
- `x_train` currently includes `Score` as a predictor column, which should be removed to avoid data leakage.

---

## Author

Written as part of a data analysis exercise on the 2019 World Happiness Report.
