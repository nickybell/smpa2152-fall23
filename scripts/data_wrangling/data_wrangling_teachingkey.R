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
filter(kn, region == "Mid East")
filter(kn, ticket_sales < 0)
filter(kn, !year %in% 2020:2021)
filter(kn, !year %in% 2020:2021, !is.na(total_expenses))
filter(kn, advertising_licensing > 100000 | media_rights > 100000)

# Test yourself: why does this code return every row? ---------------------
nrow(kn)
x <- filter(kn, TRUE)
nrow(x)


# select() ----------------------------------------------------------------

# select() indicates what *columns* we would like in the data frame
select(kn, school, year, total_expenses:coaches_compensation)
select(kn, -ipeds_id)


# mutate() -----------------------------------------------------------------

# mutate() makes changes to existing columns or adds new columns

kn <- mutate(kn, athletics_profit = total_revenues - total_expenses)
kn2 <- mutate(kn, total_academic_spending = total_academic_spending/10000)
kn2 <- mutate(kn, total_academic_spending = total_academic_spending/10000,
                  total_expenses = total_expenses/10000,
                  total_revenues = total_revenues/10000)
kn2 <- rename(kn2, total_academic_spending_10000 = total_academic_spending,
                   total_expenses_10000 = total_expenses,
                   total_revenues_10000 = total_revenues)

ggplot(kn2) +
  geom_histogram(aes(x = total_academic_spending_10000)) +
  labs(x = "Total Academic Spending ($10,000s)",
       y = "Count",
       title = "Distribution of Total Academic Spending",
       caption  = "Source: Knight-Newhouse Commission") +
  scale_x_continuous(labels = scales::label_comma(prefix = "$")) +
  theme_classic()

arrange(kn2, desc(total_academic_spending_10000))
arrange(kn2, -(total_academic_spending_10000))

# Which schools spend the largest percentage of their athletics budget on coaches compensation?
kn |>
  mutate(perc_coaches = (coaches_compensation/total_expenses)*100) |>
  arrange(desc(perc_coaches)) |>
  slice_head(n = 5)

# possible data entry error
kn |>
  filter(school == "Sam Houston State University") |>
  select(coaches_compensation)

# Try it yourself! --------------------------------------------------------

# Looking only at 2022 (the most recent year in the data), which school spent the most on game_expenses_and_travel and facilities_and_equipment combined?

kn |>
  filter(year == 2022) |>
  mutate(total = game_expenses_and_travel + facilities_and_equipment) |>
  arrange(desc(total)) |>
  slice_head(n = 1)

# Using summarize and group_by --------------------------------------------

# summarize() is used to generate summary statistics, like the mean, for a set of data
# Used on it's own, summarize will produce a new data frame (tibble) summarizing the entire data frame

summarize(kn,
          n = n(),
          mean_profit = mean(athletics_profit, na.rm = TRUE),
          max_expenses = max(total_expenses, na.rm = TRUE))

# summarize() is almost always combined with group_by(), which indicates the groups in the data that we want to learn more about. We may not care about the mean profit of all the schools in the data frame, but maybe we want to compare profit each year.

kn |>
  group_by(year) |>
  summarize(mean_profit = mean(athletics_profit, na.rm = TRUE))

# This is one case where piping into a ggplot is particularly useful. Now we have a data frame of two variables: year and mean_profit. We could save our data as a new object and then write our ggplot code separately. But it's more efficient to use a pipe, like so:

kn |>
  group_by(year) |>
  summarize(mean_profit = mean(athletics_profit, na.rm = TRUE)) |>
  ggplot() +
    geom_line(aes(x = year, y = mean_profit))

# Try it yourself! --------------------------------------------------------

# Make a graph showing the average ratio of athletics spending to academic spending (athletics expenses divided by academic spending) in each region of the country in 2022.
# Hint: break this question down in to parts. What function do you need to get the ratio of athletics spending to academic spending? To get the average by region? To reduce the data frame to 2022? To create a graph?
# Your final answer should something look like this:

