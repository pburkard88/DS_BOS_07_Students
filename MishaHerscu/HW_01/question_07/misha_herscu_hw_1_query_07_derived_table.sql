SELECT
	ave.yearID,
	ave.MVP,
	CAST( 100 * (s.salary/ave.average_salary) AS CHAR(4)) + '%' AS MVP_Salary,
	s.salary,
	ave.average_salary
	FROM (
		SELECT
		a.yearID,
		ap.playerID AS MVP,
		a.average_salary
		FROM (
			SELECT
			yearID,
			CAST(AVG(salary) AS DECIMAL(16,2)) AS average_salary 
			FROM salaries
			GROUP BY yearID
			ORDER BY yearID ASC ) a
		INNER JOIN (
			SELECT
			yearID,
			playerID
			FROM awardsplayers 
			WHERE awardID = 'MVP' ) ap ON a.yearID = ap.yearID) ave, salaries s
	WHERE s.yearID = ave.yearID
	AND s.playerID = ave.MVP

