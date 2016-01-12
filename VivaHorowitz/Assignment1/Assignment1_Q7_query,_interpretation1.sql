SELECT
   AVG(Salaries.salary )
FROM AwardsPlayers
JOIN Salaries
ON AwardsPlayers.playerID = Salaries.playerID
AND AwardsPlayers.yearID = Salaries.yearID
WHERE AwardsPlayers.AwardID = 'MVP'
GROUP BY NULL