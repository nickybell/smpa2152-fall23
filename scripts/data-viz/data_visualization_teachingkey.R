# File Name: 	  	  Week2.R
# File Purpose:  	  Data Visualization I
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-02-05

# Check and set the working directory for the local ("your") computer
getwd()
setwd("~/SMPA2152")

# Load packages (install them first if necessary)
library(tidyverse)
library(nycflights13)
library(palmerpenguins)

# We're going to jump right into making graphs using ggplot2

# A ggplot function always contains these elements, at minimum:
	# ggplot() function: indicates the dataframe to use
	# geom_() function: indicates the type of graph to build
		# The geom_() function includes a mapping to an AESthetic:
		# e.g., geom_line(mapping = aes(x = distance, y = time))
	# The lines are connected with a '+' sign

# Everything else in the ggplot code is about customizing your graph. In particular, in this class we are going to learn about the following customizations:
	# aesthetics: these go inside the aes() function, and allow you to use visual elements that vary along with the data (such as coloring Democrats blue and Republicans red)
	# scale_() functions: change the way that data is displayed, such as expanding or contracting the axes, or changing the number of tick marks
	# labs() function: for adding data labels and titles
  # theme() functions: these change the visual appearance of your graph that have nothing to do with the data itself, such as font size, legend position, etc.
  # facets: for displaying different sets of data (e.g. Democrats and Republicans) as two separate graphs side-by-side

# An example:
data(flights)
flights <- flights[flights$carrier %in% c("AA", "DL", "UA"),] # major airlines only
ggplot(data = flights) +
  geom_point(mapping = aes(x = dep_delay, y = arr_delay, color = origin)) +
  scale_x_continuous(limits = c(-90, 90)) +
  scale_y_continuous(limits = c(-90, 90)) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 0) +
  facet_wrap(~ carrier) +
  theme_bw()
  
# There is so much more to explore in ggplot2. A couple of resources I recommend:
	# The cheatsheet that comes with RStudio
	# The R Graphics Cookbook: https://r-graphics.org/

# Okay, let's get started. When you are making a graph, the first thing to think about is the type of data you are working with: discrete or continuous.
	# Discrete variables do not exist on the number line; they are categories
	# Continuous variables exist on the number line; they are numbers
  # Not all numbers are continuous! e.g.,
  table(flights$month)
  # when this happens, you should convert your numbers to categories using as.factor()
  flights$month_categories <- as.factor(flights$month)
  head(flights$month_categories)
  
# The second thing to think about is how many variables you are graphing: univariate (one variable) or multivariate (2+ variables)?
  
# Today we will be using the "penguins" data from the {palmerpenguins} package that you are also using for your homework.
  
# Univariate Graphs -------------------------------------------------------

# Univariate graph, discrete variable: bar graph

ggplot(data = penguins) +
	geom_bar(mapping = aes(x = species))
  
  # If you are plotting a single statistic rather than a count:
  table(penguins$species)
  peng2 <- data.frame(species = c("Adelie", "Chinstrap", "Gentoo"),
                      count = c(152, 68, 124))
  
  ggplot(data = peng2) +
    geom_bar(mapping = aes(x = species, y = count), stat = "identity")

# Univariate graph, continuous variable: histogram

ggplot(data = penguins) +
	geom_histogram(mapping = aes(x = flipper_length_mm), binwidth = 10)

# Try it yourself! --------------------------------------------------------

# The data consists of three study years. How many penguins are studied in each year?

ggplot(data = penguins) +
	geom_bar(aes(x = year))

ggplot(data = penguins) +
	geom_bar(aes(x = as.factor(year))) # Are years a numeric or categorical variable? Let's consider some examples.

ggplot(data = penguins[penguins$year %in% c(2007, 2009),]) +
	geom_bar(aes(x = year))

ggplot(data = penguins[penguins$year %in% c(2007, 2009),]) +
	geom_bar(aes(x = as.factor(year)))

# Create the same graph, but using a custom data frame (3 rows, 3 columns) with a column called "count" that is the number of penguins studied in each year.
table(penguins$year)
peng2 <- data.frame(year = c(2007:2009),
                    count = c(110, 114, 120))
ggplot(data = peng2) +
  geom_bar(aes(x = year, y = count), stat = "identity")

# Multivariate Graphs -----------------------------------------------------

# 2 discrete variables

# What species of penguins live on each island?

ggplot(data = penguins) +
	geom_bar(aes(x = island, fill = species), position = "dodge") +
	scale_fill_discrete(type = c("aquamarine", "seagreen", "salmon"))

# 1 discrete variable, 1 continuous variable

# How does bill length (in centimeters) differ by penguins' sex?

ggplot(data = penguins[!is.na(penguins$sex),]) +
	geom_boxplot(aes(x = sex, y = bill_length_mm/10)) +
	scale_y_continuous(limits = c(0, NA)) +
	labs(x = "Sex",
			 y = "Bill Length (cm)",
			 title = "Penguin Bill Length (cm) by Sex",
			 caption = "Source: palmerpenguins package")

# 2 continuous variables

# Are flipper length and body mass (kg) related?

ggplot(data = penguins) +
	geom_point(aes(x = flipper_length_mm, y = body_mass_g/1000)) +
	scale_y_continuous(limits = c(0, NA)) +
	geom_smooth(aes(x = flipper_length_mm, y = body_mass_g/1000), method = "lm")

# Let's add in a third variable

ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g/1000, color = species)) +
	geom_point() +
	scale_y_continuous(limits = c(0, NA)) +
	geom_smooth(method = "lm") +
	labs(x = "Flipper Length (mm)",
			 y = "Body Mass (kg)",
			 color = "Species",
			 title = "Body Mass and Flipper Length Are Related") +
	theme_minimal(base_size = 10) +
	theme(legend.position = "bottom",
				plot.title = element_text(hjust = .5)) +
	facet_wrap(~ species, nrow = 1)


# Try it yourself! --------------------------------------------------------

# Make a graph with 4 variables: How are bill length and bill depth related, for both sexes of penguins, on each island?

ggplot(data = penguins[!is.na(penguins$sex),], aes(x = bill_length_mm,
																									 y = bill_depth_mm,
																									 color = sex)) +
	geom_point(alpha = .2) +
	geom_smooth(method = "lm") +
	scale_color_discrete(type = c("palegreen4", "steelblue4")) +
	scale_y_continuous(limits = c(0, NA)) +
	labs(x = "Bill Length (mm)",
			 y = "Bill Depth (mm)",
			 color = "Sex",
			 title = "Bill Length and Bill Depth, by Sex and Species",
			 caption = "Source: palmerpenguins package") +
	theme_minimal() +
	theme(legend.position = "bottom",
				plot.title = element_text(hjust = .5)) +
	facet_wrap(~ factor(species))

# How do I save a graph?