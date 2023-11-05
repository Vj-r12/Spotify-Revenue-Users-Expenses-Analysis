-- PROMPTING SPOTIFY INFO TABLE.

CREATE TABLE SPOTIFY_INFO (
	                        Date date,
	                        TOTAL_REVENUE bigint,
	                        COST_OF_REVENUE bigint, 
	                        GROSS_PROFIT bigint,
	                        PREMIUM_REVENUE bigint,
	                        PREMIUM_COST_REVENUE bigint,
	                        PREMIUM_GROSS_PROFIT bigint,
	                        AD_REVENUE bigint, 
	                        AD_COST_OF_REVENUE bigint,
	                        AD_GROSS_PROFIT varchar, 
	                        MONTHLY_ACTIVE_USERS bigint,
	                        PREMIUM_MONTHLY_ACTIVE_USERS bigint, 
	                        AD_MONTHLY_ACTIVE_USERS bigint, 
	                        PREMIUM_AVG_REVENUE_PER_USER float,
	                        SALES_MARKETING_COST bigint,
	                        RESEARCH_DEVELOPMENT_COST bigint, 
	                        GENERAL_ADMINSTRATIVE_COST bigint,
	                        NET_PROFIT BIGINT
                           );	

/*****     NOTE     *****/    				   

-- Additonally Added One Column For Net Profit.

-- Here is a query of altering a table.

ALTER TABLE SPOTIFY_INFO ADD COLUMN NET_PROFIT bigint;