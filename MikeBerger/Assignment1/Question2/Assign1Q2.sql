select AwardsPlayers.playerID, AwardsPlayers.yearID, Fielding.POS, COUNT(*)
FROM Fielding
JOIN AwardsPlayers ON Fielding.playerID = AwardsPlayers.playerID
where AwardsPlayers.awardID Like "Triple Crown" OR AwardsPlayers.awardID Like "MVP"
GROUP BY Fielding.POS
Order by COUnt(*) desc

