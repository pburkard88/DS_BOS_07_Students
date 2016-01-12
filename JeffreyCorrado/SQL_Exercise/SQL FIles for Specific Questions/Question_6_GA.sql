SELECT teamID, COUNT(LgWin) AS "LgWins", COUNT(DivWin) As "DivWins", COUNT(WSWin) as "WSWins" FROM Teams
WHERE Teams.DivWin = 'Y' OR Teams.LgWin = 'Y' OR Teams.WSWin = 'Y'
GROUP BY teamID