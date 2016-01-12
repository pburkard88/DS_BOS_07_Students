SELECT 
    allstarfull.teamID, awardsplayers.awardID, COUNT(*)
FROM
    fielding
        JOIN
    awardsplayers ON fielding.playerID = awardsplayers.playerID
        JOIN
    AllStarFull ON allstarfull.playerID = awardsplayers.playerID
WHERE
    awardID IN ('Triple Crown' , 'MVP')
GROUP BY teamID , awardID
