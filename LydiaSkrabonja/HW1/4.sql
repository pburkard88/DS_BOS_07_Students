SELECT POS as Position, AVG(H/AB) AS BA, AVG(RBI), AVG(HR)
FROM Fielding AS f JOIN Batting as b
ON f.playerID = b.playerID
WHERE b.AB >= 300
GROUP BY f.POS;