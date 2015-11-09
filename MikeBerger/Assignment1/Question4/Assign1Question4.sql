SELECT AVG(Batting.G),AVG(Batting.RBI),AVG(Batting.HR), Fielding.POS, Count(*)
FROM Batting
Join Fielding where Batting.playerID = Fielding.playerId AND Batting.yearID = Fielding.yearID
AND Batting.AB > 300
Group By Fielding.POS