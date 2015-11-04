# 3. Calculate the number of MVPs and Triple Crown winners by team ever in major league baseball.

SELECT teamID , COUNT(awardID)
FROM AwardsPlayers
JOIN Batting
ON AwardsPlayers.playerID = Batting.playerID and AwardsPlayers.yearID = Batting.yearID
Where awardID = "Triple Crown" or awardID = "MVP"
GROUP BY teamID
ORDER BY COUNT(*) DESC