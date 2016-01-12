SELECT teamID, COUNT(*) FROM AwardsPlayers, Appearances 
WHERE (awardID = 'Triple Crown' OR awardID = 'MVP') AND AwardsPlayers.playerID = Appearances.playerID 
AND AwardsPlayers.yearID = Appearances.yearID AND (AwardsPlayers.lgID = 'NL' OR AwardsPlayers.lgID = 'AL') 
GROUP BY teamID