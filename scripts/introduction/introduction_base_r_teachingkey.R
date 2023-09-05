# Introduction to R and RStudio -------------------------------------------

# Posit Cloud is made up of "projects." Be sure to save a permanent copy of the professor's projects. If you get lost during class, open a new copy of the professor's project to see the latest versions of files.
# The professor has also pre-configured RStudio to certain settings within the course space.

# Script pane
  # Scripts save as .R files

# Console pane
  # This is where the R code is actually run

# Files and Plots panes

# Getting help (Help pane)
?mean # Run this command by pressing Cmd+Return (Mac) or Ctrl+Return(Windows)

# Installing packages (Packages pane)
install.packages("tidyverse")
  # Packages only need to be installed in each project *once*.
  # You will need to install the packages you need in every new project. This is slightly annoying but think of it like each project is a new computer (which it kind of is, on the Cloud back-end).

# Using packages
library(tidyverse) # library() must be run once per R session (e.g., if you restart your R session in this project, you will need to run library() again.)
  
# Environment and History panes
  # You can also use up and down keys to scroll through previously executed commands

# Other useful keyboard shortcuts
  # Cmd + Enter on Mac, Ctrl + Enter on PC to move code form the script to the console.
  # Cmd+Shift+C "comments" highlighted code (Cmd = Ctrl on a PC)
  # Cmd+Shift+R creates a code section
  # Esc
mean(2+2)

# Let's Code! --------------------------------------------------------

# Always include a header at the top of your script as a helpful hint to your future self

# File Name: 	  	  introduction_base_r.R
# File Purpose:  	  Introduction and Base R
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-08-30

# Load packages
library(tidyverse)

# R is a really sophisticated calculator
5 * 7 / 2
sqrt(64)

# R is logical (==, !=, <, >, <=, >=)
  # Note that equals is "==", not "="
  # == means equals
  5 == 6
  (20/4) == 5
  # != means NOT equal
  5 != 6
  (20/4) != 5
  # < is less than
  # > is greater than
  # <= is less than or equal to
  # >= is greater than or equal to
  
  # I write
  # a really long
  # note

# R collects objects using the "assignment operator": <-
  # Why do we not use = for assignment like in other programming languages?
  prof_name <- "Nicholas Bell"
  year <- 2023

# Rules for object names
  # Letters, numbers, ".", and "_"
  # May not start with a number
  # Case-sensitive
  Prof_name
  prof_name
  # Use a consistent style and names that will make sense to "future you" and others

# Objects have a "class" and prefer to interact with other objects of the same class
  # Numeric (also called integer and double)
  class(year)
  # Character
  class(prof_name)
  # Logical
  math_test <- (20/4) == 5
  class(math_test)
  # Factor, datetime, and others


# Once you remove an object, it is gone forever
rm(math_test)
  
# Remove all objects
rm(list=ls())

# What is a vector? -------------------------------------------------------

# Most objects are made up of vectors, and the simplest vectors are created using the c() function (for "combine")
  # All elements of a vector must be of the same class
  pres_name <- c("Joe Biden", "Donald Trump", "Barack Obama")
  pres_name2 <- c("Joe Biden", 2021, "Donald Trump", 2017)  

  # Sequential numbers can be created using ":" or seq()
  num <- c(1,2,3,4,5,6,7,8,9,10)
  num2 <- c(1:10)
  ?seq
  seq(1, 9, by = 2)
  num2

  # Repeat elements of a vector using rep()
  ?rep
  rep("SMPA", 5)
  rep(num, 3)

  # There is a special type of vector element: NA
  march_madness_years <- c(2023, 2022, 2021, NA, 2019, 2018)

# Try it yourself! --------------------------------------------------------
# Create vectors for the weather for every presidential inauguration since 1937. Can you use seq() and rep() to reduce your typing?
# Data at: https://www.weather.gov/lwx/events_Inauguration

