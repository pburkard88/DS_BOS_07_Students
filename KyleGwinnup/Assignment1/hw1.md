% Kyle Gwinnup
% DATBOS07

# Homework 1

1. Find all of the Triple Crown (Award) winners ever in Major League Baseball,
   with their complete batting stats for the given year. Order the results in
   descending order first by batting average, then by RBIs, and lastly by home
   runs.

```sql
select *, nameFirst, nameLast, (Batting.H / Batting.AB) as BA
from AwardsPlayers
inner join Batting on AwardsPlayers.playerID = Batting.playerID 
inner join Master on AwardsPlayers.playerID = Master.playerID
where awardID = "Triple Crown" and Batting.yearID = AwardsPlayers.yearID
group by AwardsPlayers.yearID
order by BA desc, RBI desc, HR desc;
```

```
'clemero02','Triple Crown','1997','AL',NULL,'','clemero02','1997','1','TOR','AL','34','1','2','1','1','1','0','0','0','0','0','1','0','0','0','0','0','0','1','2548','clemero02','','','1962','8','4','USA','OH','Dayton',NULL,NULL,NULL,NULL,NULL,NULL,'Roger','Clemens',NULL,'William Roger','Rocket','220','76.0','R','R','1984-05-15','2007-09-16','Texas','clemero02','clemero02','clemr001','clemero02','clemero02','Roger','Clemens','0.5000'
'duffyhu01','Triple Crown','1894','NL',NULL,'','duffyhu01','1894','1','BSN','NL','125','125','539','160','237','51','16','18','145','48',NULL,'66','15',NULL,'1',NULL,NULL,NULL,'125','3841','duffyhu01','duffyhu01m','duffyhu01h','1866','11','26','USA','RI','Cranston','1954','10','19','USA','MA','Boston','Hugh','Duffy',NULL,'Hugh','Sir Hugh','168','67.0','R','R','1888-06-23','1906-04-13','','duffyhu01','duffyhu01','duffh101','duffyhu01','duffyhu01','Hugh','Duffy','0.4397'
'oneilti01','Triple Crown','1887','AA',NULL,'','oneilti01','1887','1','SL4','AA','124','124','517','167','225','52','19','14','123','30',NULL,'50',NULL,NULL,'5',NULL,NULL,NULL,'124','10592','oneilti01','','','1858','5','25','CAN','ON','Springfield','1915','12','31','CAN','PQ','Montreal','Tip','O\'Neill',NULL,'James Edward',NULL,'167',NULL,'R','R','1883-05-05','1892-08-30','','oneiti01','o\'neiti01','oneit101','oneiti01','o\'neiti01','Tip','O\'Neill','0.4352'
'lajoina01','Triple Crown','1901','AL',NULL,'','lajoina01','1901','1','PHA','AL','131','131','544','145','232','48','14','14','125','27',NULL,'24',NULL,NULL,'13','1',NULL,NULL,'131','7874','lajoina01','lajoina01m','lajoina01h','1874','9','5','USA','RI','Woonsocket','1959','2','7','USA','FL','Daytona Beach','Nap','Lajoie',NULL,'Napoleon','Larry,Poli','195','73.0','R','R','1896-08-12','1916-08-26','','lajoina01','lajoina01','lajon101','lajoina01','lajoina01','Nap','Lajoie','0.4265'
'hornsro01','Triple Crown','1925','NL',NULL,'','hornsro01','1925','1','SLN','NL','138','138','504','133','203','41','10','39','143','5','3','83','39',NULL,'2','16',NULL,NULL,'138','6552','hornsro01','hornsro01m','hornsro01h','1896','4','27','USA','TX','Winters','1963','1','5','USA','IL','Chicago','Rogers','Hornsby',NULL,'Rogers','Rajah','175','71.0','R','R','1915-09-10','1937-07-20','','hornsro01','hornsro01','hornr101','hornsro01','hornsro01','Rogers','Hornsby','0.4028'
'hornsro01','Triple Crown','1922','NL',NULL,'','hornsro01','1922','1','SLN','NL','154','154','623','141','250','46','14','42','152','17','12','65','50',NULL,'1','15',NULL,NULL,'154','6552','hornsro01','hornsro01m','hornsro01h','1896','4','27','USA','TX','Winters','1963','1','5','USA','IL','Chicago','Rogers','Hornsby',NULL,'Rogers','Rajah','175','71.0','R','R','1915-09-10','1937-07-20','','hornsro01','hornsro01','hornr101','hornsro01','hornsro01','Rogers','Hornsby','0.4013'
'cobbty01','Triple Crown','1909','AL',NULL,'','cobbty01','1909','1','DET','AL','156','156','573','116','216','33','10','9','107','76',NULL,'48',NULL,NULL,'6','24',NULL,NULL,'156','2593','cobbty01','cobbty01m','cobbty01h','1886','12','18','USA','GA','Narrows','1961','7','17','USA','GA','Atlanta','Ty','Cobb',NULL,'Tyrus Raymond','The Georgia Peach','175','73.0','L','R','1905-08-30','1928-09-11','','cobbty01','cobbty01','cobbt101','cobbty01','cobbty01','Ty','Cobb','0.3770'
```

