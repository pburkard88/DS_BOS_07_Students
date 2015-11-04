# Assignment 01, question 2
# Calc num. of MVP and Triple Crown winners by position ever in MLB.

SELECT f.POS, COUNT(a.awardID="MVP" OR a.awardID="Triple Crown") AS Awards 
FROM AwardsPlayers As a INNER JOIN
Fielding AS f ON a.playerID=f.playerID
GROUP BY f.pos