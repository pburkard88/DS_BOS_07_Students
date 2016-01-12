SELECT
DISTINCT(t.teamID),
wsw.world_series,
dt.division_titles,
lc.league_championships
FROM baseball.teams t
INNER JOIN (
	SELECT
	teamID,
	COUNT(WSWin) AS world_series
	FROM baseball.teams
	WHERE WSWin = 'Y'
	GROUP BY teamID ) wsw ON wsw.teamID = t.teamID
INNER JOIN (
	SELECT
	teamID,
	COUNT(DivWin) AS division_titles
	FROM baseball.teams
	WHERE DivWin = 'Y'
	GROUP BY teamID ) dt ON dt.teamID = t.teamID
INNER JOIN (
	SELECT
	teamID,
	COUNT(LGWin) AS league_championships
	FROM baseball.teams
	WHERE LgWin = 'Y'
	GROUP BY teamID ) lc ON lc.teamID = t.teamID
ORDER BY world_series DESC, division_titles DESC, league_championships DESC
    
    
    