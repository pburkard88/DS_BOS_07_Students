## Calculate the number of world series, division titles, and league championships for all teams.
SELECT t.name, SUM(CASE WHEN sp.round ='WS' THEN 1 ELSE 0 END) AS WSWins, 
SUM(CASE WHEN sp.round ='ALCS' THEN 1 ELSE 0 END) as ALCS_Wins, 
SUM(CASE WHEN sp.round ='NLCS' THEN 1 ELSE 0 END) as NLCS_Wins, 
SUM(CASE WHEN sp.round ='ALDS1' OR 'ALDS2' THEN 1 ELSE 0 END) AS AL_Division_Wins, 
SUM(CASE WHEN sp.round ='NLDS1' OR 'NLDS2' THEN 1 ELSE 0 END) AS NL_Divison_Wins
FROM teams t, seriespost sp
WHERE t.teamid = sp.teamidwinner AND t.yearid = sp.yearid
GROUP BY t.teamid
ORDER BY WSWins DESC
## I know I need to Inner Join but ran out of time.