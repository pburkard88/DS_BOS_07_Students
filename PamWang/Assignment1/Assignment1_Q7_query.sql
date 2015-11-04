SELECT Salaries.playerID, Salaries.yearID, Salaries.salary, AVG(salary), Salaries.salary/AVG(salary)*100 as percent
FROM Salaries, AwardsPlayers WHERE awardID = 'MVP'
GROUP BY Salaries.yearID