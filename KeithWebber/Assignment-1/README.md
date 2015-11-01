# DS_BOS_07 - Assignment-1
## Keith Webber
https://github.com/pburkard88/DS_BOS_07/wiki/Assignment-1
Queries

Use the appropriate SQL queries to find answers to the following questions:

### 1) Find all of the Triple Crown (Award) winners ever in Major League Baseball, with their complete batting stats for the given year. Order the results in descending order first by batting average, then by RBIs, and lastly by home runs.

```sql
# Ordered by Batting Average
# All TC winners excluding pitchers ordered by at rbi, additional complete stats omitted for brevity
  select
    bat.yearID,
    awards.awardID,
    players.nameFirst,
    players.nameLast,
    sum(bat.h / bat.AB) AS batting_average,
    bat.hr,
    bat.rbi
  from Master players
  JOIN AwardsPlayers awards ON (players.playerID = awards.playerID)
  JOIN Batting bat ON (bat.playerID = players.playerID)
  WHERE awards.awardID = "Triple Crown" AND awards.yearID = bat.yearID AND bat.ab >= 502
  GROUP BY players.playerID, bat.yearID
  ORDER BY batting_average DESC;

  +--------+--------------+-----------+-------------+-----------------+------+------+
  | yearID | awardID      | nameFirst | nameLast    | batting_average | hr   | rbi  |
  +--------+--------------+-----------+-------------+-----------------+------+------+
  |   1894 | Triple Crown | Hugh      | Duffy       |          0.4397 |   18 |  145 |
  |   1887 | Triple Crown | Tip       | O,Neill     |          0.4352 |   14 |  123 |
  |   1901 | Triple Crown | Nap       | Lajoie      |          0.4265 |   14 |  125 |
  |   1925 | Triple Crown | Rogers    | Hornsby     |          0.4028 |   39 |  143 |
  |   1922 | Triple Crown | Rogers    | Hornsby     |          0.4013 |   42 |  152 |
  |   1909 | Triple Crown | Ty        | Cobb        |          0.3770 |    9 |  107 |
  |   1937 | Triple Crown | Joe       | Medwick     |          0.3744 |   31 |  154 |
  |   1933 | Triple Crown | Chuck     | Klein       |          0.3680 |   28 |  120 |
  |   1934 | Triple Crown | Lou       | Gehrig      |          0.3627 |   49 |  165 |
  |   1942 | Triple Crown | Ted       | Williams    |          0.3563 |   36 |  137 |
  |   1933 | Triple Crown | Jimmie    | Foxx        |          0.3560 |   48 |  163 |
  |   1956 | Triple Crown | Mickey    | Mantle      |          0.3527 |   52 |  130 |
  |   1947 | Triple Crown | Ted       | Williams    |          0.3428 |   32 |  114 |
  |   1967 | Triple Crown | Carl      | Yastrzemski |          0.3264 |   44 |  121 |
  |   1966 | Triple Crown | Frank     | Robinson    |          0.3160 |   49 |  122 |
  +--------+--------------+-----------+-------------+-----------------+------+------+
  15 rows in set (0.00 sec)


```

```sql
# Ordered by RBI
# All TC winners excluding pitchers ordered by at rbi, additional complete stats omitted for brevity
  select
    bat.yearID,
    awards.awardID,
    players.nameFirst,
    players.nameLast,
    sum(bat.h / bat.AB) AS batting_average,
    bat.hr,
    bat.rbi
  from Master players
  JOIN AwardsPlayers awards ON (players.playerID = awards.playerID)
  JOIN Batting bat ON (bat.playerID = players.playerID)
  WHERE awards.awardID = "Triple Crown" AND awards.yearID = bat.yearID AND  bat.ab >= 502
  GROUP BY players.playerID, bat.yearID
  ORDER BY bat.rbi DESC;

  +--------+--------------+-----------+-------------+-----------------+------+------+
  | yearID | awardID      | nameFirst | nameLast    | batting_average | hr   | rbi  |
  +--------+--------------+-----------+-------------+-----------------+------+------+
  |   1934 | Triple Crown | Lou       | Gehrig      |          0.3627 |   49 |  165 |
  |   1933 | Triple Crown | Jimmie    | Foxx        |          0.3560 |   48 |  163 |
  |   1937 | Triple Crown | Joe       | Medwick     |          0.3744 |   31 |  154 |
  |   1922 | Triple Crown | Rogers    | Hornsby     |          0.4013 |   42 |  152 |
  |   1894 | Triple Crown | Hugh      | Duffy       |          0.4397 |   18 |  145 |
  |   1925 | Triple Crown | Rogers    | Hornsby     |          0.4028 |   39 |  143 |
  |   1942 | Triple Crown | Ted       | Williams    |          0.3563 |   36 |  137 |
  |   1956 | Triple Crown | Mickey    | Mantle      |          0.3527 |   52 |  130 |
  |   1901 | Triple Crown | Nap       | Lajoie      |          0.4265 |   14 |  125 |
  |   1887 | Triple Crown | Tip       | O,Neill     |          0.4352 |   14 |  123 |
  |   1966 | Triple Crown | Frank     | Robinson    |          0.3160 |   49 |  122 |
  |   1967 | Triple Crown | Carl      | Yastrzemski |          0.3264 |   44 |  121 |
  |   1933 | Triple Crown | Chuck     | Klein       |          0.3680 |   28 |  120 |
  |   1947 | Triple Crown | Ted       | Williams    |          0.3428 |   32 |  114 |
  |   1909 | Triple Crown | Ty        | Cobb        |          0.3770 |    9 |  107 |
  +--------+--------------+-----------+-------------+-----------------+------+------+
  ```

