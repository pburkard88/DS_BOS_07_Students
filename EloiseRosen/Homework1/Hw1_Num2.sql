SELECT 
    POS, awardsplayers.awardID, COUNT(*)
FROM
    fielding
        JOIN
    awardsplayers ON fielding.playerID = awardsplayers.playerID
WHERE
    awardID IN ('Triple Crown' , 'MVP')
GROUP BY POS , awardID