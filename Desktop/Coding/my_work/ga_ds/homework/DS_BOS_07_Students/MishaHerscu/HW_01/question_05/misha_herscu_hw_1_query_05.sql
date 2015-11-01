SELECT
g.Gold_Glove_Count,
m.MVP_Count,
master.*
 FROM (
	SELECT 
	playerID,
	COUNT(yearID) AS Gold_Glove_Count
	FROM baseball.awardsplayers
	WHERE awardID = 'Gold Glove'
	GROUP BY playerID, awardID
    ) g
INNER JOIN (    
	SELECT 
	playerID,
	COUNT(yearID) AS MVP_COUNT
	FROM baseball.awardsplayers
	WHERE awardID = 'MVP'
	GROUP BY playerID, awardID
    ) m ON g.playerID = m.playerID
INNER JOIN baseball.master master ON master.playerID = m.playerID