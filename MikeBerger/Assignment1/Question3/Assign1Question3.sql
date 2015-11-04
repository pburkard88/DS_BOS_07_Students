select Fielding.teamID, COUNT(*)
FROM Fielding
JOIN AwardsPlayers ON Fielding.playerID = AwardsPlayers.playerID 
where AwardsPlayers.awardID Like "Triple Crown" OR AwardsPlayers.awardID Like "MVP"
AND AwardsPlayers.yearID = Fielding.yearID
GROUP BY Fielding.teamID
Order by COUnt(*) DESC

