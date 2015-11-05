# Calculate the number of MVPs and Triple Crown winners by team ever in major league baseball.
#
SELECT ap.teamID, COUNT(a.awardID) as MVP_TC
FROM awardsplayers a, appearances ap
WHERE a.playerID = ap.playerID AND a.yearID = ap.yearID AND (a.awardID ='MVP' OR a.awardID ='Triple Crown')
GROUP BY ap.teamID
ORDER BY Count(a.awardID) DESC