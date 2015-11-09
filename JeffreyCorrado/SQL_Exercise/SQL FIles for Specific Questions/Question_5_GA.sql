SELECT Masters.*, COUNT(AwardsPlayers.awardID = 'MVP') as 'MVPWon', COUNT (AwardsPlayers.awardID = 'Gold Glove') as 'GGWon'
FROM AwardsPlayers INNER JOIN Masters ON AwardsPlayers.playerID = Masters.playerID
INNER JOIN Batting ON AwardsPlayers.playerID = Batting.playerID AND AwardsPlayers.yearID = Batting.yearID
INNER JOIN AwardsPlayers ON AwardsPlayers.playerID = AwardsPlayers.awardID
WHERE AwardsPlayers.awardID = 'MVP' OR AwardsPlayers.awardID = 'Gold Glove'
GROUP BY Masters.nameLast 