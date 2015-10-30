# DataScience Boston Winter 2015 (DS_BOS_07)
https://github.com/pburkard88/DS_BOS_07/wiki/Assignment-1
Queries

Use the appropriate SQL queries to find answers to the following questions:

Find all of the Triple Crown (Award) winners ever in Major League Baseball, with their complete batting stats for the given year. Order the results in descending order first by batting average, then by RBIs, and lastly by home runs.
    ```
      # All TC winners including pitchers ordered by at batting average
      select players.nameFirst, players.nameLast, sum(bat.h / bat.AB) AS batting_average, bat.*, COUNT(*) from Master players
      JOIN AwardsPlayers awards ON (players.playerID = awards.playerID)
      JOIN Batting bat ON (bat.playerID = players.playerID)
      WHERE awards.awardID = "Triple Crown" AND awards.yearID = bat.yearID
      GROUP BY (players.playerID) ORDER BY sum(bat.h / bat.AB) DESC;

      *************************** 1. row ***************************
           nameFirst: Walter
            nameLast: Johnson
      batting_average: 0.8111
            playerID: johnswa01
              yearID: 1913
               stint: 1
              teamID: WS1
                lgID: AL
                   G: 54
           G_batting: 54
                  AB: 134
                   R: 12
                   H: 35
                  2B: 5
                  3B: 6
                  HR: 2
                 RBI: 14
                  SB: 2
                  CS: NULL
                  BB: 5
                  SO: 14
                 IBB: NULL
                 HBP: 1
                  SH: 1
                  SF: NULL
                GIDP: NULL
               G_old: 54
            COUNT(*): 3
      *************************** 2. row ***************************
           nameFirst: Rogers
            nameLast: Hornsby
      batting_average: 0.8041
      ```
      ```
      # All TC winners including pitchers ordered by at batting average
      select players.nameFirst, players.nameLast, sum(bat.h / bat.AB) AS batting_average, bat.*, COUNT(*) from Master players
      JOIN AwardsPlayers awards ON (players.playerID = awards.playerID)
      JOIN Batting bat ON (bat.playerID = players.playerID)
      WHERE awards.awardID = "Triple Crown" AND awards.yearID = bat.yearID
      GROUP BY (players.playerID) ORDER BY sum(bat.h / bat.AB) ;
    ```


Calculate the number of MVPs and Triple Crown winners by position ever in major league baseball.

Calculate the number of MVPs and Triple Crown winners by team ever in major league baseball.

Calculate the average batting average, RBIs, and home runs by position ever in major league baseball. Only consider seasons where a player had at least 300 at-bats (AB).

Return all player info for all players that won an MVP and a Gold Glove during their careers, along with the number of times they won each.

Calculate the number of world series, division titles, and league championships for all teams.

Calculate the average salary (as a percentage of yearly average) of all MVPs ever in major league baseball.

Use the statistics available at Baseball-Reference to add Miguel Cabrera's 2012 Triple Crown season to your Database. Make sure to add the appropriate information to all relevant tables.