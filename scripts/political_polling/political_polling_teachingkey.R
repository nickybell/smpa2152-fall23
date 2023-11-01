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
ggplot(poll) +
  geom_histogram(aes(x = weight), binwidth = .2) +
  scale_x_continuous(limits = c(0, 30)) +
  geom_vline(xintercept = 1, color = "red", linetype = "dashed")

ggplot(poll) +
  geom_boxplot(aes(x = sex, y = weight))

ggplot(poll) +
  geom_boxplot(aes(x = age10, y = weight))

ggplot(poll) +
  geom_boxplot(aes(x = qraceai, y = weight))

ggplot(poll) +
  geom_boxplot(aes(x = educcoll, y = weight))

# Can we explore a little bit about our outliers?

poll |>
  select(sex, age10, qraceai, educcoll, weight) |>
  arrange(-weight) |>
  slice_head(n = 10)

# Using just the tidyverse, we can generate both the unweighted and weighted presidential vote:

poll |>
  filter(!is.na(pres)) |>
  count(pres) |>
  mutate(prop = n/sum(n))

poll |>
  filter(!is.na(pres)) |>
  count(pres, wt = weight) |>
  mutate(prop = n/sum(n))

# We can also use the tidyverse to get the weighted results by different groups (called a crosstab) by adding a group_by() function.

issue <- 
  poll |>
  filter(!is.na(pres) & !is.na(issue20)) |>
  count(issue20, pres, wt = weight) |>
  group_by(issue20) |>
  mutate(prop = n/sum(n))

ggplot(issue) +
    geom_bar(aes(x = issue20, y = prop, fill = pres), stat = "identity", position = "dodge") +
    scale_y_continuous(labels = scales::percent_format()) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Try it yourself! --------------------------------------------------------

# How did the "late-breaking" vote (voters who make up their mind in the last week) compare to those who decided on their vote before that? The relevant variable is time16mo. Generate a weighted crosstab of the presidential vote by this variable and plot the vote shares of Joe Biden and Donald Trump among these two groups.

poll |>
  filter(!is.na(pres) & !is.na(time16mo) & time16mo != "Omit") |>
  count(time16mo, pres, wt = weight) |>
  group_by(time16mo) |>
  mutate(prop = n/sum(n)) |>
  filter(pres %in% c("Joe Biden", "Donald Trump")) |>
  ggplot() +
    geom_bar(aes(x = time16mo, y = prop, fill = pres), stat = "identity", position = "dodge") +
    scale_y_continuous(labels = scales::percent_format())

# When we present survey results, we always want to show our uncertainty. Let's calculate the margin of error for these results and add it to our graph.

latebreak <- 
  poll |>
  filter(!is.na(pres) & !is.na(time16mo) & time16mo != "Omit") |>
  count(time16mo, pres, wt = weight) |>
  group_by(time16mo) |>
  mutate(prop = n/sum(n),
         resp = sum(n),
         moe = 1.96 * sqrt((prop * (1 - prop))/resp)) 

ggplot(latebreak) +
  geom_bar(aes(x = time16mo, y = prop, fill = pres), stat = "identity", position = "dodge") +
  geom_errorbar(aes(x = time16mo, ymin = prop-moe, ymax = prop+moe, group = pres), position = position_dodge(.9), width = .2) +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(x = "When Voter Decided",
       y = "Percent of Vote",
       fill = "Candidate",
       title = "Late-breaking Votes Swung Towards Donald Trump in 2020",
       caption = "Source: 2020 National Election Pool exit poll.") +
  theme_classic() +
  theme(plot.title = element_text(hjust = .5))

# Try it yourself! --------------------------------------------------------

# Plot the vote choices of voters who voted by mail, voted early in-person, and voted on election day (the relevant variable is votemeth). Show the margin of error on your plot.

votemethod <- 
  poll |>
  filter(!is.na(pres) & !is.na(votemeth)) |>
  count(votemeth, pres, wt = weight) |>
  group_by(votemeth) |>
  mutate(prop = n/sum(n),
         resp = sum(n),
         moe = 1.96 * sqrt((prop * (1 - prop))/resp)) 

ggplot(votemethod) +
  geom_bar(aes(x = votemeth, y = prop, fill = pres), stat = "identity", position = "dodge") +
  geom_errorbar(aes(x = votemeth, ymin = prop-moe, ymax = prop+moe, group = pres), position = position_dodge(.9), width = .2) +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(x = "Vote Method",
       y = "Percent of Vote",
       fill = "Candidate",
       title = "Biden and Trump Voters Used Different Voting Methods",
       caption = "Source: 2020 National Election Pool exit poll.") +
  theme_classic() +
  theme(plot.title = element_text(hjust = .5))
