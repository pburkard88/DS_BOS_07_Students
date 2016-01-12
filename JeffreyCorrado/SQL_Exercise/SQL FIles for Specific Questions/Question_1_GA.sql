SELECT Masters.nameFirst, Masters.nameLast, AwardsPlayers.yearID, Batting.*, Batting.H/Batting.AB as BAVG
FROM AwardsPlayers JOIN Masters ON AwardsPlayers.playerID = Masters.playerID
INNER JOIN Batting on AwardsPlayers.playerID = Batting.playerID AND AwardsPlayers.yearID = Batting.yearID
INNER JOIN Fielding on AwardsPlayers.playerID = Fielding.playerID AND AwardsPlayers.yearID = Fielding.yearID
WHERE AwardsPlayers.awardID = 'Triple Crown' AND Fielding.POS != "P"
ORDER BY BAVG DESC, Batting.RBI DESC, Batting.HR DESC