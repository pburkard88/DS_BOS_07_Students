-- 1. Triple Crown Award Winners

SELECT 
	m.namefirst,
    m.namelast,
    ap.awardID, 
    ap.yearID, 
    b.H/b.AB AS batting_average,
    b.RBI, 
    b.HR,
    b.AB, 
    b.R, 
    b.H, 
    b.2B, 
    b.3B, 
    b.SB, 
    b.CS, 
    b.BB,  
    b.SO, 
    b.IBB, 
    b.HBP, 
    b.SH, 
    b.SF,
	b.GIDP,
	b.G_Old
FROM baseball.awardsplayers ap
JOIN baseball.batting b ON ( ap.playerID = b.playerID AND ap.yearID = b.yearID )
JOIN baseball.master m ON ap.playerID = m.playerID
WHERE ap.awardID = 'Triple Crown'
ORDER BY b.h/b.ab DESC, b.RBI DESC, b.HR DESC;
