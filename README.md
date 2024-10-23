# Layoffs Data Analysis Project

## Project Overview
This project involves the exploratory data analysis (EDA) of layoffs data to identify trends, outliers, and key insights about the dataset. The analysis focuses on various dimensions like company, industry, country, and time (year/month).

### Key Objectives:
- Summarize total layoffs by company, industry, and country.
- Analyze trends over time (year and month).
- Detect outliers and extreme values.
- Rank companies by total layoffs for each year.

## Dataset:
The dataset used in this project contains information on layoffs across various companies, industries, and countries. Key columns include:
- `company`: Name of the company.
- `industry`: Sector the company operates in.
- `total_laid_off`: Number of employees laid off.
- `percentage_laid_off`: Percentage of the workforce laid off.
- `date`: The date when layoffs occurred.
- `stage`: Funding stage of the company (e.g., startup, growth).

## Steps in the Analysis:
1. **Data Preview**: Load and inspect the dataset to understand its structure.
2. **Data Cleaning**: Standardize fields (e.g., company names) and handle missing or null values.
3. **Outlier Detection**: Identify unusually high or low values in the `total_laid_off` column.
4. **Trend Analysis**: Analyze layoffs by time (year, month) and identify peak periods.
5. **Summary Statistics**: Aggregate layoffs by company, industry, and country.
6. **Company Ranking**: Rank companies by the number of layoffs.