2. Calculate the number of MVPs and Triple Crown winners by position ever in
   major league baseball.

```
select 
	awardID,
    POS,
    count(POS)
from (select 
	AwardsPlayers.yearID as yearID, 
    AwardsPlayers.playerID as playerID, 
    nameFirst, 
    nameLast, 
    awardID
from AwardsPlayers
inner join Master on Master.playerID = AwardsPlayers.playerID
where AwardID = "MVP" || AwardID = "Triple Crown") t1
inner join Fielding on Fielding.playerID = t1.playerID and Fielding.yearID = t1.yearID
group by POS, awardID
order by count(POS) desc;

select 
	awardID,
	if(POS = "CF" or POS = "LF" or POS = "RF", "OF", POS) as nPOS,
    count(POS)
from (select 
	AwardsPlayers.yearID as yearID, 
    AwardsPlayers.playerID as playerID, 
    nameFirst, 
    nameLast, 
    awardID
from AwardsPlayers
inner join Master on Master.playerID = AwardsPlayers.playerID
where AwardID = "MVP" || AwardID = "Triple Crown") t1
inner join Fielding on Fielding.playerID = t1.playerID and Fielding.yearID = t1.yearID
group by nPOS, awardID
order by count(POS) desc;
```

```
'MVP','OF','68'
'MVP','1B','48'
'Triple Crown','P','36'
'MVP','DH','33'
'MVP','RF','28'
'MVP','LF','26'
'MVP','CF','25'
'MVP','3B','23'
'MVP','P','23'
'MVP','SS','20'
'MVP','2B','18'
'Triple Crown','OF','18'
'MVP','C','18'
'Triple Crown','SS','6'
'Triple Crown','1B','4'
'Triple Crown','2B','4'
'Triple Crown','CF','2'
'Triple Crown','LF','2'
'Triple Crown','3B','1'
'Triple Crown','RF','1'
```

3. Calculate the number of MVPs and Triple Crown winners by team ever in major
   league baseball.

```
select 
	awardID,
    POS,
    count(teamID)
from (select 
	AwardsPlayers.yearID as yearID, 
    AwardsPlayers.playerID as playerID, 
    nameFirst, 
    nameLast, 
    awardID
from AwardsPlayers
inner join Master on Master.playerID = AwardsPlayers.playerID
where AwardID = "MVP" || AwardID = "Triple Crown") t1
inner join Fielding on Fielding.playerID = t1.playerID and Fielding.yearID = t1.yearID
group by teamID, awardID
order by count(teamID) desc;
```

```
'MVP','1B','39'
'MVP','C','28'
'MVP','2B','27'
'MVP','OF','24'
'MVP','OF','21'
'MVP','P','15'
'MVP','1B','14'
'MVP','OF','14'
'MVP','1B','14'
'MVP','OF','11'
'MVP','SS','10'
'MVP','OF','9'
'MVP','1B','8'
'MVP','3B','8'
'MVP','2B','8'
'MVP','OF','8'
'Triple Crown','OF','7'
'MVP','2B','7'
'Triple Crown','OF','7'
'Triple Crown','2B','7'
'Triple Crown','P','7'
'MVP','CF','7'
'MVP','P','6'
'MVP','SS','6'
'MVP','1B','6'
'Triple Crown','1B','6'
'MVP','1B','5'
'MVP','1B','5'
'MVP','2B','5'
'MVP','OF','5'
'Triple Crown','OF','5'
'MVP','2B','5'
'Triple Crown','OF','5'
'Triple Crown','1B','4'
'Triple Crown','P','4'
'Triple Crown','2B','3'
'MVP','OF','3'
'MVP','DH','3'
'Triple Crown','P','3'
'MVP','1B','3'
'Triple Crown','OF','2'
'Triple Crown','P','2'
'Triple Crown','P','2'
'MVP','1B','2'
'Triple Crown','OF','2'
'MVP','2B','2'
'Triple Crown','P','1'
'MVP','1B','1'
'Triple Crown','P','1'
'Triple Crown','P','1'
'Triple Crown','P','1'
'Triple Crown','P','1'
'Triple Crown','P','1'
'Triple Crown','P','1'
'Triple Crown','OF','1'
'MVP','3B','1'
```


4. Calculate the average batting average, RBIs, and home runs by position ever
   in major league baseball. Only consider seasons where a player had at least
   300 at-bats (AB).

```
select POS, avg(RBI) as avgRBI, avg(HR) as avgHR, (H / AB) as bavg
from Batting
inner join Fielding on Batting.playerID = Fielding.playerID
where AB > 300
group by POS;
```

```
'1B','70.6064','13.6744','0.2799'
'2B','53.5728','6.4783','0.2799'
'3B','60.5570','9.9283','0.2799'
'C','56.3062','9.2821','0.2085'
'CF','61.3736','14.1634','0.2799'
'DH','70.2555','17.2563','0.2799'
'LF','64.4096','15.2329','0.2799'
'OF','64.9105','12.2007','0.2799'
'P','60.4212','6.1980','0.3136'
'RF','66.5444','16.0473','0.2799'
'SS','53.6738','6.5790','0.2270'
```


