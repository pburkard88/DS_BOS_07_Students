select AwardsPlayers.playerID, AwardsPlayers.yearID, Batting.*, BattingPost.*
FROM AwardsPlayers
JOIN Batting ON AwardsPlayers.playerID = Batting.playerID
LEFT Join BattingPost On AwardsPlayers.playerID = BattingPost.playerID
where AwardsPlayers.awardID Like "Triple Crown"
Order By Batting.G,Batting.RBI,Batting.HR

