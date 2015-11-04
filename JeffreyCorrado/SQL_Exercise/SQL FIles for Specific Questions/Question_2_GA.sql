SELECT Fielding.POS, AwardsPlayers.awardID, Count(*) as "POSWins"
FROM AwardsPlayers INNER JOIN Fielding ON AwardsPlayers.playerID = Fielding.playerID AND AwardsPlayers.yearID = Fielding.yearID
WHERE AwardsPlayers.awardID = 'Triple Crown' or AwardsPlayers.awardID = 'MVP' AND Fielding.G > 100
GROUP BY AwardsPlayers.awardID, Fielding.POS, "POSWins" DESC
