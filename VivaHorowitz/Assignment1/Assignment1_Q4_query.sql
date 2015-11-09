SELECT Fielding.Pos,
   AVG(H/AB),
   AVG(RBI),
   AVG(HR)
FROM Batting
JOIN Fielding
ON Batting.playerID = Fielding.playerID
AND Batting.yearID = Fielding.yearID
WHERE Batting.AB > 300
GROUP BY Fielding.Pos