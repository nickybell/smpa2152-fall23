# Assignment \#3
Prof. Bell

For this homework, we will use the `dplyr` verbs and functions that we
learned in class to understand the relationship between interest rates
and inflation in the United States. **You must answer these questions
using the `dplyr` verbs and functions.**

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

1.  Load the inflation and interest rates data (available on the
    Blackboard assignment). The inflation data is the monthly percentage
    change in prices compared to the previous month (the inflation
    rate); the interest rates data is the interest rate in percentage
    points for each month.

2.  Join the data frames together, keeping only the rows that match in
    both data frames.

3.  Generate a table (`tibble`) containing the five months with the
    highest inflation rate since 2000.

4.  What month had the largest increase in the interest rate compared to
    the previous month?

    *Hint: `lag(<column>)` provides the value of `<column>` in the
    previous row.*

5.  Make one graph showing showing the yearly average inflation rate in
    orange and the yearly average interest rate in purple over time.

    *This graph will not have a legend. We will learn how to resolve
    this next week.*

6.  Make a graph comparing the average monthly interest rate when
    inflation is high (0.6% or greater) vs. normal (less than 0.6%),
    additionally comparing between the year 2000 and later vs. earlier.

    *Hint: You can use `ifelse()` in the tidyverse when making or
    modifying a column*
