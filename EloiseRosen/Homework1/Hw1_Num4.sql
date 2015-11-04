

SELECT 
    pos, AVG(g_batting), AVG(RBI), AVG(HR)
FROM
    batting
        JOIN
    fieldingpost ON fieldingpost.playerID = batting.playerID
WHERE
    batting.AB >= 300
GROUP BY POS