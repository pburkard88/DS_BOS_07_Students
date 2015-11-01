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
##### Triple Crown's only - illustrate off by position issue
#     some double counting from having pitchers in there technically
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
   group by  field.pos;
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
    count(awards.awardID)
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

+--------+-----------------------+
| teamID | count(awards.awardID) |
+--------+-----------------------+
| ANA    |                     2 |
| ARI    |                     1 |
| ATL    |                     9 |
| BAL    |                    10 |
| BOS    |                    18 |
| BRO    |                     9 |
| BSN    |                     6 |
| CAL    |                     4 |
| CHA    |                     7 |
| CHN    |                    11 |
| CIN    |                    24 |
| CLE    |                     7 |
| COL    |                     4 |
| DET    |                     8 |
| HOU    |                     2 |
| KCA    |                     2 |
| LAN    |                     8 |
| LS2    |                     1 |
| MIN    |                    11 |
| ML1    |                     2 |
| ML4    |                     5 |
| NY1    |                     8 |
| NYA    |                    34 |
| NYN    |                     1 |
| OAK    |                    12 |
| PHA    |                    15 |
| PHI    |                    10 |
| PIT    |                     9 |
| PRO    |                     5 |
| SDN    |                     2 |
| SEA    |                     5 |
| SFN    |                    17 |
| SLA    |                     1 |
| SLN    |                    24 |
| TEX    |                    11 |
| TOR    |                     6 |
| WS1    |                     7 |
+--------+-----------------------+

```

### 4) Calculate the average batting average, RBIs, and home runs by position ever in major league baseball. Only consider seasons where a player had at least 300 at-bats (AB).
```sql

 select
    field.pos,
    sum(bat.h / bat.AB) AS batting_average,
    bat.hr,
    bat.rbi
  from (

  ) awards
  join  (
    select  distinct * from  Fielding where pos != 'OF'
  ) field ON (field.playerID = awards.playerID)
  WHERE

  group by  field.pos;



### above
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




```
### 5) Return all player info for all players that won an MVP and a Gold Glove during their careers, along with the number of times they won each.

### 6) Calculate the number of world series, division titles, and league championships for all teams.

### 7) Calculate the average salary (as a percentage of yearly average) of all MVPs ever in major league baseball.

### 8) Use the statistics available at Baseball-Reference to add Miguel Cabrera's 2012 Triple Crown season to your Database. Make sure to add the appropriate information to all relevant tables.