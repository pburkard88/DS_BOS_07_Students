# Calculate the average batting average, 
# RBIs, and home runs by position ever in 
# major league baseball. Only consider 
#seasons where a player had at least 300 at-bats (AB).

SELECT POS, avg(H/AB) AS "Batt_Avg", avg(RBI) AS "RBI_AVG", avg(HR) AS "HR_AVG"
FROM Batting
JOIN Fielding
ON Batting.playerID = Fielding.playerID
WHERE AB >= 300
GROUP BY POS
ORDER BY avg(H/AB) DESC