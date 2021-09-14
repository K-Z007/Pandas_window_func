SET search_path = 'dbcamp_tableau';

WITH sub AS (
	SELECT
		-- Query region, athlete_name, and total gold medals
		region, 
		name AS athlete_name, 
		SUM(gold) AS total_golds,
		-- name AS athlete_name, 
		ROW_NUMBER() OVER(PARTITION BY region ORDER BY SUM(gold) DESC) AS row_num
	FROM summer_games AS s
	JOIN athletes AS a
	ON s.athlete_id = a.id
	JOIN countries AS c
	ON s.country_id = c.id
	WHERE gold IS NOT NULL
	GROUP BY 1, 2
)
SELECT 
	*
FROM sub
WHERE row_num = 1



