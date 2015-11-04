SELECT 
    *, COUNT(*)
FROM
    awardsplayers
        JOIN
    Master ON Master.playerID = awardsplayers.playerID
WHERE
    awardsplayers.awardID IN ('MVP' , 'Gold Glove')
GROUP BY awardsplayers.playerID , awardsplayers.awardID