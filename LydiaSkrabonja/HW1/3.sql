SELECT teamID, COUNT(CASE WHEN awardID='Triple Crown' THEN 1 END) AS Triple_Crowns, COUNT(CASE WHEN awardID='MVP' THEN 1 END) AS MVPs
FROM AwardsPlayers AS aw, Appearances AS ap
WHERE aw.playerID = ap.playerID 
GROUP BY teamID;