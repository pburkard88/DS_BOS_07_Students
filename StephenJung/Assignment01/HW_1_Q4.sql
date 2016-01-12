# Assignment 01, question 4
# Calc states and consider seasons where player had at least 300 AB

SELECT f.pos, AVG(b.h/b.AB) AS avg_AVG, AVG(b.RBI) AS avg_RBI,
AVG(b.HR) AS avg_HR
FROM BattingPost AS bp INNER JOIN AwardsPlayers AS a
INNER JOIN Fielding as f INNER JOIN Batting as b
ON bp.playerID=b.playerID AND bp.playerID=a.playerID AND
bp.playerID=f.playerID AND bp.yearID=a.yearID AND
bp.yearID=f.yearID AND bp.yearID=b.yearID
WHERE (bp.AB+b.AB)>300
GROUP BY f.POS