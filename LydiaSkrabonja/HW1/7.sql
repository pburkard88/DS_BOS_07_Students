SELECT t.yearID, s.playerID, s.salary/yr_avg FROM
(SELECT yearID, AVG(salary) AS yr_avg FROM Salaries GROUP BY yearID) AS t, Salaries AS s, AwardsPlayers AS a
WHERE t.yearID = s.yearID AND s.playerID = a.playerID AND awardID='MVP'
ORDER BY s.playerID, t.yearID;