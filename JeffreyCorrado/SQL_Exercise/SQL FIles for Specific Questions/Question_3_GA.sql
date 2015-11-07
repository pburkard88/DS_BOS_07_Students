SELECT Batting.TeamID, AwardsPlayers.awardID, Count(*) as "TeamWins"
FROM AwardsPlayers INNER JOIN Batting ON AwardsPlayers.playerID = Batting.playerID AND AwardsPlayers.yearID = Batting.yearID
WHERE AwardsPlayers.awardID = 'Triple Crown' or AwardsPlayers.awardID = 'MVP' 
GROUP BY AwardsPlayers.awardID, Batting.TeamID, "TeamWins" DESC


