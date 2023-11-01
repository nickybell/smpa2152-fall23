# Assignment \#4
Prof. Bell

For this homework, we will use the `tidyverse` to estimate the
favorability ratings of Joe Biden and Donald Trump among the U.S. public
using data from Roper iPoll.

You must submit your homework as a rendered Quarto document (HTML
preferred, PDF and Word acceptable). Please ensure that all code used to
generate the document (including your `setup` chunk) are visible in the
report. However, extraneous code that is not required for answering the
questions but that appears in your Quarto document will result in a
deduction (for example, `glimpse()` should not appear anywhere in your
rendered report).

Please turn in your `.qmd` file, the `_files` directory, and your
rendered Quarto document as a `.zip` folder on Blackboard. When you
export multiple items from Posit Cloud at once, it will automatically be
exported as a `.zip`.

1.  Download the data on the [August 2023 ABC News/Ipsos
    poll](https://doi.org/10.25940/ROPER-31120497) from Roper iPoll and
    load the data in R.

2.  Look at the study documentation on Roper iPoll to determine what
    variables are used by Ipsos to weight the respondents. Show these
    variables for the ten respondents with the largest weights and the
    ten respondents with the smallest weights. What kinds of respondents
    do you think Ipsos has a harder time reaching? An easier time
    reaching?

    *It is not necessary to evaluate every weighting variable; usually,
    only one or two variables determine most of the weights, even if
    many weighting variables are used.*

3.  Create a single graph comparing the **unweighted** proportion of
    respondents who have a **favorable** opinion of Joe Biden (`Q1_2`)
    and a favorable opinion of Donald Trump (`Q1_1`). Be sure to show
    the margin of error on your graph.

    *Hint: you will need to use `pivot_longer()` in your answer. Review
    this function from our class on tidying data. In addition, it will
    help to rename `Q1_1` and `Q1_2` before using `pivot_longer()`.*

4.  Create the same graph as in \#3, but this time using the
    **weighted** proportion of respondents who have a favorable opinion
    of Joe Biden and Donald Trump (`Q1_1`). Be sure to show the margin
    of error on your graph. What differences do you notice between the
    weighted and unweighted results? What does this tell us about which
    candidate’s supporters are harder for Ipsos to reach?

**BONUS (3 points)**: Create the same graph as in \#4, but use facets to
compare favorability ratings of Biden and Trump among Democratic,
Republican, and Independent voters (party ID is `QPID`).

*This question goes beyond our work in class. Think about what it means
to add an additional group to our analysis. How will this affect our
`count()` and `group_by()` functions?*
