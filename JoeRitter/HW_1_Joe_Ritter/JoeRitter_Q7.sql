# Calculate the average salary (as a percentage of yearly average) of all MVPs ever in major league baseball.
#
SELECT AVG(s.salary) as Average_MVPs_$
FROM salaries s, awardsplayers a
WHERE a.playerid = s.playerid AND a.yearid = s.yearid AND a.awardid ='MVP'