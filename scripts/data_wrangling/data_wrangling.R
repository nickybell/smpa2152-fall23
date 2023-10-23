# File Name: 	  	  data_wrangling.R
# File Purpose:  	  Data Wrangling
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-10-02

# In this week's textbook reading, you learned about the six "{dplyr} verbs":
# filter()
# select()
# mutate()
# arrange()
# summarize() and it's best friend group_by()

# You also learned about joining functions, which we will cover next week

# %>% vs. |> --------------------------------------------------------------

# You also learned about the "%>%" (pipe operator), which allows you to string together the functions above. The "%>%" operator was developed by the {tidyverse} team and specifically is part of a package called {magrittr}, and you will see it used a lot. However, in a recent release of base R, the developers added a "native pipe" that operates very similarly to the one you will learn this week. It is written "|>" and it is increasingly being used by R programmers in lieu of "%>%". We will use the native pipe ("|>") in this course.

# The keyboard shortcut for |> is Cmd+Shift+M (or Ctrl+Shift+M on Windows)

# Introductory Commands ---------------------------------------------------

# Load packages
library(tidyverse)

# Set options
options(tibble.width = Inf, scipen = 999)

# Load the data
kn <- read_csv("data/data-wrangling/knight_newhouse.csv")

# filter() ----------------------------------------------------------------

# filter() uses logical statements to indicate what *rows* we would like to *keep* in the data frame
# filter "in", not filter "out"

# Every dplyr verb has the same first argument: the data frame you are working with

# Test yourself: why does this code return every row? ---------------------
nrow(kn)
x <- filter(kn, TRUE)
nrow(x)


# select() ----------------------------------------------------------------

# select() indicates what *columns* we would like in the data frame



# mutate() -----------------------------------------------------------------

# mutate() makes changes to existing columns or adds new columns


# Which schools spend the largest percentage of their athletics budget on coaches compensation?



# Try it yourself! --------------------------------------------------------

# Looking only at 2022 (the most recent year in the data), which school spent the most on game_expenses_and_travel and facilities_and_equipment combined?



# Using summarize and group_by --------------------------------------------

# summarize() is used to generate summary statistics, like the mean, for a set of data
# Used on it's own, summarize will produce a new data frame (tibble) summarizing the entire data frame



# summarize() is almost always combined with group_by(), which indicates the groups in the data that we want to learn more about. We may not care about the mean profit of all the schools in the data frame, but maybe we want to compare profit each year.



# This is one case where piping into a ggplot is particularly useful. Now we have a data frame of two variables: year and mean_profit. We could save our data as a new object and then write our ggplot code separately. But it's more efficient to use a pipe, like so:



# Try it yourself! --------------------------------------------------------

# Make a graph showing the average ratio of athletics spending to academic spending (athletics expenses divided by academic spending) in each region of the country in 2022.
# Hint: break this question down in to parts. What function do you need to get the ratio of athletics spending to academic spending? To get the average by region? To reduce the data frame to 2022? To create a graph?
# Your final answer should something look like this:

source("/cloud/lib/smpa2152-fall23/misc/data-wrangling/try-it-yourself.R")

# Hint: include the argument `stat = "identity"` in your geom_*() function, outside of the aes() function, e.g.
# geom_*(aes(x = foo, y = bar), stat = "identity)
