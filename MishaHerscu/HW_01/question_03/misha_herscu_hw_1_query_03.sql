SELECT 
    a.teamID,
    count(*) AS count
FROM baseball.awardsPlayers ap, baseball.appearances a
WHERE CONCAT(a.playerID, a.yearID) = CONCAT(ap.playerID, ap.yearID)
AND ap.awardID IN ('Triple Crown','MVP')
GROUP BY a.teamID
ORDER BY count(*) DESC