source("/cloud/lib/smpa2152-fall23/misc/data-wrangling/try-it-yourself.R")

# Hint: include the argument `stat = "identity"` in your geom_*() function, outside of the aes() function, e.g.
# geom_*(aes(x = foo, y = bar), stat = "identity)


# Joins -------------------------------------------------------------------

# There are two types of joins. The most common of these are merging joins.

# Merging joins are used to bring two data frames together, matching rows in data frame x with rows in data frame y and expanding the number of columns.

# The key to joins are the "keys"! That is the field(s) that match rows together. You can explicitly tell R what fields to join using the by = join_by(key.x == key.y) argument in any of these joins.

# There are four types of merging joins - all of these joins the columns from data frame x to the columns of data frame y. They differ in how they handle *matching* the key in x to the key in y.

# inner_join(x, y): keep only the rows that match in both x and y
# full_join(x, y): keep all the rows in both x and y
# left_join(x, y): keep all the rows in x and the matching rows in y
# right_join(x, y): keep all the rows in y and the matching rows in x

# We can also think of these as a Venn diagram: https://d33wubrfki0l68.cloudfront.net/aeab386461820b029b7e7606ccff1286f623bae1/ef0d4/diagrams/join-venn.png

# Let's practice. Earlier, you loaded the Knight-Newhouse Commission data using the read_csv() function:
kn <- read_csv("data/data-wrangling/knight_newhouse.csv")

# This is the most common way to read data, and it is a pretty powerful function. read_csv() will use the first row as the column names and look at the first 1000 rows of the data to determine each column's class. Generally, it is not necessary to make any adjustments to the default rules, except for one:

kn <- read_csv("data/data-wrangling/knight_newhouse.csv",
               name_repair = "universal")

# name_repair = "universal" will ensure that your column names are syntactically appropriate (e.g.,  no spaces). Fortunately, we do not have any improper column names in this data frame.

# There is an equivalent function for reading excel files, and it requires loading the {readxl} package. Let's use it to load the IPEDS data, which is data the U.S. government collects on every college and university in the country.
library(readxl)
ipeds <- read_excel("data/data-wrangling/ipeds.xlsx")

# These column names are not proper R variable names, so they appear in backticks ` `. Let's repair these names. Note that the argument is slightly different compared to read_csv().

ipeds <- read_excel("data/data-wrangling/ipeds.xlsx",
                    .name_repair = "universal")

# We may still want to modify our column names. We can do so with the tidyverse function rename().

ipeds <-
  ipeds |>
  rename(HBCU = Historically.Black.College.or.University,
         students = Full.time.undergraduates)

# Let's join our ipeds data frame to our kn data frame. What are our joining keys?
glimpse(kn)
glimpse(ipeds)

# What is the effect of the different types of joins?
kn_joined <- inner_join(kn, ipeds, by = join_by(ipeds_id == unitid), suffix = c("_kn", "_ipeds"))

kn_joined <- inner_join(kn, ipeds, by = join_by(ipeds_id == unitid, year == year), suffix = c("_kn", "_ipeds")) # adding year to keys

kn_joined <- left_join(kn, ipeds, by = join_by(ipeds_id == unitid, year == year), suffix = c("_kn", "_ipeds"))

kn_joined <- full_join(kn, ipeds, by = join_by(ipeds_id == unitid, year == year), suffix = c("_kn", "_ipeds"))


# Try it yourself! --------------------------------------------------------

# At which schools does each student pay the largest student fee supporting athletics? The relevant variables are student_fees and students.

inner_join(kn, ipeds, by = join_by(ipeds_id == unitid, year == year), suffix = c("_kn", "_ipeds")) |>
  mutate(fee_per_student = student_fees/students) |>
  arrange(-fee_per_student) |>
  slice_head(n = 5)


# The other type of join is called a filtering join. These joins do not join the columns in data frame y to data frame x; it only determines which rows in x are kept and which are discarded based on the matching keys.

# semi_join(x, y) - includes rows in x that match in y
# anti_join(x, y) - excludes rows in x that match in y

