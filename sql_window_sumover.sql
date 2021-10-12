SET search_path = 'dbcamp_tableau';

SELECT 
	region,
    country,
	SUM(gdp) AS country_gdp,
	-- Calculate the global gdp
    SUM(SUM(gdp)) OVER() AS global_gdp,
	SUM(gdp) / SUM(SUM(gdp)) OVER() AS perc_global_gdp,
	 SUM(SUM(gdp)) OVER(PARTITION BY region) AS region_gdp,
	SUM(gdp) / SUM(SUM(gdp)) OVER(PARTITION BY region) AS perc_region_gdp
FROM country_stats AS cs
JOIN countries AS c
ON cs.country_id = c.id
-- Filter out null gdp values
WHERE gdp IS NOT NULL
GROUP BY region, country
-- Show the highest country_gdp at the top
ORDER BY country_gdp DESC
