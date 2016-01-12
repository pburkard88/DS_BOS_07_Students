select f.POS, COUNT(a.awardID) AS awards 
FROM fielding f INNER JOIN awardsplayers a 
WHERE a.playerID = f.playerID 
	AND a.yearID = f.yearID
	AND (a.awardID = 'Triple Crown' OR a.awardID = 'MVP')
GROUP BY POS DESC
