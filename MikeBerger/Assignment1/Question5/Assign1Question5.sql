/* Self Join 
I could not figure out how to do a self join and still count each awardID query separately
*/
select Master.nameFirst, Master.nameLast, a1.awardID, a1.yearID, a2.yearID, a2.awardID, COUNT(*)
FROM AwardsPlayers a1,AwardsPlayers a2, Master
Where a1.awardID LIKE "%Gold%"
AND a2.awardID LIKE "%MVP%"
AND a1.playerID = a2.playerID
AND Master.playerID = a1.playerID
GROUP by Master.nameLast
ORDER by Master.nameLast









