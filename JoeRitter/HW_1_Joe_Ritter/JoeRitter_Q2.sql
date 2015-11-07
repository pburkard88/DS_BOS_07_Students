# Calculate the number of MVPs and Triple Crown winners by position ever in major league baseball.

SELECT f.POS, COUNT(a.awardID) as  MVP_TC
FROM awardsplayers a, fielding f
WHERE f.playerID = a.playerID and f.yearID = a.yearID and (a.awardID ='MVP' OR a.awardID ='Triple Crown')
GROUP BY f.POS
ORDER BY Count(a.awardID) DESC