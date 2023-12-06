# File Name: 	  	  desante.R
# File Purpose:  	  Regression example using DeSante (2013)
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-12-3


# Introductory Commands ---------------------------------------------------

# Load packages
library(tidyverse)

# Set options
options(tibble.width = Inf)

# Load the data
dta <- read_csv("data/regression/desante2013_modified.csv")


# Exploratory Data Analysis -----------------------------------------------

ggplot(data = dta) +
  geom_histogram(aes(x = age))

dta |>
  filter(!is.na(race)) |>
  group_by(race) |>
  summarize(allocation = mean(allocation, na.rm = T)) |>
  ggplot() +
  geom_bar(aes(x = race, y = allocation), stat = "identity")

dta |>
  filter(!is.na(work_ethic)) |>
  group_by(work_ethic) |>
  summarize(allocation = mean(allocation, na.rm = T)) |>
  ggplot() +
  geom_bar(aes(x = work_ethic, y = allocation), stat = "identity")


# Linear Regression -------------------------------------------------------

reg1 <- lm(allocation ~ age, data = dta)
summary(reg1)

# Interpretation:

ggplot(data = dta, aes(x = age, y = allocation)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

reg2 <- lm(allocation ~ race + work_ethic, data = dta)
summary(reg2)

# Interpretation:

reg3 <- lm(allocation ~ race + work_ethic + age, data = dta)
summary(reg3)

# Interpretation:

reg4 <- lm(allocation ~ race + work_ethic + age + gender + pid, data = dta)
summary(reg4)

# Interpretation:

dta2 <-
  dta |>
  mutate(pid = relevel(factor(pid), ref = "Independent"))

reg5 <- lm(allocation ~ race + work_ethic + age + gender + pid, data = dta2)
summary(reg5)

# Interpretation: