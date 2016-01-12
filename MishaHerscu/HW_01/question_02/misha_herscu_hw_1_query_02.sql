SELECT 
    f.pos,
    count(*) AS count
FROM baseball.awardsPlayers ap, baseball.fielding f
WHERE CONCAT(f.playerID, f.yearID) = CONCAT(ap.playerID, ap.yearID)
AND ap.awardID IN ('Triple Crown','MVP')
GROUP BY f.pos
ORDER BY count(*)