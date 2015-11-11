SELECT *, name, Count(DivWin), Count(LgWin), Count(WSWin) FROM baseball.teams WHERE DivWin = "y" AND LgWin = "Y" AND WSWin = "Y"   ORDER BY COUNT(DISTINCT WSWin) DESC
