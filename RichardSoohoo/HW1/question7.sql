 SELECT a.playerID, a.awardID, s.salary 
 FROM baseball.awardplayers a, baseball.salaries s 
 WHERE a.playerID = s.playerID AND a.awardID = 'MVP' 
