SELECT *, COUNT(*)
FROM AwardsPlayers, Master WHERE AwardsPlayers.playerID = Master.playerID
AND (awardID = 'MVP' OR awardID = 'Gold Glove')
GROUP BY AwardsPlayers.playerID, AwardsPlayers.awardID