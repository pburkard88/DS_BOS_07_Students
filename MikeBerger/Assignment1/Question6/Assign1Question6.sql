/* 
Two problems with my answer:
1. I could not find which table the division titles are listed in
2. I could not figure out to properly join the team table with these results
3. My results must be wrong, because they list many teams as having more World Series wins then League wins, which must be backwards (I noticed this with Red Sox and Yankees)
 */

select SeriesPost.teamIDwinner, SeriesPost.round, Count(SeriesPost.round)
FROM SeriesPost
WHERE  SeriesPost.round Like "%WS%"
Or SeriesPost.round Like "%ALCS%"
Or SeriesPost.round Like "%NLCS%"
Group BY SeriesPost.teamIDwinner, SeriesPost.round