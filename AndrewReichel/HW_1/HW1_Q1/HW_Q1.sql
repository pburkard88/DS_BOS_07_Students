# Find all of the Triple Crown (Award) winners ever in Major League Baseball, 
# with their complete batting stats for the given year. Order the results in 
# descending order first by batting average, then by RBIs, and lastly by home run

SELECT * 
FROM AwardsPlayers
JOIN Batting
ON AwardsPlayers.playerID = Batting.playerID and AwardsPlayers.yearID = Batting.yearID
WHERE awardID = "Triple Crown"
ORDER BY H / AB DESC, RBI DESC, HR DESC