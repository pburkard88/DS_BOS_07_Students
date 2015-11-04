SELECT m.nameFirst, m.nameLast, b1.*, (H/AB) AS BA
FROM AwardsPlayers AS a, Batting AS b1, Master AS m
WHERE a.yearID = b1.yearID AND awardID='Triple Crown' AND a.playerID = b1.playerID AND a.playerID = m.playerID
ORDER BY (H/AB) DESC, RBI DESC, HR DESC;