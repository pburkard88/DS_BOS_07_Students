SELECT Batting.playerID, awardID, Count(*) AS Count 
FROM AwardsPlayers
JOIN Batting
ON AwardsPlayers.playerID = Batting.playerID
WHERE awardID = "Triple Crown"#or awardID = "MVP"
