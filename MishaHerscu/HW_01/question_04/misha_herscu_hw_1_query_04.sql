SELECT 
	f.pos,
    AVG(b.H/b.AB) AS avg_batting_average,
    AVG(b.RBI) AS avg_RBI,
    AVG(b.HR) AS avg_HR
FROM baseball.batting b, baseball.fielding f
WHERE f.playerID = b.playerID
AND f.yearID = b.yearID
AND b.AB >= 300
GROUP BY f.pos
ORDER BY AVG(b.H/b.AB) DESC, AVG(b.RBI) DESC, AVG(b.HR) DESC