```sql
# Ordered by Home Runs
# All TC winners excluding pitchers ordered by at rbi, additional complete stats omitted for brevity
  select
    bat.yearID,
    awards.awardID,
    players.nameFirst,
    players.nameLast,
    sum(bat.h / bat.AB) AS batting_average,
    bat.hr,
    bat.rbi
  from Master players
  JOIN AwardsPlayers awards ON (players.playerID = awards.playerID)
  JOIN Batting bat ON (bat.playerID = players.playerID)
  WHERE awards.awardID = "Triple Crown" AND awards.yearID = bat.yearID AND  bat.ab >= 502
  GROUP BY players.playerID, bat.yearID
  ORDER BY bat.hr DESC;

  +--------+--------------+-----------+-------------+-----------------+------+------+
  | yearID | awardID      | nameFirst | nameLast    | batting_average | hr   | rbi  |
  +--------+--------------+-----------+-------------+-----------------+------+------+
  |   1956 | Triple Crown | Mickey    | Mantle      |          0.3527 |   52 |  130 |
  |   1934 | Triple Crown | Lou       | Gehrig      |          0.3627 |   49 |  165 |
  |   1966 | Triple Crown | Frank     | Robinson    |          0.3160 |   49 |  122 |
  |   1933 | Triple Crown | Jimmie    | Foxx        |          0.3560 |   48 |  163 |
  |   1967 | Triple Crown | Carl      | Yastrzemski |          0.3264 |   44 |  121 |
  |   1922 | Triple Crown | Rogers    | Hornsby     |          0.4013 |   42 |  152 |
  |   1925 | Triple Crown | Rogers    | Hornsby     |          0.4028 |   39 |  143 |
  |   1942 | Triple Crown | Ted       | Williams    |          0.3563 |   36 |  137 |
  |   1947 | Triple Crown | Ted       | Williams    |          0.3428 |   32 |  114 |
  |   1937 | Triple Crown | Joe       | Medwick     |          0.3744 |   31 |  154 |
  |   1933 | Triple Crown | Chuck     | Klein       |          0.3680 |   28 |  120 |
  |   1894 | Triple Crown | Hugh      | Duffy       |          0.4397 |   18 |  145 |
  |   1887 | Triple Crown | Tip       | O,Neill     |          0.4352 |   14 |  123 |
  |   1901 | Triple Crown | Nap       | Lajoie      |          0.4265 |   14 |  125 |
  |   1909 | Triple Crown | Ty        | Cobb        |          0.3770 |    9 |  107 |
  +--------+--------------+-----------+-------------+-----------------+------+------+
  15 rows in set (0.00 sec)


```
```sql
# All players winners based on batting statistics
  select
    players.nameFirst,
    players.nameLast,
    sum(bat.h / bat.AB) AS batting_average,
    bat.hr AS homeruns,
    bat.rbi AS RBI
  from Master players
  JOIN Batting bat ON (bat.playerID = players.playerID)
  WHERE bat.playerID = (SELECT playerID from batting WHERE MAX(rbi) GROUP BY bat.yearID)
  GROUP BY (bat.yearID)
  ORDER BY bat.rbi  ASC ;
```
```sql
# mussings on how to calcluate the winners from tables
  select
    bat.yearID,
    bat_rbiq.playerID,
    bat.hr AS homeruns,
    bat_rbiq.rbi AS RBI
  from (    select
      bat_rbi.playerID,
      bat_rbi.yearID,
      MAX(bat_rbi.hr) AS hr
      from Batting bat_rbi
      group by bat_rbi.yearID
      order by bat_rbi.hr asc) bat
  INNER JOIN (
    select
    bat_rbi.playerID,
    bat_rbi.yearID,
    MAX(bat_rbi.rbi) AS RBI
    from Batting bat_rbi
    group by bat_rbi.yearID
    order by  bat_rbi.rbi asc
  ) as bat_rbiq
  ON (bat.playerID = bat_rbiq.playerID)
  AND  bat.
    ;

```

