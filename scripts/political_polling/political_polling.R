# File Name: 	  	  political_polling.R
# File Purpose:  	  Political Polling
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-10-31

# Load the tidyverse and set options
library(tidyverse)
options(tibble.width = Inf)


# Exit Polls --------------------------------------------------------------

# Today, we will learn how to use weights to help ensure that our survey samples are representative of the population. To demonstrate, we will use data from the 2020 National Election Pool (ABC News, CBS, CNN, NBC) exit poll that you may have seen watching telecasts of the election results. Exit polls are a good example of using weights because it is very difficult to generate a truly random sample of U.S. voters.
# - Exit polls are taken at select precincts across the United States. Are these precincts representative of the state/country as a whole?
# - Exit polls are traditionally conducted by approaching every nth voter leaving the polling place. Are these participants representative of voters as a whole?
# - In 2020, in-person exit polls were combined with telephone interviews due to the ubiquity of early voting and vote-by-mail. Could different survey methods yield different types of selection bias?

# Download the 2020 National Election Pool exit poll results from Roper iPoll and load the data in R: https://doi.org/10.25940/ROPER-31119913

poll <- read_csv("data/31119913_National2020.csv")


# Survey Weights ----------------------------------------------------------

# Let's begin by doing a little exploratory data analysis on the survey weights used in this poll. What does the distribution of weights look like?


# Can we explore a little bit about our outliers?



# Using just the tidyverse, we can generate both the unweighted and weighted presidential vote:



# We can also use the tidyverse to get the weighted results by different groups (called a crosstab) by adding a group_by() function.



# Try it yourself! --------------------------------------------------------

# How did the "late-breaking" vote (voters who make up their mind in the last week) compare to those who decided on their vote before that? The relevant variable is time16mo. Generate a weighted crosstab of the presidential vote by this variable and plot the vote shares of Joe Biden and Donald Trump among these two groups.



# When we present survey results, we always want to show our uncertainty. Let's calculate the margin of error for these results and add it to our graph.



# Try it yourself! --------------------------------------------------------

# Plot the vote choices of voters who voted by mail, voted early in-person, and voted on election day (the relevant variable is votemeth). Show the margin of error on your plot.


