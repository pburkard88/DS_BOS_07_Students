SELECT Fielding.POS, AVG(Batting.RBI), AVG(Batting.HR), AVG(Batting.H / Batting.AB) as "BAVG"
FROM Batting INNER JOIN Fielding ON Batting.playerID = Fielding.playerID 
WHERE Batting.AB > 300
GROUP BY Fielding.POS
