SELECT teamID, 
	SUM(CASE WHEN DivWin = 'Y' then 1 else 0 end) Divisionwins, 
	SUM(CASE WHEN LgWin = 'Y' then 1 else 0 end) Leaguewins, 
    SUM(CASE WHEN WSWin = 'Y' then 1 else 0 end) WorldSerieswins 
FROM Teams 
GROUP BY teamID