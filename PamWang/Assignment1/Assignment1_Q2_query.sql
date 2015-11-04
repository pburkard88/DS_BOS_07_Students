SELECT POS, COUNT(*) FROM AwardsPlayers, Fielding 
WHERE AwardsPlayers.playerID = Fielding.playerID AND (awardID = 'Triple Crown' OR awardID = 'MVP') 
AND AwardsPlayers.yearID = Fielding.yearID 
GROUP BY POS ORDER BY COUNT(*) DESC