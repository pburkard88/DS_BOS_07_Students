-- Note: I couldn't find fieldingpost or allstarfull stats, but I think I added everything else.
-- Note: I commented out each INSERT statement so that I could do them one-by-one and keep them in the same file. I returned a sample result at the bottom.

/*
INSERT INTO baseball.batting (playerID,	yearID,	stint,	teamID,	lgID,	G,	AB,	R,	H,	2B,	3B,	HR,	RBI,	SB,	CS,	BB,	SO,	IBB,	HBP,	SH,	SF,	GIDP)
VALUES ('cabremi01',2012,1,'DET','AL',161,622,109,205,40,0,44,139,4,1,66,98,17,3,0,6,28) 
*/

/*
INSERT INTO baseball.fielding (playerID,	yearID,	stint,	teamID,	lgID,	POS,	G,	GS,	InnOuts,	PO,	A,	E,	DP)
VALUES ('cabremi01',	2012,	1,	'DET',	'AL',	'3B',	154,	154,	3966,	127,	243,	13,	31)
*/

/*
INSERT INTO baseball.awardsplayers (playerID,awardID,yearID,lgID)
VALUES ('cabremi01', 'Triple Crown', 2012, 'AL')
*/

/*
INSERT INTO baseball.allstar (playerID,yearID,lgID)
VALUES ('cabremi01', 2012, 'AL')
*/

/*
INSERT INTO salaries (yearID, teamID, lgID, playerID, salary)
VALUES (2012, 'DET', 'AL', 'cabremi01',	21000000)
*/

/*
INSERT INTO baseball.battingpost (yearID,	playerID,	teamID,	lgID,	G,	AB,	R,	H,	2B,	3B,	HR,	RBI,	SB,	CS,	BB,	SO,	IBB,	HBP,	SH,	SF,	GIDP)
VALUES (2012, 'cabremi01', 'DET', 'AL', 4, 13, 1,	3, 0, 0, 1, 3, 0, 0, 3,	4, 0, 0, 0,	0, 0)
*/

SELECT * FROM baseball.batting WHERE yearID = 2012
