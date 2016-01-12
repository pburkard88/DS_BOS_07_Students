SELECT teamID, COUNT(*) as numAwards
FROM AwardsPlayers
JOIN Fielding
ON AwardsPlayers.playerID = Fielding.playerID
AND AwardsPlayers.yearID = Fielding.yearID
WHERE AwardsPlayers.AwardID = 'Triple Crown'
OR AwardsPlayers.AwardID = 'MVP'
GROUP BY Fielding.TeamID