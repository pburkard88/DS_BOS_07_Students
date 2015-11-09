SELECT *,
   100 * salary/average_player_salary
FROM
(SELECT AwardsPlayers.playerID,
   AwardsPlayers.AwardID,
    Salaries.yearID,
    Salaries.salary
FROM AwardsPlayers
JOIN Salaries
ON AwardsPlayers.playerID = Salaries.playerID
AND AwardsPlayers.yearID = Salaries.yearID
WHERE AwardsPlayers.AwardID = 'MVP') as MVPsalary
JOIN
(SELECT yearID, AVG(salary) as average_player_salary
FROM
Salaries
GROUP BY yearID) as avg_salary
ON avg_salary.yearID = MVPsalary.yearID