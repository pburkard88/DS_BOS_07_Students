SELECT *, H/AB as batting_average
FROM AwardsPlayers
JOIN Batting ON AwardsPlayers.playerID = Batting.playerID
AND AwardsPlayers.yearID = Batting.yearID
WHERE AwardsPlayers.awardID = 'Triple Crown'
ORDER BY H/AB DESC, RBI DESC, HR DESC