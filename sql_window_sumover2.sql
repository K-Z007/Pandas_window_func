SET search_path = 'dbcamp_tableau';

-- Bring in region, country, and gdp_per_million
SELECT 
	region,
	country,
	SUM(gdp) / SUM(CAST (pop_in_millions AS NUMERIC)) AS gdp_per_million,
	SUM(SUM(gdp)) OVER () / SUM(SUM(CAST(pop_in_millions AS NUMERIC))) OVER() AS gdp_per_million_total,
	(SUM(gdp) / SUM(CAST (pop_in_millions AS NUMERIC))) /
	( SUM(SUM(gdp)) OVER () / SUM(SUM(CAST(pop_in_millions AS NUMERIC))) OVER()) AS performance_index
-- Pull from country_stats_clean
FROM country_stats AS cs
JOIN countries AS c
ON cs.country_id = c.id
-- Filter for 2016 and remove null gdp values
WHERE EXTRACT(YEAR FROM CAST(year AS DATE)) = 2016 AND
		gdp IS NOT NULL
GROUP BY region, country
-- Show highest gdp_per_million at the top
ORDER BY 3 DESC;