SELECT POS as Position, COUNT(CASE WHEN awardID='Triple Crown' THEN 1 END) AS Triple_Crowns, COUNT(CASE WHEN awardID='MVP' THEN 1 END) AS MVPs
FROM AwardsPlayers AS a JOIN Fielding AS f ON a.playerID = f.playerID
GROUP BY POS;