### 2) Calculate the number of MVPs and Triple Crown winners by position ever in major league baseball.
```sql
# Triple Crown's only - illustrate off by position issue
# some double counting from having pitchers in there technically
   select
      field.pos,
     count(awards.awardID)
   from (
     select * from AwardsPlayers where awardid = "Triple Crown"
   ) awards
   join  (
     select  distinct * from  Fielding where pos != 'OF'
   ) field ON (field.playerID = awards.playerID)
   WHERE awards.yearID = field.yearID
   AND awards.playerID = field.playerID
   group by  field.pos, awards.awardid;
   +-----+-----------------------+
   | pos | count(awards.awardID) |
   +-----+-----------------------+
   | 1B  |                     4 |
   | 2B  |                     4 |
   | 3B  |                     1 |
   | CF  |                     2 |
   | LF  |                     2 |
   | P   |                    36 |
   | RF  |                     1 |
   | SS  |                     6 |
   +-----+-----------------------+

```

# Needs improvements

```sql
# need to remove the pitching at bats
  select
    field.pos,
    count(*)
  from (
    select  AwardsPlayers.yearID, awardsplayers.playerID from AwardsPlayers
    inner join Pitching on (pitching.playerID = AwardsPlayers.playerID)
    where AwardsPlayers.awardid = "Triple Crown"
    AND pitching.yearID != awardsplayers.yearID
  ) awards
  join  (  
    select Fielding.playerID, Fielding.pos, Fielding.yearID from  Fielding
    inner join Pitching on (pitching.playerID = Fielding.playerID)
    where pos != 'OF'
  ) field
  ON (field.playerID = awards.playerID)
  WHERE awards.yearID = field.yearID
  AND awards.playerID = field.playerID
  group by field.pos;

```



### 3) Calculate the number of MVPs and Triple Crown winners by team ever in major league baseball.

```sql
# MVP and Triple Crown winners by team
  select
     field.teamID,
    count(awards.awardID) as "MVP/TripleCrown"
  from (
    select * from AwardsPlayers
    where awardid = "Triple Crown"
    OR awardid = 'MVP'
  ) awards
  join  (
    select  distinct * from  Fielding where pos != 'OF'
  ) field ON (field.playerID = awards.playerID)
  WHERE awards.yearID = field.yearID
  AND awards.playerID = field.playerID
  group by  field.teamID;

  +--------+-----------------+
  | teamID | MVP/TripleCrown |
  +--------+-----------------+
  | ANA    |               2 |
  | ARI    |               1 |
  | ATL    |               9 |
  | BAL    |              10 |
  | BOS    |              18 |
  | BRO    |               9 |
  | BSN    |               6 |
  | CAL    |               4 |
  | CHA    |               7 |
  | CHN    |              11 |
  | CIN    |              24 |
  | CLE    |               7 |
  | COL    |               4 |
  | DET    |               8 |
  | HOU    |               2 |
  | KCA    |               2 |
  | LAN    |               8 |
  | LS2    |               1 |
  | MIN    |              11 |
  | ML1    |               2 |
  | ML4    |               5 |
  | NY1    |               8 |
  | NYA    |              34 |
  | NYN    |               1 |
  | OAK    |              12 |
  | PHA    |              15 |
  | PHI    |              10 |
  | PIT    |               9 |
  | PRO    |               5 |
  | SDN    |               2 |
  | SEA    |               5 |
  | SFN    |              17 |
  | SLA    |               1 |
  | SLN    |              24 |
  | TEX    |              11 |
  | TOR    |               6 |
  | WS1    |               7 |
  +--------+-----------------+
```

### 4) Calculate the average batting average, RBIs, and home runs by position ever in major league baseball. Only consider seasons where a player had at least 300 at-bats (AB).

```sql
# Average batting average, RBIs, and home runs by position across MLB.
  select
    fielding.pos,
    AVG(bat.h / bat.AB) AS batting_average,
    AVG(bat.hr) AS Average_HomeRuns,
    AVG(bat.rbi) AS Average_RBI
  from Master players
  JOIN fielding ON (players.playerID = fielding.playerID)
  JOIN Batting bat ON (bat.playerID = players.playerID)
  WHERE bat.ab >= 301
  GROUP BY fielding.pos
  ORDER BY bat.rbi DESC;
  +-----+-----------------+------------------+-------------+
  | pos | batting_average | Average_HomeRuns | Average_RBI |
  +-----+-----------------+------------------+-------------+
  | P   |      0.28330651 |           6.1980 |     60.4212 |
  | OF  |      0.28346289 |          12.2007 |     64.9105 |
  | CF  |      0.27568416 |          14.1634 |     61.3736 |
  | DH  |      0.27807213 |          17.2563 |     70.2555 |
  | 2B  |      0.27309667 |           6.4783 |     53.5728 |
  | LF  |      0.27610233 |          15.2329 |     64.4096 |
  | 3B  |      0.27303266 |           9.9283 |     60.5570 |
  | RF  |      0.27630439 |          16.0473 |     66.5444 |
  | 1B  |      0.28249574 |          13.6744 |     70.6064 |
  | SS  |      0.26798584 |           6.5790 |     53.6738 |
  | C   |      0.27074001 |           9.2821 |     56.3062 |
  +-----+-----------------+------------------+-------------+
  11 rows in set (1.84 sec)
```
### 5) Return all player info for all players that won an MVP and a Gold Glove during their careers, along with the number of times they won each.

