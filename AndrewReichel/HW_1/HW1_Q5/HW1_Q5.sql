# 5. Return all player info for all players 
# that won an MVP and a Gold Glove during their 
# careers, along with the number of times they won each.

SELECT * #COUNT(awardID)
FROM AwardsPlayers ap
JOIN Batting b
ON ap.playerID = b.playerID
WHERE ap.awardID = "MVP" or ap.awardID = "Gold Glove"
GROUP BY ap.playerID

#NEED TO COUNT NUM. OF TIMES WON