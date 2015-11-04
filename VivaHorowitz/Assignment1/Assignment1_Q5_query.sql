SELECT * FROM
Master
JOIN
(SELECT playerID,
    SUM(awardID = 'MVP') as numMVP,
    SUM(awardID = 'Gold Glove') as numGoldGlove
FROM AwardsPlayers
WHERE AwardsPlayers.awardID = 'MVP'
OR AwardsPlayers.awardID = 'Gold Glove'
GROUP by AwardsPlayers.playerID) as mytable
ON mytable.playerID = Master.playerID
WHERE (mytable.numMVP > 0 AND mytable.numGoldGlove > 0)
ORDER BY numMVP DESC, numGoldGlove DESC
