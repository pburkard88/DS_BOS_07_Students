import urllib2,sys
from bs4 import BeautifulSoup

all_pages = []
for i in ('41', '81', '121'):
    address = ('http://espn.go.com/nba/statistics/player/_/stat/assists/sort/avgMinutes/year/2015/qualified/false/count/' + i)
    html = urllib2.urlopen(address).read()
    soup = BeautifulSoup(html)
    print type(soup)
print all_pages

soup.prettify()[0:1000]


table_div = soup.find(id='my-players-table')
table = table_div.find("table")
table_head = table.find(attrs={"class":'colhead'})
header_cols = table_head.findAll('td')

get_cols = []
for header_col in header_cols:
    val = header_col.string
    if val != 'RK':
        get_cols.append(val)
    if val == 'PLAYER':
        get_cols.append('POSITION')

players_stats_dicts = []
players_stats_array = []
for row in table_rows:
    if row.attrs['class'][0]=='colhead':
        continue
    player_stats = []
    row_cols = row.find_all('td')
    col_vals = []
    player_col = row_cols[1]
    player_name = player_col.find('a').string
    player_position = player_col.contents[1]
    player_position = player_position.split(' ')[1]
    player_stats.append(player_name)
    player_stats.append(player_position)
    for i in range(2, len(row_cols)):
        stat = row_cols[i].string
        player_stats.append(stat)
    players_stats_array.append(player_stats)
    player_stats = dict(zip(get_cols, player_stats))
    players_stats_dicts.append(player_stats)

all_pages = []
for i in ('41', '81', '121'):
    address = ('http://espn.go.com/nba/statistics/player/_/stat/rebounds/year/2015/qualified/false/count' + i)
    html = urllib2.urlopen(address).read()
    soup = BeautifulSoup(html)
    print type(soup)
print all_pages

soup.prettify()[0:1000]

table_div = soup.find(id='my-players-table')
table = table_div.find("table")
table_head = table.find(attrs={"class":'colhead'})
header_cols = table_head.findAll('td')

get_cols = []
for header_col in header_cols:
    val = header_col.string
    if val != 'RK':
        get_cols.append(val)
    if val == 'PLAYER':
        get_cols.append('POSITION')

players_score_dicts = []
players_score_array = []
for row in table_rows:
    if row.attrs['class'][0]=='colhead':
        continue
    player_score = []
    row_cols = row.find_all('td')
    col_vals = []
    player_col = row_cols[1]
    player_name = player_col.find('a').string
    player_position = player_col.contents[1]
    player_position = player_position.split(' ')[1]
    player_score.append(player_name)
    player_score.append(player_position)
    for i in range(2, len(row_cols)):
        stat = row_cols[i].string
        player_score.append(stat)
    players_score_array.append(player_score)
    player_score = dict(zip(get_cols, player_score))
    players_score_dicts.append(player_score)

import pandas as pd
import numpy as np

df_a = pd.DataFrame.from_dict(players_stats_dicts)
df_b = pd.DataFrame.from_dict(players_score_dicts)

pd.merge(df_a, df_b, on=['PLAYER', 'TEAM', 'POSITION', 'MPG', 'GP'], how='outer')


