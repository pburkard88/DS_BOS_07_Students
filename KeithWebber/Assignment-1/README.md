# DS_BOS_07 - Assignment-1
## Keith Webber
https://github.com/pburkard88/DS_BOS_07/wiki/Assignment-1
Queries

Use the appropriate SQL queries to find answers to the following questions:

### 1) Find all of the Triple Crown (Award) winners ever in Major League Baseball, with their complete batting stats for the given year. Order the results in descending order first by batting average, then by RBIs, and lastly by home runs.

```sql
# All TC winners excluding pitchers ordered by at rbi,
# Additional complete stats omitted for brevity

# BATTING BY BATTING AVERAGE
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

# PITCHERS BY ERA
  select
    pitch.yearID,
    awards.awardID,
    players.nameFirst,
    players.nameLast,
    pitch.w,
    pitch.l,
    pitch.era,
    pitch.SO
  from Master players
  JOIN AwardsPlayers awards ON (players.playerID = awards.playerID)
  JOIN pitching pitch ON (pitch.playerID = players.playerID)
  WHERE awards.awardID = "Triple Crown" AND awards.yearID = pitch.yearID
  GROUP BY players.playerID, pitch.yearID
  ORDER BY pitch.era DESC;

  +--------+--------------+-----------+-----------+------+------+------+------+
  | yearID | awardID      | nameFirst | nameLast  | w    | l    | era  | SO   |
  +--------+--------------+-----------+-----------+------+------+------+------+
  |   1894 | Triple Crown | Amos      | Rusie     |   36 |   13 | 2.78 |  195 |
  |   2006 | Triple Crown | Johan     | Santana   |   19 |    6 | 2.77 |  245 |
  |   1889 | Triple Crown | John      | Clarkson  |   49 |   19 | 2.73 |  284 |
  |   1924 | Triple Crown | Walter    | Johnson   |   23 |    7 | 2.72 |  158 |
  |   1998 | Triple Crown | Roger     | Clemens   |   20 |    6 | 2.65 |  271 |
  |   1940 | Triple Crown | Bob       | Feller    |   27 |   11 | 2.61 |  261 |
  |   1930 | Triple Crown | Lefty     | Grove     |   28 |    5 | 2.54 |  209 |
  |   2007 | Triple Crown | Jake      | Peavy     |   19 |    6 | 2.54 |  240 |
  |   1934 | Triple Crown | Lefty     | Gomez     |   26 |    5 | 2.33 |  158 |
  |   1937 | Triple Crown | Lefty     | Gomez     |   21 |   11 | 2.33 |  194 |
  |   2002 | Triple Crown | Randy     | Johnson   |   24 |    5 | 2.32 |  334 |
  |   1939 | Triple Crown | Bucky     | Walters   |   27 |   11 | 2.29 |  137 |
  |   1924 | Triple Crown | Dazzy     | Vance     |   28 |    6 | 2.16 |  262 |
  |   1877 | Triple Crown | Tommy     | Bond      |   40 |   17 | 2.11 |  170 |
  |   1999 | Triple Crown | Pedro     | Martinez  |   23 |    4 | 2.07 |  313 |
  |   1931 | Triple Crown | Lefty     | Grove     |   31 |    4 | 2.06 |  175 |
  |   1997 | Triple Crown | Roger     | Clemens   |   21 |    7 | 2.05 |  292 |
  |   1965 | Triple Crown | Sandy     | Koufax    |   26 |    8 | 2.04 |  382 |
  |   1972 | Triple Crown | Steve     | Carlton   |   27 |   10 | 1.97 |  310 |
  |   1920 | Triple Crown | Pete      | Alexander |   27 |   14 | 1.91 |  173 |
  |   1963 | Triple Crown | Sandy     | Koufax    |   25 |    5 | 1.88 |  306 |
  |   1945 | Triple Crown | Hal       | Newhouser |   25 |    9 | 1.81 |  212 |
  |   1884 | Triple Crown | Guy       | Hecker    |   52 |   20 | 1.80 |  385 |
  |   1918 | Triple Crown | Hippo     | Vaughn    |   22 |   10 | 1.74 |  148 |
  |   1888 | Triple Crown | Tim       | Keefe     |   35 |   12 | 1.74 |  335 |
  |   1966 | Triple Crown | Sandy     | Koufax    |   27 |    9 | 1.73 |  317 |
  |   1901 | Triple Crown | Cy        | Young     |   33 |   10 | 1.62 |  158 |
  |   1916 | Triple Crown | Pete      | Alexander |   33 |   12 | 1.55 |  167 |
  |   1985 | Triple Crown | Dwight    | Gooden    |   24 |    4 | 1.53 |  268 |
  |   1905 | Triple Crown | Rube      | Waddell   |   27 |   10 | 1.48 |  287 |
  |   1908 | Triple Crown | Christy   | Mathewson |   37 |   11 | 1.43 |  259 |
  |   1884 | Triple Crown | Charley   | Radbourn  |   59 |   12 | 1.38 |  441 |
  |   1905 | Triple Crown | Christy   | Mathewson |   31 |    9 | 1.28 |  206 |
  |   1918 | Triple Crown | Walter    | Johnson   |   23 |   13 | 1.27 |  162 |
  |   1915 | Triple Crown | Pete      | Alexander |   31 |   10 | 1.22 |  241 |
  |   1913 | Triple Crown | Walter    | Johnson   |   36 |    7 | 1.14 |  243 |
  +--------+--------------+-----------+-----------+------+------+------+------+
  36 rows in set (0.00 sec)

# Think this less interesting since it does not have the most important data, but for completeness:
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
  WHERE awards.awardID = "Triple Crown" AND awards.yearID = bat.yearID
  GROUP BY players.playerID, bat.yearID
  ORDER BY batting_average DESC;
  +--------+--------------+-----------+-------------+-----------------+------+------+
  | yearID | awardID      | nameFirst | nameLast    | batting_average | hr   | rbi  |
  +--------+--------------+-----------+-------------+-----------------+------+------+
  |   1997 | Triple Crown | Roger     | Clemens     |          0.5000 |    0 |    0 |
  |   1894 | Triple Crown | Hugh      | Duffy       |          0.4397 |   18 |  145 |
  |   1887 | Triple Crown | Tip       | O''Neill    |          0.4352 |   14 |  123 |
  |   1901 | Triple Crown | Nap       | Lajoie      |          0.4265 |   14 |  125 |
  |   1925 | Triple Crown | Rogers    | Hornsby     |          0.4028 |   39 |  143 |
  |   1922 | Triple Crown | Rogers    | Hornsby     |          0.4013 |   42 |  152 |
  |   1909 | Triple Crown | Ty        | Cobb        |          0.3770 |    9 |  107 |
  |   1937 | Triple Crown | Joe       | Medwick     |          0.3744 |   31 |  154 |
  |   1933 | Triple Crown | Chuck     | Klein       |          0.3680 |   28 |  120 |
  |   1934 | Triple Crown | Lou       | Gehrig      |          0.3627 |   49 |  165 |
  |   1878 | Triple Crown | Paul      | Hines       |          0.3580 |    4 |   50 |
  |   1942 | Triple Crown | Ted       | Williams    |          0.3563 |   36 |  137 |
  |   1933 | Triple Crown | Jimmie    | Foxx        |          0.3560 |   48 |  163 |
  |   1956 | Triple Crown | Mickey    | Mantle      |          0.3527 |   52 |  130 |
  |   1947 | Triple Crown | Ted       | Williams    |          0.3428 |   32 |  114 |
  |   1967 | Triple Crown | Carl      | Yastrzemski |          0.3264 |   44 |  121 |
  |   1939 | Triple Crown | Bucky     | Walters     |          0.3250 |    1 |   16 |
  |   1966 | Triple Crown | Frank     | Robinson    |          0.3160 |   49 |  122 |
  |   1884 | Triple Crown | Guy       | Hecker      |          0.2975 |    4 |   42 |
  |   1924 | Triple Crown | Walter    | Johnson     |          0.2832 |    1 |   14 |
  |   1894 | Triple Crown | Amos      | Rusie       |          0.2796 |    3 |   26 |
  |   1918 | Triple Crown | Walter    | Johnson     |          0.2667 |    1 |   18 |
  |   1913 | Triple Crown | Walter    | Johnson     |          0.2612 |    2 |   14 |
  |   1945 | Triple Crown | Hal       | Newhouser   |          0.2569 |    0 |   17 |
  |   1918 | Triple Crown | Hippo     | Vaughn      |          0.2396 |    0 |    8 |
  |   1916 | Triple Crown | Pete      | Alexander   |          0.2391 |    0 |    9 |
  |   1905 | Triple Crown | Christy   | Mathewson   |          0.2362 |    2 |   16 |
  |   2007 | Triple Crown | Jake      | Peavy       |          0.2329 |    0 |    7 |
  |   1884 | Triple Crown | Charley   | Radbourn    |          0.2299 |    1 |   37 |
  |   1920 | Triple Crown | Pete      | Alexander   |          0.2288 |    1 |   14 |
  |   1877 | Triple Crown | Tommy     | Bond        |          0.2278 |    0 |   30 |
  |   1985 | Triple Crown | Dwight    | Gooden      |          0.2258 |    1 |    9 |
  |   1901 | Triple Crown | Cy        | Young       |          0.2092 |    0 |   17 |
  |   1889 | Triple Crown | John      | Clarkson    |          0.2061 |    2 |   23 |
  |   1930 | Triple Crown | Lefty     | Grove       |          0.2000 |    2 |   17 |
  |   1937 | Triple Crown | Lefty     | Gomez       |          0.2000 |    0 |    4 |
  |   1931 | Triple Crown | Lefty     | Grove       |          0.2000 |    0 |   12 |
  |   1972 | Triple Crown | Steve     | Carlton     |          0.1966 |    1 |    8 |
  |   1965 | Triple Crown | Sandy     | Koufax      |          0.1770 |    0 |    7 |
  |   1905 | Triple Crown | Rube      | Waddell     |          0.1724 |    0 |   10 |
  |   1915 | Triple Crown | Pete      | Alexander   |          0.1692 |    1 |    8 |
  |   1940 | Triple Crown | Bob       | Feller      |          0.1565 |    2 |   12 |
  |   1908 | Triple Crown | Christy   | Mathewson   |          0.1550 |    0 |   11 |
  |   1924 | Triple Crown | Dazzy     | Vance       |          0.1509 |    2 |   11 |
  |   2002 | Triple Crown | Randy     | Johnson     |          0.1348 |    0 |    8 |
  |   1934 | Triple Crown | Lefty     | Gomez       |          0.1313 |    0 |    4 |
  |   1888 | Triple Crown | Tim       | Keefe       |          0.1271 |    2 |    8 |
  |   1966 | Triple Crown | Sandy     | Koufax      |          0.0763 |    0 |    5 |
  |   1963 | Triple Crown | Sandy     | Koufax      |          0.0636 |    1 |    7 |
  |   1998 | Triple Crown | Roger     | Clemens     |          0.0000 |    0 |    0 |
  |   1999 | Triple Crown | Pedro     | Martinez    |          0.0000 |    0 |    0 |
  |   2006 | Triple Crown | Johan     | Santana     |          0.0000 |    0 |    0 |
  +--------+--------------+-----------+-------------+-----------------+------+------+
  52 rows in set (0.01 sec)



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


### 2) Calculate the number of MVPs and Triple Crown winners by position ever in major league baseball.
```sql
# Triple Crown's only - illustrate off by position issue
# some double counting from having pitchers in there technically
   select
      field.pos,
     count(awards.awardID)
   from (
     select * from AwardsPlayers
     where awardid = "Triple Crown"
   ) awards
   join  (
     select playerid, pos, yearID  from  Fielding
     where pos != 'OF'
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



# complete answer with the MVP and TripleCrown
  select
     field.pos,
    count(awards.awardID),
     awards.awardid
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
  group by  field.pos, awards.awardid;
  +-----+-----------------------+--------------+
  | pos | count(awards.awardID) | awardID      |
  +-----+-----------------------+--------------+
  | 1B  |                    48 | MVP          |
  | 1B  |                     4 | Triple Crown |
  | 2B  |                    18 | MVP          |
  | 2B  |                     4 | Triple Crown |
  | 3B  |                    23 | MVP          |
  | 3B  |                     1 | Triple Crown |
  | C   |                    18 | MVP          |
  | CF  |                    25 | MVP          |
  | CF  |                     2 | Triple Crown |
  | DH  |                    33 | MVP          |
  | LF  |                    26 | MVP          |
  | LF  |                     2 | Triple Crown |
  | P   |                    23 | MVP          |
  | P   |                    36 | Triple Crown |
  | RF  |                    28 | MVP          |
  | RF  |                     1 | Triple Crown |
  | SS  |                    20 | MVP          |
  | SS  |                     6 | Triple Crown |
  +-----+-----------------------+--------------+
  18 rows in set (0.15 sec)

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
  WHERE bat.ab >= 300
  GROUP BY fielding.pos
  ORDER BY batting_average DESC;
  +-----+-----------------+------------------+-------------+
  | pos | batting_average | Average_HomeRuns | Average_RBI |
  +-----+-----------------+------------------+-------------+
  | OF  |      0.28342139 |          12.1901 |     64.8622 |
  | P   |      0.28299173 |           6.1785 |     60.2750 |
  | 1B  |      0.28244747 |          13.6581 |     70.5461 |
  | DH  |      0.27800636 |          17.2363 |     70.1864 |
  | RF  |      0.27627588 |          16.0339 |     66.5003 |
  | LF  |      0.27607382 |          15.2230 |     64.3734 |
  | CF  |      0.27564919 |          14.1535 |     61.3276 |
  | 2B  |      0.27301461 |           6.4693 |     53.5092 |
  | 3B  |      0.27298959 |           9.9138 |     60.4924 |
  | C   |      0.27052215 |           9.2383 |     56.1654 |
  | SS  |      0.26793084 |           6.5721 |     53.6295 |
  +-----+-----------------+------------------+-------------+
  11 rows in set (1.86 sec)
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
  group by  awards.playerid
  order by nameLast;
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
```sql
select  teams.name, ws_wins, lg_wins, div_wins from SeriesPost series
inner Join (
  SELECT teamIDwinner, count(*) AS ws_wins FROM SeriesPost
  WHERE round = 'WS'
  group by teamIDwinner
) ws_winners
on (ws_winners.teamIDwinner = series.teamIDwinner)
inner join (
  SELECT teamIDwinner, count(*) AS div_wins FROM SeriesPost
  WHERE round IN ('NLDS2','NLDS1','ALDS1','ALDS2','AEDIV','AWDIV','NEDIV','NWDIV')
  group by teamIDwinner
) div_winners
on (ws_winners.teamIDwinner = div_winners.teamIDwinner)
inner join (
  SELECT teamIDwinner, count(*) AS lg_wins FROM SeriesPost
  WHERE round IN ('NLCS','ALCS')
  group by teamIDwinner
) lg_winners
on (ws_winners.teamIDwinner = lg_winners.teamIDwinner)
join teams on (series.teamIDwinner = teams.teamid)
group by teams.name, series.teamIDwinner;
+------------------------+---------+---------+----------+
| name                   | ws_wins | lg_wins | div_wins |
+------------------------+---------+---------+----------+
| Anaheim Angels         |       1 |       1 |        1 |
| Arizona Diamondbacks   |       1 |       1 |        2 |
| Atlanta Braves         |       1 |       5 |        6 |
| Baltimore Orioles      |       3 |       5 |        2 |
| Boston Americans       |       7 |       4 |        5 |
| Boston Red Sox         |       7 |       4 |        5 |
| Chicago White Sox      |       3 |       1 |        1 |
| Cincinnati Redlegs     |       5 |       5 |        1 |
| Cincinnati Reds        |       5 |       5 |        1 |
| Cleveland Blues        |       2 |       2 |        4 |
| Cleveland Bronchos     |       2 |       2 |        4 |
| Cleveland Indians      |       2 |       2 |        4 |
| Cleveland Naps         |       2 |       2 |        4 |
| Detroit Tigers         |       4 |       2 |        1 |
| Florida Marlins        |       2 |       2 |        2 |
| Los Angeles Dodgers    |       5 |       5 |        3 |
| Minnesota Twins        |       2 |       2 |        1 |
| New York Highlanders   |      27 |      11 |        9 |
| New York Mets          |       2 |       4 |        3 |
| New York Yankees       |      27 |      11 |        9 |
| Oakland Athletics      |       4 |       6 |        2 |
| Philadelphia Blue Jays |       2 |       5 |        2 |
| Philadelphia Phillies  |       2 |       5 |        2 |
| Philadelphia Quakers   |       2 |       5 |        2 |
| St. Louis Browns       |      10 |       5 |        6 |
| St. Louis Cardinals    |      10 |       5 |        6 |
| St. Louis Perfectos    |      10 |       5 |        6 |
+------------------------+---------+---------+----------+
27 rows in set (0.04 sec)


## Might want to stitch part 1 with part 2

select teams.name, coalesce(lg_wins,0), coalesce(ws_wins, 0), coalesce(div_wins,0) from teams
left outer Join (
  SELECT teamid, count(*) AS w
  s_wins FROM teams
  WHERE WSWin = 'Y'
  group by teamid
) ws_winners
on (ws_winners.teamid = teams.teamid)
 left outer Join (
  SELECT teamid, count(*) AS div_wins FROM teams
  WHERE DivWin = 'y'
  group by teamid
) div_winners
on (teams.teamid = div_winners.teamid)
 left outer Join (
  SELECT teamid, count(*) AS lg_wins FROM teams
  WHERE LgWin = 'y'
  OR WCWin = 'y'
  group by teamid
) lg_winners
on (teams.teamid = div_winners.teamid)
WHERE lg_wins IS NOT NULL
 OR ws_wins IS NOT NULL
 OR div_wins IS NOT NULL
group by teams.name
order by teams.name;


+-------------------------------+---------------------+----------------------+----------------------+
| name                          | coalesce(lg_wins,0) | coalesce(ws_wins, 0) | coalesce(div_wins,0) |
+-------------------------------+---------------------+----------------------+----------------------+
| Anaheim Angels                |                   1 |                    1 |                    1 |
| Arizona Diamondbacks          |                   1 |                    1 |                    4 |
| Atlanta Braves                |                   1 |                    1 |                   16 |
| Baltimore Orioles             |                   1 |                    3 |                    8 |
| Boston Americans              |                   1 |                    7 |                    6 |
| Boston Beaneaters             |                   0 |                    1 |                    0 |
| Boston Bees                   |                   0 |                    1 |                    0 |
| Boston Braves                 |                   0 |                    1 |                    0 |
| Boston Doves                  |                   0 |                    1 |                    0 |
| Boston Red Caps               |                   0 |                    1 |                    0 |
| Boston Red Sox                |                   1 |                    7 |                    6 |
| Boston Rustlers               |                   0 |                    1 |                    0 |
| Brooklyn Bridegrooms          |                   0 |                    1 |                    0 |
| Brooklyn Dodgers              |                   0 |                    1 |                    0 |
| Brooklyn Grooms               |                   0 |                    1 |                    0 |
| Brooklyn Robins               |                   0 |                    1 |                    0 |
| Brooklyn Superbas             |                   0 |                    1 |                    0 |
| California Angels             |                   1 |                    0 |                    3 |
| Chicago Colts                 |                   1 |                    2 |                    5 |
| Chicago Cubs                  |                   1 |                    2 |                    5 |
| Chicago Orphans               |                   1 |                    2 |                    5 |
| Chicago White Sox             |                   1 |                    3 |                    5 |
| Chicago White Stockings       |                   1 |                    2 |                    5 |
| Cincinnati Redlegs            |                   1 |                    5 |                    8 |
| Cincinnati Reds               |                   1 |                    5 |                    8 |
| Cleveland Blues               |                   1 |                    2 |                    7 |
| Cleveland Bronchos            |                   1 |                    2 |                    7 |
| Cleveland Indians             |                   1 |                    2 |                    7 |
| Cleveland Naps                |                   1 |                    2 |                    7 |
| Detroit Tigers                |                   1 |                    4 |                    3 |
| Detroit Wolverines            |                   0 |                    1 |                    0 |
| Florida Marlins               |                   0 |                    2 |                    0 |
| Houston Astros                |                   1 |                    0 |                    7 |
| Houston Colt .45s             |                   1 |                    0 |                    7 |
| Kansas City Royals            |                   1 |                    1 |                    7 |
| Los Angeles Angels            |                   1 |                    0 |                    4 |
| Los Angeles Angels of Anaheim |                   1 |                    0 |                    4 |
| Los Angeles Dodgers           |                   1 |                    5 |                   11 |
| Milwaukee Braves              |                   0 |                    1 |                    0 |
| Milwaukee Brewers             |                   1 |                    0 |                    2 |
| Minnesota Twins               |                   1 |                    2 |                    9 |
| Montreal Expos                |                   1 |                    0 |                    1 |
| New York Giants               |                   0 |                    7 |                    0 |
| New York Gothams              |                   0 |                    7 |                    0 |
| New York Highlanders          |                   1 |                   27 |                   16 |
| New York Mets                 |                   1 |                    2 |                    5 |
| New York Yankees              |                   1 |                   27 |                   16 |
| Oakland Athletics             |                   1 |                    4 |                   14 |
| Philadelphia Athletics        |                   0 |                    5 |                    0 |
| Philadelphia Blue Jays        |                   1 |                    2 |                   10 |
| Philadelphia Phillies         |                   1 |                    2 |                   10 |
| Philadelphia Quakers          |                   1 |                    2 |                   10 |
| Pittsburg Alleghenys          |                   1 |                    5 |                    9 |
| Pittsburgh Pirates            |                   1 |                    5 |                    9 |
| Providence Grays              |                   0 |                    1 |                    0 |
| San Diego Padres              |                   1 |                    0 |                    5 |
| San Francisco Giants          |                   1 |                    0 |                    6 |
| Seattle Mariners              |                   1 |                    0 |                    3 |
| St. Louis Brown Stockings     |                   0 |                    1 |                    0 |
| St. Louis Browns              |                   1 |                   10 |                   10 |
| St. Louis Cardinals           |                   1 |                   10 |                   10 |
| St. Louis Perfectos           |                   1 |                   10 |                   10 |
| Tampa Bay Devil Rays          |                   1 |                    0 |                    1 |
| Tampa Bay Rays                |                   1 |                    0 |                    1 |
| Texas Rangers                 |                   1 |                    0 |                    3 |
| Toronto Blue Jays             |                   1 |                    2 |                    5 |
| Washington Senators           |                   0 |                    1 |                    0 |
+-------------------------------+---------------------+----------------------+----------------------+
67 rows in set (0.05 sec)



```


### 7) Calculate the average salary (as a percentage of yearly average) of all MVPs ever in major league baseball.

```sql
  select Salaries.yearid, avg(Salaries.salary) from Salaries
  inner join (select * from awardsplayers where awardid = 'MVP') awards
  on (Salaries.playerid = awards.playerid)

  group by Salaries.yearid;

  +--------+----------------------+
  | yearid | avg(Salaries.salary) |
  +--------+----------------------+
  |   1981 |        588000.000000 |
  |   1985 |        955487.323529 |
  |   1986 |        927376.785714 |
  |   1987 |        990293.717949 |
  |   1988 |       1204116.611111 |
  |   1989 |       1228326.142857 |
  |   1990 |       1398919.085714 |
  |   1991 |       2196309.542857 |
  |   1992 |       2675301.282051 |
  |   1993 |       2918210.300000 |
  |   1994 |       3515754.351351 |
  |   1995 |       4552983.500000 |
  |   1996 |       4535369.486486 |
  |   1997 |       4962964.891892 |
  |   1998 |       5165828.777778 |
  |   1999 |       6132826.878788 |
  |   2000 |       7094744.968750 |
  |   2001 |       8711546.305556 |
  |   2002 |      10507044.272727 |
  |   2003 |      11488653.281250 |
  |   2004 |      11606673.878788 |
  |   2005 |      13928970.000000 |
  |   2006 |      13211639.464286 |
  |   2007 |      12076845.724138 |
  |   2008 |      14127518.666667 |
  |   2009 |      14163521.777778 |
  +--------+----------------------+
  26 rows in set (0.00 sec)

```

### 8) Use the statistics available at Baseball-Reference to add Miguel Cabrera's 2012 Triple Crown season to your Database. Make sure to add the appropriate information to all relevant tables.

awardsplayers

insert into awardsplayers(playerID, awardID, yearID, lgID, tie, notes) VALUES ('cabremi01', 'Triple Crown', 2012, 'AL', NULL, "");

 batting

insert into Batting (playerID  , yearID , stint , teamID , lgID , G    , G_batting , AB   , R    , H    , 2B   , 3B   , HR   , RBI  , SB   , CS   , BB   , SO   , IBB  , HBP  , SH   , SF   , GIDP , G_old)
Values ('cabremi01', 2012,	29,	'DET',	'AL',	161,	697,	622,	109	,205,	40,	0,	44	,139,	4	,1	,66,	98,	.330, .393,	.606,	.999,	null, null);


Fielding

insert into Fielding (playerID  , yearID , stint , teamID , lgID , POS , G    , GS   , InnOuts , PO   , A    , E    , DP   , PB   , WP   , SB   , CS   , pickoffs , ZR   )
VALUES ('cabremi01',2012,		29,'DET',	'AL',	'3B',	154,	154,	142,	1322.0,	383,	127,	243,	13,	31,	.966,	-10,	0,0)