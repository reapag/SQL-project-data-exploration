-- ========================================================================
-- Exploratory Data Analysis Script for 'layoffs' Table
-- ========================================================================

-- 1. Preview the full dataset

SELECT 
	*
FROM 
	layoffs_staging;

-- 2. Check for maximum values in the layoffs columns to understand upper bounds

SELECT 
	MAX(total_laid_off),
	MAX(percentage_laid_off)
FROM 
	layoffs_staging;

-- 3. Analyze records with 100% layoffs and sort by highest total layoffs

SELECT 
	*
FROM 
	layoffs_staging
WHERE
	percentage_laid_off = 1
ORDER BY
	4 DESC, 1;
	
-- 4. Sum total layoffs by company and rank in descending order.

SELECT 
	company, SUM(total_laid_off)
FROM 
	layoffs_staging
GROUP BY 
	company
ORDER BY
	2 DESC NULLS LAST;

-- 5. Find the date range of the layoffs data

SELECT 
	MIN(date), MAX(date)
FROM 
	layoffs_staging;	
	
-- 6. Sum total layoffs by industry and rank in descending order

SELECT 
	industry, 
	SUM(total_laid_off)
FROM 
	layoffs_staging
GROUP BY
	industry
ORDER BY 
	2 DESC NULLS LAST;	

-- 7. Sum total layoffs by country and rank in descending order

SELECT 
	country, 
	SUM(total_laid_off)
FROM 
	layoffs_staging
GROUP BY
	country
ORDER BY 
	2 DESC NULLS LAST;

-- 8. Aggregate total layoffs by year and rank by the year

SELECT 
	EXTRACT (YEAR FROM date) AS year, 
	SUM(total_laid_off)
FROM 
	layoffs_staging
GROUP BY
	EXTRACT (YEAR FROM date)
ORDER BY 
	1 DESC NULLS LAST;

-- 9. Analyze layoffs based on company funding stage

SELECT 
	stage,
	SUM(total_laid_off)
FROM 
	layoffs_staging
GROUP BY
	stage
ORDER BY 
	2 DESC NULLS LAST;

-- 10. Distribution of layoffs by month (Year-Month format) with rolling total

SELECT 
	TO_CHAR(date, 'YYYY-MM') AS year_month,
	SUM(total_laid_off) AS total_laid_off_month,
	SUM(SUM(total_laid_off)) OVER (ORDER BY TO_CHAR(date, 'YYYY-MM')) AS rolling_total
FROM 
	layoffs_staging
GROUP BY
	year_month
ORDER BY
	year_month;

-- 11. Analyze layoffs by company and year

SELECT 
	company,
	EXTRACT (YEAR FROM date) AS years,
	SUM(total_laid_off)
FROM 
	layoffs_staging
GROUP BY 
	company,
	year;

-- 12. Rank companies by total layoffs per year (Top 5 companies)

WITH company_year_cte AS
(
	SELECT 
		company,
		EXTRACT (YEAR FROM date) AS year,
		SUM(total_laid_off)
	FROM 
		layoffs_staging
	GROUP BY 
		company,
		year
),
company_year_rank_cte AS
(
	SELECT 
		company,
		year,
		total_laid_off,
		DENSE_RANK() OVER (PARTITION BY year ORDER BY total_laid_off DESC) AS rank
	FROM
		company_year_cte
	WHERE
		total_laid_off IS NOT NULL
		AND years IS NOT NULL
)
SELECT
	*
FROM
	company_year_rank_cte
WHERE
	rank <= 5;

-- 13. Detect outliers using the 3-standard deviation rule (could be refined)

SELECT
	*
FROM 
    layoffs_staging
WHERE 
	total_laid_off > (SELECT AVG(total_laid_off) + 3 * STDDEV(total_laid_off) FROM layoffs_staging)
	OR total_laid_off < (SELECT AVG(total_laid_off) - 3 * STDDEV(total_laid_off) FROM layoffs);


-- ========================================================================
-- -- End of Exploratory Data Analysis Script
-- ========================================================================