kn_filtered <- semi_join(kn,
                          ipeds |> filter(HBCU == "Yes"),
                          by = join_by(ipeds_id == unitid))

kn_filtered <- anti_join(kn,
                          ipeds |> filter(students < 40000),
                          by = join_by(ipeds_id == unitid))


# Tidy Data ---------------------------------------------------------------

# What is Tidy Data?

# 1. Each variable must have its own column (but wait, isn't a variable a column?)

# 2. Each observation must have its own row (but wait, isn't an observation a row?)

# 3. Each value must have it's own cell (rarely an issue)

# I've found it easier to think about tidy data in terms of `ggplot2`, which loves tidy data. So if you can imagine what a `ggplot()` function requires from the data, and you can reshape your data into the appropriate form, then you probably have tidy data!

# This is easiest to show through examples.
  
# pivot_wider() -----------------------------------------------------------

# Here's what Hadley Wickham, Chief Scientist at Posit (RStudio), says about pivot_wider(): 

# "It’s relatively rare to need pivot_wider() to make tidy data, but it’s often useful for creating summary tables for presentation, or data in a format needed by other tools."

# So the example we'll be using is a bit artificial. 

# We will be working with data on the Billboard Hot 100 charts.

hot100 <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/billboard.csv")

# Let's create a table that shows the top three songs on the Billboard 100 chart for three random weeks. We could have a 9 row table with three columns (Week, Position, Song), but it might look better to have a 3 row table with four columns (Week, Song1, Song2, Song3)

hot100 |>
  mutate(entry = paste(performer, song, sep = " - ")) |>
  filter(week_position <= 3) |>
  pivot_wider(id_cols = week_id,
              names_from = week_position,
              values_from = entry, names_prefix = "Song",
              names_sort = TRUE) |>
  select(week_id, starts_with("Song")) |>
  slice_sample(n = 5)

# Try it yourself! --------------------------------------------------------

# For the week of 2/17/1968, show all the artists that had songs on the chart that week with a table like:

# Sly & The Family Stone  | Elvis Presley  | ...
# Dance To The Music      | Guitar Man     | ...

hot100 |>
  select(week_id, performer, song) |>
  filter(week_id == "2/17/1968") |>
  pivot_wider(names_from = performer, values_from = song)

### `pivot_longer()`

# Let's work with data on political and civil rights around the world from Freedom House (https://freedomhouse.org/explore-the-map?type=fiw&year=2022).

# *1 represents the greatest degree of freedom and 7 the smallest degree of freedom.*
  
fh <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/6efe01516a73c59e613bb15eec80b7a200d561e7/data/2022/2022-02-22/freedom.csv")

# Let's make a graph showing how political and civil freedoms have changed in a country over time.

fh |>
  pivot_longer(cols = c(CL, PR),
               names_to = "category",
               values_to = "score") |>
  filter(country == "Iraq") |>
  ggplot() +
    geom_step(aes(x = year, y = score, color = category)) +
    scale_y_reverse(limits = c(7, 1)) +
    theme_classic() +
    labs(x = "",
         y = "Score",
         caption = "Source: Freedom House; 1 indicates most freedom, 7 least freedom",
         title = "Freedom House Scores Over Time: Iraq",
         color = "Type")


# Try it yourself! --------------------------------------------------------

# How have CL and PR changed worldwide? Find the average CL and PR scores in each year, and plot the change in scores.

fh |>
  group_by(year) |>
  summarize(CL = mean(CL),
            PR = mean(PR)) |>
  pivot_longer(cols = c(CL, PR), names_to = "category", values_to = "score") |>
  ggplot() +
    geom_step(aes(x = year, y = score, color = category)) +
    scale_y_reverse(limits = c(7, 1)) +
    theme_classic() +
    labs(x = "",
         y = "Score",
         caption = "Source: Freedom House; 1 indicates most freedom, 7 least freedom",
         title = "Freedom House Scores Over Time: Worldwide",
         color = "Type")