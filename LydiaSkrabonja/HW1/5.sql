SELECT a.playerID, COUNT(CASE WHEN awardID = 'Gold Glove' THEN 1 END) AS Golden_Gloves, COUNT(CASE WHEN awardID = 'MVP' THEN 1 END) AS MVPs, m.*
FROM AwardsPlayers AS a, Master AS m
WHERE a.playerID = m.playerID  
GROUP BY a.playerID
HAVING Golden_Gloves >= 1 AND MVPs >= 1;