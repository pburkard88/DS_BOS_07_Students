SELECT POS, AVG(H/AB), AVG(RBI), AVG(HR) FROM Batting, Fielding 
WHERE AB >= 300 AND Batting.playerID = Fielding.playerID AND Batting.yearID = Fielding.yearID 
AND Batting.stint = Fielding.stint AND Batting.lgID = Fielding.lgID 
GROUP BY POS