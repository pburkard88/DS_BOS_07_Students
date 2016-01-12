# Assignment 01, question 3
# Calc num. of MVP and Triple Crown winners by team in MLB.

SELECT ALlstarFull.teamID, COUNT(*) AS count
FROM AwardsPlayers INNER JOIN AllstarFull 
ON AwardsPlayers.playerID=AllstarFull.playerID
AND AwardsPlayers.yearID=AllstarFull.yearID
WHERE AwardsPlayers.awardID="MVP" OR
AwardsPlayers.awardID="Triple Crown"
GROUP BY AllstarFull.teamID
ORDER BY AllstarFull.teamID DESC
