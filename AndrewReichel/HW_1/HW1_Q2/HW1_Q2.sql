#2. Calculate the number of MVPs and Triple Crown winners by position ever in major league baseball.

SELECT POS, COUNT(*) AS count
FROM Fielding
JOIN AwardsPlayers
ON Fielding.playerID = AwardsPlayers.playerID and Fielding.yearID = AwardsPlayers.yearID	
WHERE awardID = "MVP" or awardID = "Triple Crown"
GROUP BY POS
ORDER BY COUNT(*)