SELECT teamID,
    SUM(WSWin = 'Y')  as num_world_series_wins,
    SUM(DivWin = 'Y') as num_division_titles,
    SUM(LgWin = 'Y')  as num_League_championships
FROM Teams
GROUP by teamID
ORDER BY num_world_series_wins DESC,
    num_division_titles DESC,
    num_League_championships DESC