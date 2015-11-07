SELECT 
    teamID, SUM(WSWin), SUM(DivWin), SUM(LgWin)
FROM
    teams
GROUP BY teamID