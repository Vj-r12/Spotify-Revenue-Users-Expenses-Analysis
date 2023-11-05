/*****     SPOTIFY REVENUE, USERS & EXPENSES ANALYSIS     *****/


/**   SPOTIFY REVENUE ANALYSIS   **/    


-- Fetch the data from Spotify Revenue, Expenses & Premium Users Analysis.

SELECT *
FROM SPOTIFY_INFO;

-- Find the year in which the highest revenue was recorded.

SELECT EXTRACT(YEAR FROM date) AS YEAR,
	SUM(TOTAL_REVENUE) AS TOTAL_REVENUE
FROM SPOTIFY_INFO
GROUP BY YEAR
ORDER BY TOTAL_REVENUE DESC;

-- Find the year & quarter in which quarter the highest revenue was recorded.

SELECT X.Date,TOTAL_REVENUE,QTR,RANK
FROM
	(
	SELECT date,
	   CASE
       WHEN EXTRACT(MONTH FROM date) BETWEEN 01 AND 03 THEN 'Qtr1'
	   WHEN EXTRACT(MONTH FROM date) BETWEEN 03 AND 06 THEN 'Qtr2'
	   WHEN EXTRACT(MONTH FROM date) BETWEEN 06 AND 09 THEN 'Qtr3'
	   WHEN EXTRACT(MONTH FROM date) BETWEEN 09 AND 12 THEN 'Qtr4'
	 END AS QTR,
	 TOTAL_REVENUE,
	 RANK() OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY TOTAL_REVENUE DESC) AS Rank
	 FROM SPOTIFY_INFO
	) X
WHERE X.Rank = 1;

/* Retrieve the cost of revenue, organize it by specific years, and identify the quarter in which the
highest cost of revenue was incurred. Additionally, rank the data by quarter under particular years. */

SELECT Date,COST_OF_REVENUE,
	RANK() OVER (PARTITION BY EXTRACT(YEAR FROM date)
    ORDER BY COST_OF_REVENUE DESC) AS RANK_BY_COST_OF_REVENUE          
FROM SPOTIFY_INFO;

-- Find the Highest Gross Profit By Years.

SELECT EXTRACT(YEAR FROM date) AS YEARS,
	SUM(GROSS_PROFIT) AS TOTAL
FROM SPOTIFY_INFO
GROUP BY YEARS
ORDER BY TOTAL DESC;

/* Find the highest gross profit of premium by year, arrange the gross profit in quarters, 
   & calculate the total premium amount for the year. */

WITH CTE AS
	(
		SELECT DATE,EXTRACT(YEAR FROM date) AS YEARS,
			   PREMIUM_GROSS_PROFIT 
		FROM SPOTIFY_INFO
		GROUP BY DATE,YEARS,PREMIUM_GROSS_PROFIT
	)
SELECT DATE,PREMIUM_GROSS_PROFIT,
	RANK () OVER (PARTITION BY YEARS ORDER BY PREMIUM_GROSS_PROFIT DESC) AS Rank_BY_GROSS_PROFIT,
	SUM(PREMIUM_GROSS_PROFIT) OVER (PARTITION BY YEARS) AS TOTAL_GROSS_PROFIT_OF_YEAR
FROM CTE;

-- Fetch the ad gross profit and calculate the ad gross profit for the particular years and sort by years.

SELECT EXTRACT(YEAR FROM date) AS YEARS,
	SUM(AD_GROSS_PROFIT) AS AD_GROSS_PROFIT
FROM SPOTIFY_INFO
GROUP BY YEARS
ORDER BY YEARS;

-- Fetch the Net Profit and Calculate the Net profit for the particular years.

SELECT EXTRACT(YEAR FROM date) AS YEARS,
	SUM(NET_PROFIT) as NET_PROFIT
FROM SPOTIFY_INFO YEARS
GROUP BY YEARS
ORDER BY YEARS;


/**   SPOTIFY USERS ANALYSIS   **/


-- Calculate the Monthly active users for per quarter & per year. 

SELECT date,MONTHLY_ACTIVE_USERS,
	SUM(MONTHLY_ACTIVE_USERS) OVER (PARTITION BY EXTRACT(YEAR FROM date)) AS SUM_OF_MONTHLY_ACTIVE_USERS_PER_YEAR
FROM SPOTIFY_INFO;

-- Retrieve the total number of monthly active users by ad for each year.

SELECT EXTRACT(YEAR FROM date) AS YEARS,
	SUM(AD_MONTHLY_ACTIVE_USERS) AS AD_MONTHLY_ACTIVE_USERS
FROM SPOTIFY_INFO
GROUP BY YEARS
ORDER BY YEARS; 

-- Retrieve the total number of monthly active users by premium for each year.

SELECT EXTRACT(YEAR FROM date) AS YEARS,
	SUM(PREMIUM_MONTHLY_ACTIVE_USERS) AS AD_MONTHLY_ACTIVE_USERS
FROM SPOTIFY_INFO
GROUP BY YEARS
ORDER BY YEARS;

-- Fetch the premium avg revenue per users (ARPU) According to Quarters belong to their year.

WITH CTE AS
	        (
		      SELECT EXTRACT(YEAR FROM date) AS YEARS,PREMIUM_AVG_REVENUE_PER_USER,
			  RANK() OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY EXTRACT(MONTH FROM date)), 
			  CASE
                  WHEN EXTRACT(MONTH FROM date) BETWEEN 01 AND 03 THEN 'Qtr1'
                  WHEN EXTRACT(MONTH FROM date) BETWEEN 03 AND 06 THEN 'Qtr2'
                  WHEN EXTRACT(MONTH FROM date) BETWEEN 06 AND 09 THEN 'Qtr3'
                  WHEN EXTRACT(MONTH FROM date) BETWEEN 09 AND 12 THEN 'Qtr4'
                  END AS QUARTERS
		      FROM SPOTIFY_INFO
			)
SELECT YEARS,QUARTERS,
	PREMIUM_AVG_REVENUE_PER_USER
FROM CTE;


/**   SPOTIFY EXPENSES ANALYSIS   **/  


-- Retrieve the sales and marketing costs for each year. 

SELECT EXTRACT(YEAR FROM date) AS YEARS,
	SUM(SALES_MARKETING_COST)
FROM SPOTIFY_INFO
GROUP BY YEARS
ORDER BY YEARS; 

-- Retrieve the research development costs for each year.

SELECT EXTRACT(YEAR FROM date) AS YEARS,
	SUM(RESEARCH_DEVELOPMENT_COST)
FROM SPOTIFY_INFO
GROUP BY YEARS
ORDER BY YEARS;

-- Retrieve the general adminstrative costs for each year. 

SELECT EXTRACT(YEAR FROM date) AS YEARS,
	SUM(GENERAL_ADMINSTRATIVE_COST)
FROM SPOTIFY_INFO
GROUP BY YEARS
ORDER BY YEARS;