5. Return all player info for all players that won an MVP and a Gold Glove
   during their careers, along with the number of times they won each.

```
select nameFirst, nameLast, tt.num 
from (select 
	gPlayerID as playerID,
    (gNum + mNum) as num
from (select * from (select 
	playerID as gPlayerID,
    awardID as gAwardID,
    count(*) as gNum
from AwardsPlayers
where awardID = "Gold Glove"
group by gPlayerID) g
inner join 
(select 
	playerID as mPlayerID,
    awardID as mAwardID,
    count(*) as mNum
from AwardsPlayers
where awardID = "MVP"
group by mPlayerID) m
on g.gPlayerID = m.mPlayerID) t) tt
inner join Master on Master.playerID = tt.playerID
order by num desc;
```

```
'Brooks','Robinson','17'
'Barry','Bonds','15'
'Willie','Mays','14'
'Ivan','Rodriguez','14'
'Roberto','Clemente','13'
'Mike','Schmidt','13'
'Johnny','Bench','12'
'Keith','Hernandez','12'
'Ken','Griffey','11'
'Don','Mattingly','10'
'Bob','Gibson','10'
'Ryne','Sandberg','10'
'Ichiro','Suzuki','10'
'Andre','Dawson','9'
'Bobby','Shantz','9'
'Larry','Walker','8'
'Carl','Yastrzemski','8'
'Joe','Morgan','7'
'Dale','Murphy','7'
'Ken','Boyer','6'
'Alex','Rodriguez','5'
'Fred','Lynn','5'
'Steve','Garvey','5'
'Cal','Ripken','4'
'Willie','McGee','4'
'Thurman','Munson','4'
'Jimmy','Rollins','4'
'Ken','Caminiti','4'
'Barry','Larkin','4'
'Dave','Parker','4'
'Mickey','Mantle','4'
'Terry','Pendleton','4'
'Nellie','Fox','4'
'Hank','Aaron','4'
'Albert','Pujols','4'
'Joe','Mauer','3'
'Ernie','Banks','3'
'Zoilo','Versalles','3'
'Frank','Robinson','3'
'Maury','Wills','3'
'Elston','Howard','3'
'Robin','Yount','3'
'Pete','Rose','3'
'Roger','Maris','3'
'Jeff','Bagwell','2'
'Joe','Torre','2'
'Rickey','Henderson','2'
'George','Brett','2'
'Jackie','Jensen','2'
'Dustin','Pedroia','2'
```

6. Calculate the number of world series, division titles, and league
   championships for all teams.

```
select 
	teamID,
    franchName,
	sum(if(WSWin = 'Y', 1, 0)) as ws, 
    sum(if(DivWin = 'Y', 1, 0)) as dw,
    sum(if(LgWin = 'Y', 1, 0)) as lw,
    (sum(if(WSWin = 'Y', 1, 0)) + 
		sum(if(DivWin = 'Y', 1, 0)) + 
        sum(if(LgWin = 'Y', 1, 0))) as totals
from Teams
inner join TeamsFranchises on TeamsFranchises.franchID = Teams.franchID
group by Teams.franchID
order by totals desc;
```

```
'BLA','New York Yankees','27','16','40','83'
'SL4','St. Louis Cardinals','11','10','21','42'
'BR3','Los Angeles Dodgers','6','11','22','39'
'PHA','Oakland Athletics','9','14','15','38'
'BSN','Atlanta Braves','3','16','17','36'
'NY1','San Francisco Giants','7','6','20','33'
'BOS','Boston Red Sox','7','6','12','25'
'CHN','Chicago Cubs','2','5','16','23'
'PT1','Pittsburgh Pirates','5','9','9','23'
'CN2','Cincinnati Reds','5','8','10','23'
```

7. Calculate the average salary (as a percentage of yearly average) of all MVPs
   ever in major league baseball.

```
select 
    nameFirst,
    nameLast,
	avg(Salaries.salary) avgSalary 
from Salaries
inner join (select * from AwardsPlayers where awardID = "MVP" group by playerID) mvp
on mvp.playerID = Salaries.playerID
inner join Master on mvp.playerID = Master.playerID
group by Salaries.playerID
order by avgSalary desc;
```

```
'Alex','Rodriguez','14463515.750000'
'Ichiro','Suzuki','10347942.555556'
'Vladimir','Guerrero','8648461.538462'
'Jason','Giambi','8603933.066667'
'Barry','Bonds','8556605.545455'
'Jeff','Bagwell','8542267.933333'
'Albert','Pujols','8326232.000000'
'Chipper','Jones','7503066.647059'
'Larry','Walker','7357562.066667'
```


8. Use the statistics available at Baseball-Reference to add Miguel Cabrera's
   2012 Triple Crown season to your Database. Make sure to add the appropriate
   information to all relevant tables.


