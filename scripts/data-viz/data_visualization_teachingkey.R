# File Name: 	  	  data_visualization_teachingkey.R
# File Purpose:  	  Data Visualization
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-09-16

# Load packages (install them first if necessary)
library(tidyverse)
library(palmerpenguins)
# The package {nbmisc} is not publicly available, but you can download the development version if necessary using the command: remotes::install_github("nickybell/nbmisc")
library(nbmisc)

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

# Okay, let's get started. When you are making a graph, the first thing to think about is the type of data you are working with: discrete or continuous.
	# Discrete variables do not exist on the number line; they are categories
	# Continuous variables exist on the number line; they are numbers
  # Not all numbers are continuous! e.g.,
  table(flights$month)
  # when this happens, you should convert your numbers to categories using as.factor()
  flights$month_categories <- as.factor(flights$month)
  head(flights$month_categories)
  
# The second thing to think about is how many variables you are graphing: univariate (one variable), bivariate (two variables), or multivariate (3+ variables)?

# The combination of variable types and number of variables will determine which graph you should create.
types_of_graphs() # this comes from the {nbmisc} package

# Today we will be using the "penguins" data from the {palmerpenguins} package that you are also using for your homework.
  
# Univariate Graphs -------------------------------------------------------

# Discrete variable: bar graph
# When working with univariate graphs, we are often just counting values

ggplot(data = penguins) +
	geom_bar(mapping = aes(x = species))
  
  # You can also pass in the values directly (e.g., what if you have a vector of means?)
  table(penguins$species)
  peng2 <- data.frame(species = c("Adelie", "Chinstrap", "Gentoo"),
                      mean_body_mass_g = c(3701, 3733, 5076))
  
  ggplot(data = peng2) +
    geom_bar(mapping = aes(x = species, y = mean_body_mass_g), stat = "identity")

# Continuous variable: histogram

ggplot(data = penguins) +
	geom_histogram(mapping = aes(x = flipper_length_mm), binwidth = 10)

# Try it yourself! --------------------------------------------------------

# The data consists of three study years. How many penguins are studied in each year?

ggplot(data = penguins) +
	geom_bar(aes(x = year))

# Now remove the data from 2008 from the data frame. What change do you need to make to your graph code now? Hint: use as.factor()
penguins_lim <- penguins[penguins$year %in% c(2007, 2009),]

ggplot(data = penguins_lim) +
  geom_bar(aes(x = year))

ggplot(data = penguins_lim) +
  geom_bar(aes(x = as.factor(year)))

# Bivariate Graphs -----------------------------------------------------

# 2 discrete variables

# What species of penguins live on each island?
# It is useful to think of this like two nested counts: the number of penguins on each island, and then of those penguins, the number that come from each species
penguins |>
  group_by(island, species) |>
  summarize(n_species = n()) |>
  mutate(n_island = sum(n_species))

# Bar graph

ggplot(data = penguins) +
	geom_bar(aes(x = island, fill = species), position = "dodge") +
	scale_fill_discrete(type = c("aquamarine", "seagreen", "salmon")) +
  theme_bw()

colors()

# Try it yourself! -----------------------------------------------------

# Change the colors in the graph we just created.



# 1 discrete variable, 1 continuous variable

# How does bill length differ by penguins' sex?

# Box and whisker plot

ggplot(data = penguins[!is.na(penguins$sex),]) +
	geom_boxplot(aes(x = sex, y = bill_length_mm)) +
	scale_y_continuous(limits = c(0, NA)) +
	labs(x = "Sex",
			 y = "Bill Length (mm)",
			 title = "Penguin Bill Length by Sex",
			 caption = "Source: palmerpenguins package")

# Violin plot

ggplot(data = penguins[!is.na(penguins$sex),]) +
  geom_violin(aes(x = sex, y = bill_length_mm), fill = "steelblue") +
  scale_y_continuous(limits = c(0, NA)) +
  labs(x = "Sex",
       y = "Bill Length (mm)",
       title = "Penguin Bill Length by Sex",
       caption = "Source: palmerpenguins package")

# Try it yourself! -----------------------------------------------------

# Add built-in themes to the box and whisker plot and the violin plot we just made. (Hint: try ?ggtheme in your console)



# 2 continuous variables

# Scatterplot

# Are flipper length and body mass related?

ggplot(data = penguins) +
	geom_point(aes(x = flipper_length_mm, y = body_mass_g)) +
	geom_smooth(aes(x = flipper_length_mm, y = body_mass_g), method = "lm", se = F, linetype = "dashed", size = 2)

# Why is it acceptable to leave the axis values where they are rather than set them to 0? Because we are interested in the relationship between these variables rather than the values themselves.

# Line graph
# This usually occurs when the y-axis is ordered, like time. For example, let's create a data frame that shows the mean bill length for each year of the study. You'll learn how to understand this code in the next module of the course.
peng3 <- 
  penguins |> 
  group_by(year) |> 
  summarize(mean_bill_length_mm = mean(bill_length_mm, na.rm = T))

ggplot(data = peng3, mapping = aes(x = year, y = mean_bill_length_mm)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = c(2007:2009)) +
  scale_y_continuous(limits = c(0, NA))


# Multivariate Graphs -----------------------------------------------------

# Let's make the same line graph, but this time, we are going to separate the data by the sex.
peng4 <- 
  penguins |> 
  group_by(year, sex) |> 
  summarize(mean_bill_length_mm = mean(bill_length_mm, na.rm = T))

# Add a new aesthetic mapping

ggplot(data = peng4[!is.na(peng4$sex),], mapping = aes(x = year, y = mean_bill_length_mm, color = sex)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = c(2007:2009)) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_color_manual(values = c("olivedrab", "royalblue4"))

# Use facets

ggplot(data = peng4[!is.na(peng4$sex),], mapping = aes(x = year, y = mean_bill_length_mm)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = c(2007:2009)) +
  scale_y_continuous(limits = c(0, NA)) +
  facet_wrap(~ sex)

# Try it yourself! --------------------------------------------------------

# Using both an additional aesthetic mapping AND facets, make a graph with 4 variables: How are bill length and bill depth related, for both sexes of penguins, on each island?

ggplot(data = penguins[!is.na(penguins$sex),], aes(x = bill_length_mm, y = bill_depth_mm, color = sex)) +
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