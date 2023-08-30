# Introduction to R and RStudio -------------------------------------------

# Posit Cloud is made up of "projects." Be sure to save a permanent copy of the professor's projects. If you get lost during class, open a new copy of the professor's project to see the latest versions of files.
# The professor has also pre-configured RStudio to certain settings within the course space.

# Script pane
  # Scripts save as .R files
  # What you do in one session of R does not carry over into the next session of R, so make sure you record everything you do in your script.

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
library(tidyverse) # library() must be run every time you re-open a project to load a package
  
# Environment and History panes
  # You can also use up and down keys to scroll through previously executed commands

# Other useful keyboard shortcuts
  # Cmd+Shift+C "comments" highlighted code (Cmd = Ctrl on a PC)
  # Cmd+Shift+R creates a code section
  # Esc


# Let's Code! --------------------------------------------------------

# Alwasy include a header at the top of your script as a helpful hint to your future self

# File Name: 	  	  introduction_base_r.R
# File Purpose:  	  Introduction and Base R
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-08-30

# Load packages
library(tidyverse)

# R is a really sophisticated calculator


# R is logical (==, !=, <, >, <=, >=)
  # Note that equals is "==", not "="


# R collects objects using the "assignment operator": <-
  # Why do we not use = for assignment like in other programming langauges?


# Rules for object names
  # Letters, numbers, ".", and "_"
  # May not start with a number
  # Case-sensitive
  # Use a consistent style and names that will make sense to "future you" and others

# Objects have a "class" and prefer to interact with other objects of the same class
  # Numeric (also called integer and double)
  
  # Character
  
  # Logical
  
  # Factor, datetime, and others


# Once you remove an object, it is gone forever

# Remove all objects
rm(list=ls())

# What is a vector? -------------------------------------------------------

# Most objects are made up of vectors, and the simplest vectors are created using the c() function (for "combine")
  # All elements of a vector must be of the same class

  # Sequential numbers can be created using ":" or seq()
  ?seq

  # Repeat elements of a vector using rep()
  ?rep

  # There is a special type of vector element: NA

# Try it yourself! --------------------------------------------------------
# Create vectors for the weather for every presidential inauguration since 1937. Can you use seq() and rep() to reduce your typing?
# Data at: https://www.weather.gov/lwx/events_Inauguration


# Working with vectors.
  # Subset the elements of a vector using [ ] 

  # Put "-" before the number or c() to exclude those elements

  # To store a subset of an object, use the <- operator


# What is a function? -----------------------------------------------------

# A function is an operation applied to a vector
  # A function is always followed by ()

  # Functions have "arguments", which are options you can apply to your function

  # Packages contain functions that you can use in addition to the functions that come pre-built in R
  # To see this in action, let's install the {weathermetrics} package: https://cran.r-project.org/web/packages/weathermetrics/index.html
  
  

# Data frames --------------------------------------------------------------

# A series of vectors in tabular form is called a data frame (also sometimes called a tibble, a type of data frame). Think Excel spreadsheet, but in R.
  # You can make data frames by hand using data.frame()
  
  # Some packages also have data pre-installed data frames
  data(newhaven)
  
  # We will learn how to read data from .csv files and other sources later in the course.


  # We can subset data frames using [], just like vectors. Because data frames have two dimensions rather than one, our subsets [] need two numbers: [rows, columns]


  # As you can see above, a data frame is just a series of vectors, and we give each of those vectors a name (a header, field name, variable name, column name, whatever you want to call it). You can call a single one of these vectors by name using $.


  # There are a few ways to quickly understand what your data frame looks like: View(), summary(), head(), and glimpse(). This last one comes from the tidyverse (remember library(tidyverse) from above?)

  # We will talk a lot more about modifying data frames in the data wrangling portion of the course, but there are a few basic tasks you can carry out right now.

    # Adding new columns using $

    # Modifying a column

    # Selecting rows using logical operators

  # Important! Any changes you make need to be saved as an object using an <- operator


# Try it yourself! --------------------------------------------------------

# First, install the "nycflights13" package and load it using library()

# Then, run the following to load the "flights" data frame:
data(flights)

# Look at the help file for the data frame you just loaded:
?flights

# Explore the data frame using one of the commands we learned above


# Now we want to find out how many flights were delayed by 30 minutes or more when departing JFK airport. First, subset the data frame to only those rows where the origin airport is "JFK"


# Now subset the data frame again, to only those rows where the departure delay is greater than or equal to 30.


# Use the nrow() function to get the number of rows in the resulting data frame (flights from JFK with departure delays of at least 30 minutes).


# Create a new column that represents the departure delay in hours rather than minutes (i.e., divide departure delay by 60).


# What is the average departure delay of these flights in hours? Hint: look at the help file for "mean". How can you ask this function to ignore the flights where the departure delay is NA (because the flight was cancelled).

