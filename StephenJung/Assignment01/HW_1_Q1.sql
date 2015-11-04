# Problem 1, Assignment 1

SELECT
(BattingPost.H/BattingPost.AB) as b_avg,
BattingPost.*, AwardsPlayers.awardID
FROM AwardsPlayers
INNER JOIN BattingPost
ON AwardsPlayers.playerID=BattingPost.playerID and
AwardsPlayers.yearID=BattingPost.yearID
WHERE AwardsPlayers.awardID="Triple Crown"
ORDER BY
b_avg DESC, BattingPost.RBI DESC, BattingPost.HR DESC
