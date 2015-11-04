SELECT 
    *
FROM
    awardsplayers
        JOIN
    batting ON batting.playerID = awardsplayers.playerID
WHERE
    awardsplayers.awardID = 'Triple Crown'
ORDER BY G_batting DESC , RBI DESC , HR DESC