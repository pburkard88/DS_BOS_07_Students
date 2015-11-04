# 6. Calculate the number of world series, 
# division titles, and league championships for all teams.

SELECT teamID, count(WSWin) AS "World Series Wins" , count(DivWin) AS "Division Titles", count(LgWin) AS "League Wins"
FROM Teams
WHERE WSWin = 'Y' or DivWin = 'Y' or LgWin = 'Y'
GROUP BY teamID
ORDER BY teamID DESC

# Need to consolidate duplicate/appended teamIDs