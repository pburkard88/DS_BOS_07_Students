# 7. Calculate the average salary (as a percentage of yearly average)
# of all MVPs ever in major league baseball.

SELECT ap.layerID, ap.yearID, s.
FROM AwardsPlayers ap
JOIN Salaries s
WHERE awardID = "MVP"