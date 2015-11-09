# Assignment 02

### **Submitted by Stephen Jung**

___

### What is the exercise?

The goal of the exercise is to combine the scoring and assists statistics  
for every player in the NBA in 2014-2015. A link to the assignment page  
can be found [here](https://github.com/pburkard88/DS_BOS_07/blob/master/Notebooks/04_Intro_to_Web_Scraping.ipynb)

Relevant Links:

- [NBA Scoring 2014-2015](http://espn.go.com/nba/statistics/player/_/stat/scoring-per-game/qualified/false)  
 
- [NBA Assists 2014-2015](http://espn.go.com/nba/statistics/player/_/stat/assists/qualified/false)


### Steps to complete the Assignment

1. Create a function get_cols that retrieves the names of the header columns given a table element (skip   
the ranks, split the positions)  
2. Create a function get_data that retrieves the actual table data given a table element (skip the ranks, split  
 the positions).   
3. You can use either the dict approach or the numpy array approach.
4. Write a python loop to loop through the various pages and call these functions on the appropriate urls   
so that you can retrieve every player (rather than just the top few).  
5. Repeat the above on both the scoring and assists URLs to get a pandas dataframe for both of them.  
Use the pandas.DataFrame.join() function to join your 2 pandas dataframes together and get a total  
 result




              