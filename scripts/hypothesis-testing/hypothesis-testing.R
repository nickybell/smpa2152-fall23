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
poll <- read_csv("data/31120578.csv")

# Types of t-tests ---------------------------------------------------

types_of_t_tests()

# One-sample, one-tailed t-test ---------------------------------------------------

# Do fewer than 40% of respondents approve of President Biden's handling of the economy? (The relevant variable is Q1_c.)



# First, we need to wrangle our data. To use t-tests, our variable that we are testing with must be numeric (or integer or double).
# A t-test is a test of means (averages) - is the mean of the variable greater than some other value or mean? Different than some other value or mean? So if we want to test a proportion (percentage), we want our variable to be in the form of 1s and 0s. (The mean of a vector of 1s and 0s is the proportion of rows that have a value of 1.)

# H0:
# HA:



# Only 37% of respondents overall approve of President Biden's handling of the economy. But do a majority of Independents approve?

# H0:
# HA:



# One-sample, two-tailed t-test ---------------------------------------------------

# Is the proportion of respondents who disapprove of President Biden's handling of the economy different than 66% (2 out of 3 respondents)?

# H0:
# HA:



# Try it yourself! ---------------------------------------------------

# In a recent New York Times survey, only 11% of Biden supporters aged 18-29 said that the economy is "excellent" or "good". Do we find similar results in this survey? Do only 11% of Biden supporters in this age group have a positive view of President Biden's handling of the economy?

# H0:
# HA:


# Two-sample, one-tailed t-test ---------------------------------------------------

# We use a two-sample t-test to compare the mean of a variable between two groups. For example, do respondents with lower incomes have a less favorable view of President Biden's handling of the economy than respondents with higher incomes?


# Again, we will need to wrangle our data. There must only be two groups to compare; currently, there are seven income groups.
table(poll2$ppinc7)


# H0:
# HA:



# Are Democrats more than 50 percentage points more satisfied with President Biden's handling of the economy compared to Republicans?


# H0:
# HA:


# Two-sample, two-tailed t-test ---------------------------------------------------

# Is there a difference in how men and women evaluate President Biden's handling of the economy?


# H0:
# HA:



# Try it yourself! --------------------------------------------------------

# The same New York Times poll found a large gap in views of the economy between White and non-White respondents. Do we find a similar gap in views of President Biden's handling of the economy?
table(poll2$ppethm)