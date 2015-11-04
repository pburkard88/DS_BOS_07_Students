# 5. Return all player info for all players 
# that won an MVP and a Gold Glove during their 
# careers, along with the number of times they won each.

SELECT *, COUNT(awardID)
FROM AwardsPlayers
JOIN Batting
ON AwardsPlayers.playerID = Batting.playerID
WHERE awardID = "MVP" or awardID = "Gold Glove"
GROUP BY AwardsPlayers.awardID

#need to split up and count MVP and Gold Glove winnings