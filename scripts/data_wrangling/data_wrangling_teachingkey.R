# File Name: 	  	  data_wrangling.R
# File Purpose:  	  Data Wrangling
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-10-02

# In this week's textbook reading, you learned about the "dplyr verbs":
# filter()
# summarize() and it's best friend group_by()
# arrange()
# mutate()
# select()
# rename()
# joining functions (next week)

# %>% vs. |> --------------------------------------------------------------

# You also learned about the "%>%" (pipe operator), which allows you to string together the functions above. The "%>%" operator was developed by the {tidyverse} team and specifically is part of a package called {magrittr}, and you will see it used a lot. However, in a recent release of base R, the developers added a "native pipe" that operates very similarly to the one you will learn this week. It is written "|>" and it is increasingly being used by R programmers in lieu of "%>%". We will use the native pipe ("|>") in this course.

# The keyboard shortcut for |> is Cmd+Shift+M (or Ctrl+Shift+M on Windows)

# Introductory Commands ---------------------------------------------------

# Load packages
library(tidyverse)

# Set options
options(tibble.width = Inf)

# Load the data
kn <- read_csv("data/data-wrangling/knight_newhouse.csv")


# Using filter ------------------------------------------------------------

# Let's start by glimpsing our data
glimpse(nyc_marathon)

# It might also be helpful to view the helpfile for the data
?nyc_marathon

# Every dplyr verb has the same first argument: the dataset you are working with
# Filter then accepts an unlimited number of logical conditions
filter(nyc_marathon, year >= 2000)
filter(nyc_marathon, year >= 2000 & division == "Women")

# Let's filter to only rows that contain the course record
filter(nyc_marathon, note == "Course record")

# And let's plot the change in course record over time
filter(nyc_marathon, note == "Course record") %>%
  ggplot(aes(x = year, y = time, color = division)) +
  geom_line() +
  geom_point() +
  geom_text_repel(aes(x = year, y = time, label = name))


# Using summarize and group_by --------------------------------------------

# How many races have been run?
summarize(nyc_marathon, n = n())

# What is the average running time of the winner? In each division?
summarize(nyc_marathon, mean_running_time = mean(time_hrs, na.rm = T))

group_by(nyc_marathon, division) %>%
  summarize(mean_running_time = mean(time_hrs, na.rm = T))

filter(nyc_marathon, year >= 2000) %>%
  group_by(division) %>%
  summarize(mean_running_time = mean(time_hrs, na.rm = T))

# Try it yourself! --------------------------------------------------------

# Using group_by and summarize, find the number of times that each country that has won the marathon and generate a nicely-formatted plot. (Hint: you'll need to look at the cheatsheet to identify the right summary variable)
# If using geom_bar, you'll need stat = "identity"

group_by(nyc_marathon, country) %>%
  summarize(wins = n()) %>%
  filter(!is.na(country)) %>%
  ggplot() +
  geom_bar(aes(x = reorder(country, wins, decreasing = TRUE), y = wins), stat = "identity") +
  labs(x = "Country",
       y = "Number of Wins",
       title = "Number of NYC Marathon Victories by Country",
       caption = "Source: openintro package") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        plot.title = element_text(hjust = .5))

count(nyc_marathon, country)


# Using arrange -----------------------------------------------------------

group_by(nyc_marathon, country) %>%
  summarize(wins = n()) %>%
  arrange(desc(wins)) %>%
  filter(!is.na(country))


# Introducing the slice functions -----------------------------------------

group_by(nyc_marathon, country) %>%
  summarize(wins = n()) %>%
  slice_max(wins, n = 5)
# slice_min
# slice_head
# slice_tail
# slice_sample


# Using mutate ------------------------------------------------------------

# A marathon is 26.3 miles. Create a column for each runner's speed in miles per hour.

nyc_marathon %>%
  mutate(speed = 26.3/time_hrs)

# What is the average speed in each division?
nyc_marathon %>%
  mutate(speed = 26.3/time_hrs) %>%
  group_by(division) %>%
  summarize(speed = mean(speed, na.rm = T))

# Plot the change in speed in miles per hour over time for each division.

nyc_marathon %>%
  mutate(speed = 26.3/time_hrs) %>%
  ggplot(aes(x = year, y = speed, color = division)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  labs(x = "Year",
       y = "Running Time in Hours",
       color = "Division",
       title = "Running Times of NYC Marathon, 1970 - 2020",
       caption = "Source: openintro package") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = .5))

# What might have happened in 2020? Should we remove this case from the analysis?


# Try it yourself! --------------------------------------------------------

# First, filter the dataset to remove missing data (why is there missing data?) and then find the winning percentage of each country using group_by, summarize, and mutate (hint: you'll use two summary functions!)
# Find the top 3 countries by winning percentage

nyc_marathon %>%
  group_by(country) %>%
  summarize(wins = n()) %>%
  mutate(win_pct = wins/sum(wins)) %>%
  slice_max(win_pct, n = 3)

# Now do the same thing, but separate the results by division.

nyc_marathon %>%
  group_by(division, country) %>% # The order matters! Slice_max by the highest win_pct in the first category
  summarize(wins = n()) %>%
  mutate(win_pct = wins/sum(wins)) %>%
  slice_max(win_pct, n = 3)


# Using select and rename -------------------------------------------------

# Select chooses columns
?select

# Rename: new name = old name

