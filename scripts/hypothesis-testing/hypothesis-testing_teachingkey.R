# File Name: 	  	  hypothesis-testing.R
# File Purpose:  	  Hypothesis Testing
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-11-29


# Introductory Commands ---------------------------------------------------

# Install the "sjstats" package
install.packages("sjstats")

# Load packages
library(tidyverse)
library(sjstats)
library(nbmisc)

# Set options
options(tibble.width = Inf)

# Load the October 2023 ABC News/Ipsos poll: https://ropercenter.cornell.edu/ipoll/study/31120578
poll <- read_csv("data/hypothesis-testing/31120578.csv")

# Types of t-tests ---------------------------------------------------

types_of_t_tests()

# One-sample, one-tailed t-test ---------------------------------------------------

# Do fewer than 40% of respondents approve of President Biden's handling of the economy? (The relevant variable is Q1_c.)

poll |>
  filter(Q1_c %in% c("Approve", "Disapprove")) |>
  count(Q1_c, wt = Weight_PID) |>
  mutate(prop = n/sum(n),
         resp = sum(n),
         moe = 1.96 * sqrt((prop * (1 - prop))/resp))

# First, we need to wrangle our data. To use t-tests, our variable that we are testing with must be numeric (or integer or double).
# A t-test is a test of means (averages) - is the mean of the variable greater than some other value or mean? Different than some other value or mean? So if we want to test a proportion (percentage), we want our variable to be in the form of 1s and 0s. (The mean of a vector of 1s and 0s is the proportion of rows that have a value of 1.)

# H0:
# HA:

poll2 <-
  poll |>
  filter(Q1_c %in% c("Approve", "Disapprove")) |>
  mutate(Q1_c.app = ifelse(Q1_c == "Approve", 1, 0))

weighted_ttest(data = poll2,
               x = Q1_c.app,
               mu = .4,
               weights = Weight_PID,
               alternative = "less")

# Only 37% of respondents overall approve of President Biden's handling of the economy. But do a majority of Independents approve?

# H0:
# HA:

poll2 |>
  filter(QPID == "An Independent") |>
  weighted_ttest(x = Q1_c.app,
                 mu = .5,
                 weights = Weight_PID,
                 alternative = "greater")

# One-sample, two-tailed t-test ---------------------------------------------------

# Is the proportion of respondents who disapprove of President Biden's handling of the economy different than 66% (2 out of 3 respondents)?

# H0:
# HA:

poll2 |>
  mutate(Q1_c.disapp = ifelse(Q1_c == "Disapprove", 1, 0)) |>
  weighted_ttest(x = Q1_c.disapp,
                 mu = .66,
                 weights = Weight_PID)

# Try it yourself! ---------------------------------------------------

# In a recent New York Times survey, only 11% of Biden supporters aged 18-29 said that the economy is "excellent" or "good". Do we find similar results in this survey? Do only 11% of Biden supporters in this age group have a positive view of President Biden's handling of the economy?

# H0:
# HA:

poll2 |>
  filter(ppage %in% c(18:29) & QPID == "A Democrat") |>
  weighted_ttest(x = Q1_c.app,
                 mu = .11,
                 weights = Weight_PID)

# Two-sample, one-tailed t-test ---------------------------------------------------

# We use a two-sample t-test to compare the mean of a variable between two groups. For example, do respondents with lower incomes have a less favorable view of President Biden's handling of the economy than respondents with higher incomes?

poll2 |>
  count(ppinc7, Q1_c, wt = Weight_PID) |>
  group_by(ppinc7) |>
  mutate(prop = n/sum(n),
         resp = sum(n),
         moe = 1.96 * sqrt((prop * (1 - prop))/resp)) |>
  filter(Q1_c == "Approve") |>
  arrange(prop)

# Again, we will need to wrangle our data. There must only be two groups to compare; currently, there are seven income groups.
table(poll2$ppinc7)

poll3 <-
  poll2 |>
  mutate(low_inc = factor(ifelse(ppinc7 != "$150,000 or more", "Low Income", "High Income"), levels = c("Low Income", "High Income")))

# H0:
# HA:

weighted_ttest(Q1_c.app ~ low_inc + Weight_PID,
               poll3,
               alternative = "less")

# Are Democrats more than 50 percentage points more satisfied with President Biden's handling of the economy compared to Republicans?
poll3 |>
  count(QPID, Q1_c, wt = Weight_PID) |>
  group_by(QPID) |>
  mutate(prop = n/sum(n),
         resp = sum(n),
         moe = 1.96 * sqrt((prop * (1 - prop))/resp)) |>
  filter(Q1_c == "Approve")

poll4 <-
  poll3 |>
  filter(QPID %in% c("A Democrat", "A Republican")) |>
  mutate(QPID.f = factor(QPID, levels = c("A Democrat", "A Republican")))

# H0:
# HA:

weighted_ttest(Q1_c.app ~ QPID.f + Weight_PID,
               poll4,
               alternative = "greater",
               mu = .5)

# Two-sample, two-tailed t-test ---------------------------------------------------

# Is there a difference in how men and women evaluate President Biden's handling of the economy?

poll5 <-
  poll2 |>
  mutate(ppgender.f = factor(ppgender, levels = c("Male", "Female")))

# H0:
# HA:

weighted_ttest(Q1_c.app ~ ppgender.f + Weight_PID,
               poll5)


# Try it yourself! --------------------------------------------------------

# The same New York Times poll found a large gap in views of the economy between White and non-White respondents. Do we find a similar gap in views of President Biden's handling of the economy?
table(poll2$ppethm)