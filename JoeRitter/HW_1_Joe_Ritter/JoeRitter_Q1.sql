#Find all of the Triple Crown (Award) winners ever in Major League Baseball, with their complete batting stats for the given year. 
#Order the results in descending order first by batting average, then by RBIs, and lastly by home runs.

SELECT m.nameFirst, m.nameLast, a.awardID, a.yearID, ROUND(((bat.H + bat.2B + bat.3B + bat.HR) / bat.AB)*1000,0) as Batting_Avg, bat.*
FROM AwardsPlayers a
INNER JOIN Master m ON a.playerID = m.playerID
INNER JOIN Batting bat ON a.playerID = bat.playerID AND a.yearID = bat.yearID
WHERE a.awardID = 'Triple Crown'
ORDER BY Batting_Avg DESC, bat.HR DESC, bat.RBI DESC