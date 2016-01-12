-- 1. Find all of the Triple Crown (Award) winners ever in Major League Baseball, with their complete batting stats for the given year. 
-- Order the results in descending order first by batting average, then by RBIs, and lastly by home runs.

-- Note: I sorted results by batting average AND RBIs, AND home runs all together (nested sort).
-- To sort by either batting avg., RBIs, or HR separately, I'd remove the other two columns from the "ORDER BY" line below.
-- Batting avg. is calculated by hits/at-bats (b.H/b.AB) below.

SELECT a.awardID, ROUND ((b.H/b.AB), 3) AS 'Batting Average', b.* FROM awardsplayers a 
LEFT JOIN batting b ON a.playerID = b.playerID AND a.yearID = b.yearID 
WHERE awardID = 'Triple Crown'
ORDER BY (b.H/b.AB) DESC, b.RBI DESC, b.HR DESC;


-- 2. Calculate the number of MVPs and Triple Crown winners by position ever in major league baseball.

-- V1: This script shows MVP and Triple Crown winners (grouping awards separately) by position.
SELECT a.awardID, f.POS, COUNT(*) FROM awardsplayers a LEFT JOIN fielding f ON a.playerID = f.playerID AND a.yearID = f.yearID
WHERE awardID = 'Triple Crown' OR awardID = 'MVP'
GROUP BY a.awardID, f.POS ORDER BY a.awardID DESC, f.POS;

-- V2: This script combines the MVP and Triple Crown award winners by position.
SELECT f.POS, COUNT(*) FROM awardsplayers a LEFT JOIN fielding f ON a.playerID = f.playerID AND a.yearID = f.yearID 
WHERE awardID = 'Triple Crown' OR awardID = 'MVP'
GROUP BY f.POS;


-- 3. Calculate the number of MVPs and Triple Crown winners by team ever in major league baseball.

-- V1: This script shows MVP and Triple Crown winners (grouping awards separately) by team. 
-- I used Team ID because team names changed over time.
SELECT t.teamID, a.awardID, count(*) FROM awardsplayers a 
LEFT JOIN fielding f ON a.playerID = f.playerID AND a.yearID = f.yearID 
LEFT JOIN teams t on f.teamID = t.teamID AND f.yearID = t.yearID 
WHERE awardID = 'Triple Crown' OR awardID = 'MVP'
GROUP BY a.awardID, t.teamID;

-- V2: This script combines the MVP and Triple Crown award winners by team.
-- I used Team ID because team names changed over time.
SELECT t.teamID, count(*) FROM awardsplayers a 
LEFT JOIN fielding f ON a.playerID = f.playerID AND a.yearID = f.yearID 
LEFT JOIN teams t on f.teamID = t.teamID AND f.yearID = t.yearID 
WHERE awardID = 'Triple Crown' OR awardID = 'MVP'
GROUP BY t.teamID;


-- 4. Calculate the average batting average, RBIs, and home runs by position ever in major league baseball. 
-- Only consider seasons where a player had at least 300 at-bats (AB).

SELECT f.POS, MIN(b.AB) AS 'Min # At-bats (check)', ROUND(AVG(b.H/b.AB), 3) AS 'Avg. Batting Average', ROUND(AVG(b.RBI), 2) AS 'Avg. RBI', 
ROUND(AVG(b.HR), 2) AS 'Avg. HR' FROM batting b 
LEFT JOIN fielding f ON b.playerID = f.playerID AND b.yearID = f.yearID 
WHERE b.AB >= 300
GROUP BY f.POS;


-- 5. Return all player info for all players that won an MVP and a Gold Glove during their careers, along with the number of times they won each.

SELECT playerID, COUNT(IF(awardID = 'Triple Crown', 1, null)) AS 'Triple Crown Wins',
COUNT(IF(awardID = 'MVP', 1, null)) AS 'MVP Wins' FROM awardsplayers
WHERE playerID = playerID AND yearID = yearID
GROUP BY playerID
HAVING COUNT(IF(awardID = 'Triple Crown', 1, null)) >0 AND COUNT(IF(awardID = 'MVP', 1, null)) >0;


-- 6. Calculate the number of world series, division titles, and league championships for all teams.

SELECT teamID, COUNT(IF(WSWin = 'Y', 1, null)) AS 'World Championships', 
COUNT(IF(DivWin = 'Y', 1, null)) AS 'Division Championships',
COUNT(IF(LgWin = 'Y', 1, null)) AS 'League Championships' FROM teams
GROUP BY teamID;


-- 7. Calculate the average salary (as a percentage of yearly average) of all MVPs ever in major league baseball.

SELECT s.yearID, ROUND(AVG(s.salary), 2) AS 'MLB average yearly salary', a.playerID, a.awardID, 
s.salary AS 'MVP Salary', ROUND((s.salary/AVG(s.salary)*100),2) AS 'MVP Salary as % of league average'
FROM salaries s
LEFT JOIN awardsplayers a ON s.yearID=s.yearID AND s.playerID = a.playerID
WHERE a.awardID = 'MVP' 
GROUP BY s.yearID;


-- 8. Use the statistics available at Baseball-Reference to add Miguel Cabrera's 2012 Triple Crown season to your Database. 
-- Make sure to add the appropriate information to all relevant tables

-- Player ID is 'cabremi01'

-- I'm going to add only batting and fielding stats since I'm running out of time!
-- I'm not sure what 'stint' means - I used '10' here since it looks like 2012 was his 10th season? 
-- (Probably should have left 'stint' null since I don't know for sure...)
INSERT INTO batting (playerID, yearID, stint, teamID, lgID, G, AB, R, H, 2B, 3B, HR, RBI, SB, CS, BB, SO)
VALUES ('cabremi01', '2012', '10', 'DET', 'AL', '161', '622', '109', '205', '40', '0', '44', '139', '4', '1', '66', '98');

-- Check work: 
SELECT * FROM batting
WHERE playerID = 'cabremi01' AND yearID = '2012';

-- Cabrera played 3 field positions in 2012; each gets its own record.
INSERT INTO fielding (playerID, yearID, stint, teamID, lgID, POS, G, GS, PO, A, E, DP)
VALUES ('cabremi01', '2012', '10', 'DET', 'AL', '3B', '154', '154', '127', '243', '13', '13');

INSERT INTO fielding (playerID, yearID, stint, teamID, lgID, POS, G, GS)
VALUES ('cabremi01', '2012', '10', 'DET', 'AL', 'DH', '7', '7');

INSERT INTO fielding (playerID, yearID, stint, teamID, lgID, POS, G, GS, PO, A, E, DP)
VALUES ('cabremi01', '2012', '10', 'DET', 'AL', '1B', '2', '0', '4', '0', '0', '1');

-- Check work:
SELECT * FROM fielding
WHERE playerID = 'cabremi01' AND yearID = '2012';
