SELECT Batting.playerID, Batting.H, Batting.AB, Batting.RBI, Batting.HR FROM AwardsPlayers, Batting 
WHERE AwardsPlayers.playerID = Batting.playerID AND AwardsPlayers.yearID = Batting.yearID 
AND awardID = 'Triple Crown' AND (AwardsPlayers.lgID = 'AL' OR AwardsPlayers.lgID = 'NL') 
ORDER BY (H/AB) DESC, RBI DESC, HR DESC