year <- seq(2021, 1937, -4) 
pres <- c("Biden",
          "Trump",
          rep("Obama", 2),
          rep("GW Bush", 2),
          rep("Clinton", 2),
          "HW Bush",
          rep("Reagan", 2),
          "Carter",
          rep("Nixon", 2),
          "Johnson",
          "Kennedy",
          rep("Eisenhower", 2),
          "Truman",
          rep("FDR", 3))
temp <- c(42, 48, 45, 28, 35, 36, 34, 40, 51, 7, 55, 28, 42, 35, 38, 22, 44, 49, 38, 35, 29, 33)
  

# Working with vectors.
  # Subset the elements of a vector using [ ]
  pres[3]
  pres[c(3,5,7)]
  pres[1:10]

  # Put "-" before the number or c() to exclude those elements
  pres[-3]
  pres[-c(3,5,7)]

  # To store a subset of an object, use the <- operator
  pres_since_2000 <- pres[1:6]


# What is a function? -----------------------------------------------------

# A function is an operation applied to a vector
  # A function is always followed by ()
  mean(temp)

  # Functions have "arguments", which are options you can apply to your function
  mean(c(2,4,6,NA), na.rm = TRUE)

  # Packages contain functions that you can use in addition to the functions that come pre-built in R
  # To see this in action, let's install the {weathermetrics} package: https://cran.r-project.org/web/packages/weathermetrics/index.html
  install.packages("weathermetrics")
  library(weathermetrics)

  fahrenheit.to.celsius(temp, round = 3)
  
# Data frames --------------------------------------------------------------

# A series of vectors in tabular form is called a data frame (also sometimes called a tibble, a type of data frame). Think Excel spreadsheet, but in R.
  # You can make data frames by hand using data.frame()
  inaugurations <- data.frame(pres, year, temp)
  
  # Some packages also have data pre-installed data frames
  data(newhaven)
  ?newhaven
  
  # We will learn how to read data from .csv files and other sources later in the course.
  
  # There are a few ways to quickly understand what your data frame looks like: View(), summary(), head(), and glimpse(). This last one comes from the tidyverse (remember library(tidyverse) from above?)
  View(inaugurations)
  summary(inaugurations)
  head(inaugurations)
  glimpse(inaugurations)

  # We can subset data frames using [], just like vectors. Because data frames have two dimensions rather than one, our subsets [] need two numbers: [rows, columns]
  inaugurations[18, 2]
  inaugurations[18,]
  inaugurations[,2]
  inaugurations[,c(2, 3)]
  inaugurations[-c(1:10),c(2, 3)]


  # As you can see above, a data frame is just a series of vectors, and we give each of those vectors a name (a header, field name, variable name, column name, whatever you want to call it). You can call a single one of these vectors by name using $.
  inaugurations$temp
  
  

# End of Day 1 ------------------------------------------------------------


# Start of Day 2 ----------------------------------------------------------

options(tibble.width = Inf)
# Let's review some important information from last week's class.
  
# install.packages() vs. library()
  
  # We use install.packages() once in each new project; we use library() once in each session of R
  # This is one reason why we always record our code in the .R script rather than just typing away in the console below
  # But wait: Posit Cloud restored everything from last week when I opened it - my objects, my loaded packages, even my console history. Why bother recording everything if nothing gets lost?
  # Two reasons: when you share your code (e.g., with the professor for an assignment), the other user needs to be able to reproduce your work. Also, if your R session ever restarts, such as when you have a bug, you don't want to lose all your hard work and not know how to recreate it.
  
# The core building block of R is an object, and most objects are vectors.
example <- c("this", "is", "a", "character", "vector")
class(example)
  
  # We can subset vectors using [ ]
    BostonMarathon <- c(1897:2023)
    BostonMarathon[-c(length(1897:1918), length(1897:2020))]
  