```sql
# returning all the players that have won both gold glove and MVP
  select  players.nameFirst, players.nameLast , gg_wins, mvp_wins from (
    SELECT playerID, count(*) AS gg_wins FROM awardsplayers
    WHERE awardID = 'Gold Glove'
    group by playerID
   )awards
  inner join (
    SELECT playerID, count(*) AS mvp_wins FROM awardsplayers awards2
    WHERE awards2.awardID = 'MVP'
    group by playerID
  ) awards2
  on (awards.playerid = awards2.playerid)
  join Master players ON (awards.playerID = players.playerID)
  group by  awards.playerid;
  +-----------+-------------+---------+----------+
  | nameFirst | nameLast    | gg_wins | mvp_wins |
  +-----------+-------------+---------+----------+
  | Hank      | Aaron       |       3 |        1 |
  | Jeff      | Bagwell     |       1 |        1 |
  | Ernie     | Banks       |       1 |        2 |
  | Johnny    | Bench       |      10 |        2 |
  | Barry     | Bonds       |       8 |        7 |
  | Ken       | Boyer       |       5 |        1 |
  | George    | Brett       |       1 |        1 |
  | Ken       | Caminiti    |       3 |        1 |
  | Roberto   | Clemente    |      12 |        1 |
  | Andre     | Dawson      |       8 |        1 |
  | Nellie    | Fox         |       3 |        1 |
  | Steve     | Garvey      |       4 |        1 |
  | Bob       | Gibson      |       9 |        1 |
  | Ken       | Griffey     |      10 |        1 |
  | Rickey    | Henderson   |       1 |        1 |
  | Keith     | Hernandez   |      11 |        1 |
  | Elston    | Howard      |       2 |        1 |
  | Jackie    | Jensen      |       1 |        1 |
  | Barry     | Larkin      |       3 |        1 |
  | Fred      | Lynn        |       4 |        1 |
  | Mickey    | Mantle      |       1 |        3 |
  | Roger     | Maris       |       1 |        2 |
  | Don       | Mattingly   |       9 |        1 |
  | Joe       | Mauer       |       2 |        1 |
  | Willie    | Mays        |      12 |        2 |
  | Willie    | McGee       |       3 |        1 |
  | Joe       | Morgan      |       5 |        2 |
  | Thurman   | Munson      |       3 |        1 |
  | Dale      | Murphy      |       5 |        2 |
  | Dave      | Parker      |       3 |        1 |
  | Dustin    | Pedroia     |       1 |        1 |
  | Terry     | Pendleton   |       3 |        1 |
  | Albert    | Pujols      |       1 |        3 |
  | Cal       | Ripken      |       2 |        2 |
  | Brooks    | Robinson    |      16 |        1 |
  | Frank     | Robinson    |       1 |        2 |
  | Alex      | Rodriguez   |       2 |        3 |
  | Ivan      | Rodriguez   |      13 |        1 |
  | Jimmy     | Rollins     |       3 |        1 |
  | Pete      | Rose        |       2 |        1 |
  | Ryne      | Sandberg    |       9 |        1 |
  | Mike      | Schmidt     |      10 |        3 |
  | Bobby     | Shantz      |       8 |        1 |
  | Ichiro    | Suzuki      |       9 |        1 |
  | Joe       | Torre       |       1 |        1 |
  | Zoilo     | Versalles   |       2 |        1 |
  | Larry     | Walker      |       7 |        1 |
  | Maury     | Wills       |       2 |        1 |
  | Carl      | Yastrzemski |       7 |        1 |
  | Robin     | Yount       |       1 |        2 |
  +-----------+-------------+---------+----------+
  50 rows in set (0.01 sec)
```

### 6) Calculate the number of world series, division titles, and league championships for all teams.

### 7) Calculate the average salary (as a percentage of yearly average) of all MVPs ever in major league baseball.

### 8) Use the statistics available at Baseball-Reference to add Miguel Cabrera's 2012 Triple Crown season to your Database. Make sure to add the appropriate information to all relevant tables.