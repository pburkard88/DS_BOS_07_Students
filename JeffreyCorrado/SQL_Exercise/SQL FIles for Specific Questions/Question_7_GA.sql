SELECT AVG(Salaries.Salary) 
FROM Salaries INNER JOIN AwardsPlayers ON Salaries.playerID = AwardsPlayers.playerID
WHERE AwardsPlayers.awardID = 'MVP'