# A data frame is a two-dimensional table of vectors
  
  # We subset data frames in two ways: [rows, columns] and $
    year <- c(2018:2023)
    winner <- c("Desiree Linden", "Worknesh Degefa", NA, "Edna Kiplagat", "Peres Jepchirchir", "Hellen Obiri")
    BostonMarathon <- data.frame(year, winner)
    glimpse(BostonMarathon)
    BostonMarathon[,2]
    BostonMarathon[6,]
    BostonMarathon$winner

  # We will talk a lot more about modifying data frames in the data wrangling portion of the course, but there are a few basic tasks you can carry out right now.

    # Adding new columns using $
    BostonMarathon$country <- c("United States", "Ethiopia", NA, rep("Kenya", 3))

    # Modifying a column
    BostonMarathon$winner[is.na(BostonMarathon$winner)] <- "Canceled due to the COVID-19 pandemic"
    note <- "Canceled due to the COVID-19 pandemic"
    BostonMarathon$country[is.na(BostonMarathon$country)] <- note

    # Selecting rows using logical operators
    BostonMarathon[BostonMarathon$country == "Kenya",]

  # Important! Any changes you make need to be saved using an <- operator


# Try it yourself! --------------------------------------------------------

# First, install the "nycflights13" package and load it using library()

# Then, run the following to load the "flights" data frame
data(flights)

# Look at the help file for the data frame you just loaded
?flights

# Explore the data frame using glimpse()


# Now we want to find out how many flights were delayed by 30 minutes or more when departing JFK airport. First, subset the data frame to only those rows where the origin airport is "JFK"


# Now subset the data frame again, to only those rows where the departure delay is greater than or equal to 30.


# Use the nrow() function to get the number of rows in the resulting data frame (flights from JFK with departure delays of at least 30 minutes).


# Create a new column that represents the departure delay in hours rather than minutes (i.e., divide departure delay by 60).


# What is the average departure delay of these flights in hours? Hint: look at the help file for "mean". How can you ask this function to ignore the flights where the departure delay is NA (because the flight was cancelled)?
    

# More Base R Tips and Tricks ---------------------------------------------

# %in% operator
  # Let's say we wanted to limit our data to only the "Big Three" U.S. airlines: American, Delta, and United
  major_airlines <- flights[flights$carrier == c("AA", "DL", "UA"),]
  nrow(major_airlines)
  major_airlines <- flights[flights$carrier %in% c("AA", "DL", "UA"),]
  nrow(major_airlines)
  
# table() for quick checks
  table(flights$month)
  table(flights$month, flights$origin)
  
# & and | for multiple conditions
  flights[flights$dep_delay > 0 & flights$ arr_delay <= 0,]
  flights[flights$dep_delay > 0 | is.na(flights$dep_delay),]

#! for "not" conditions
  # Remember that != is "does not equal"
  flights[flights$month != 2 & flights$day != 8 & flights$day != 9,]
  # We can also use ! to negate entire expressions or functions
  flights[flights$month != 2 & !(flights$day %in% c(8, 9)),]
  flights[!is.na(flights$dep_delay),]

# ifelse for if... else... choices
  flights$late <- ifelse(flights$arr_delay >= 0 & !is.na(flights$arr_delay), TRUE, FALSE)
  prop.table(table(flights$late))
  
# Try it yourself! --------------------------------------------------------
  
# Looking only at airports actually located in New York City (JFK and LGA) and flights that were not cancelled, create a column that is 1 if the flight left on time or early but arrived late and 0 otherwise.
  
dta <- flights[flights$origin %in% c("JFK", "LGA") & !is.na(flights$dep_delay),]
dta$dest_delay <- ifelse(dta$dep_delay <= 0 & dta$arr_delay > 0, 1, 0)

# How many flights left on time or early but arrived late?
table(dta$dest_delay)

# What proportion of flights left on time or early but arrived late?
mean(dta$dest_delay, na.rm = T)