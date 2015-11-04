select f.POS, (b.H/b.AB) AS AVG, b.HR, b.RBI  
FROM fielding f INNER JOIN batting b 
	ON f.yearID = b.yearID
    AND f.playerID = b.playerID
    AND f.teamID = b.teamID
	WHERE AB > 300
    