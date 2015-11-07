SELECT a.yearID, a.playerID, a.awardID, (b.H / b.AB) AS "AVG", b.RBI, b.HR 
FROM baseball.awardsplayers a, baseball.batting b 
WHERE b.yearID = a.yearID
	AND b.playerID = a.playerID
	AND a.awardID = 'Triple Crown'
    GROUP BY AVG DESC
	


