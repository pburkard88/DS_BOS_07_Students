# Assignment 01, question 5
# Return player info for MVP and Gold Glove winners

SELECT a.playerID, AVG(b.RBI), SUM(a.awardID="MVP" 
OR a.awardID="Gold Glove") AS Total_Awards
FROM AwardsPlayers AS a INNER JOIN Batting as b INNER JOIN
BattingPost AS bp INNER JOIN
Fielding AS f INNER JOIN FieldingPost AS fp ON
a.playerID=b.playerID AND a.playerID=bp.playerID AND
a.playerID=f.playerID AND a.playerID=fp.playerID AND
a.yearID=b.yearID AND a.yearID=bp.yearID AND a.yearID=f.yearID
AND a.yearID=fp.yearID
WHERE a.awardID="Gold Glove" OR a.awardID="MVP"
GROUP BY a.playerID
ORDER BY Total_Awards DESC
