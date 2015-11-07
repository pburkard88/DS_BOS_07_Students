### Solutions to  Assignment 1: Lahman Baseball Dataset
1. Find all of the Triple Crown (Award) winners ever in Major League Baseball, with their complete batting stats for the given year. Order the results in descending order first by batting average, then by RBIs, and lastly by home runs.
````
SELECT m.nameFirst, m.nameLast, ap.yearID, ap.awardID, b.h / b.ab as BattingAVG, b.rbi, b.hr
FROM AwardsPlayers ap
JOIN Batting b ON ap.playerID = b.playerID
JOIN Master m on ap.playerID = m.playerID
WHERE awardID = 'Triple Crown' AND b.yearID = ap.yearID
ORDER BY BattingAVG DESC, b.rbi DESC, b.hr DESC;
````

2. Calculate the number of MVPs and Triple Crown winners by position ever in major league baseball.
````
SELECT DISTINCT f.pos, count(f.pos) as MVPsTripleCrownWinners
FROM AwardsPlayers ap
JOIN FieldingPost f
ON ap.playerID = f.playerID AND ap.yearID = f.yearID
WHERE ap.awardID = 'MVP' OR ap.awardID = 'Triple Crown'
GROUP BY f.pos
````

3. Calculate the number of MVPs and Triple Crown winners by team ever in major league baseball.
````
SELECT DISTINCT t.name, count(f.teamID)
FROM AwardsPlayers ap
JOIN FieldingPost f
ON ap.playerID = f.playerID AND ap.yearID = f.yearID
JOIN Teams t
ON t.teamID = f.teamID AND ap.yearID = t.yearID
WHERE ap.awardID = 'MVP' OR ap.awardID = 'Triple Crown'
GROUP BY f.teamID;
````

4. Calculate the average batting average, RBIs, and home runs by position ever in major league baseball. Only consider seasons where a player had at least 300 at-bats (AB).

5. Return all player info for all players that won an MVP and a Gold Glove during their careers, along with the number of times they won each.
````
SELECT A.playerID, A.awardID,  A.awd, B.awardID, B.awd
FROM
    (SELECT ap.playerID, ap.awardID, count(ap.awardID) as awd
FROM AwardsPlayers ap
WHERE ap.awardID = 'MVP'
GROUP BY ap.playerID, ap.awardID) as A
INNER JOIN
    (SELECT ap.playerID, ap.awardID, count(ap.awardID) as awd
FROM AwardsPlayers ap
WHERE ap.awardID = 'Gold Glove'
GROUP BY ap.playerID, ap.awardID) as B
USING (playerID)
````

6. Calculate the number of world series, division titles, and league championships for all teams.
````
SELECT DISTINCT teamID,
       (SELECT COUNT(*) FROM teams WHERE teamID = y.teamID AND DivWin = 'Y') as DivisionWins,
       (SELECT COUNT(*) FROM teams WHERE teamID = y.teamID AND LgWin = 'Y') as LeagueWins,
       (SELECT COUNT(*) FROM teams WHERE teamID = y.teamID AND WSWin = 'Y') as WSWins
FROM Teams y
ORDER BY teamID
````

7. Calculate the average salary (as a percentage of yearly average) of all MVPs ever in major league baseball.
````
SELECT m.nameFirst, m.nameLast, CONCAT(ROUND((A.salary/B.av)*100), "%") as PercentageYearlyAve
FROM
    (SELECT yearID, AVG(Salary) as av
    FROM Salaries
    GROUP BY yearID) AS B
JOIN
    (SELECT p.playerID, p.yearID, p.awardID, s.salary
    FROM Salaries s
    JOIN AwardsPlayers p
    ON p.playerID = s.playerID
    WHERE p.awardID = 'MVP' AND s.yearID = p.yearID) as A
ON A.yearID = B.yearID
JOIN Master m
ON A.playerID = m.playerID
````

8. Use the statistics available at Baseball-Reference to add Miguel Cabrera's 2012 Triple Crown season to your Database. Make sure to add the appropriate information to all relevant tables.
````
INSERT INTO Batting VALUES (
    (SELECT playerID FROM Master WHERE nameFirst = 'Miguel' AND nameLast = 'Cabrera'),
    2012, 1, 'DET', 'AL', 161, NULL, 622, 109, 205, 40, 0, 
    44, 139, 4, 1, 66, 98, 177, 3, 0, 6, 28, NULL);

INSERT INTO Allstar VALUES (
    (SELECT playerID FROM Master WHERE nameFirst = 'Miguel' AND nameLast = 'Cabrera'),
    2012, 'AL');

INSERT INTO AwardsPlayers VALUES(
    (SELECT playerID FROM Master WHERE nameFirst = 'Miguel' AND nameLast = 'Cabrera'),
    'MVP', 2012, 'AL', NULL, NULL);
INSERT INTO AwardsPlayers VALUES(
    (SELECT playerID FROM Master WHERE nameFirst = 'Miguel' AND nameLast = 'Cabrera'),
    'Silver Slugger', 2012, 'AL', NULL, NULL);
````

