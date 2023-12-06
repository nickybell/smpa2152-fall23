# Assignment \#5
Prof. Bell

For this homework, we will use hypothesis tests and regression to
explore Americans’ views of free expression on college campuses. You
will need to download the data for the [Ipsos/Knight Foundation Survey:
Free Expression in America
Post-2020](https://doi.org/10.25940/ROPER-31119146) from Roper iPoll.

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

**BEFORE YOU BEGIN**: Make the following change to your data frame in
your setup chunk before proceeding to any analysis.

``` r
poll <- 
  poll |>
  mutate(Main_Weights = ifelse(!is.na(Students_Weights), Students_Weights, Main_Weights))
```

1.  Generate a graph that shows the weighted topline results for the
    question, “Should public universities and colleges allow or prohibit
    a person sharing political views that are offensive to some on
    campus?” The relevant variable is `Q11_4` and the relevant weighting
    variable is `Main_Weights`.

**BONUS:** Compare the weighted topline results for college students and
non-college students in the same graph. The relevant variable is
`Student1`. (Hint: Non-college students are represented with the values
`No` and `NA`.)

2.  Conduct a weighted hypothesis test showing whether the proportions
    of non-college students and college students who believe that
    colleges and universities should **allow** offensive political
    speech on campus are different. You must write both the $H_0$ and
    the $H_A$. How do you interpret the results of your hypothesis test?
    The relevant variable for college students is `Student1`. (Hint:
    Non-college students are represented with the values `No` and `NA`.)

3.  Conduct a linear probability model regression of whether colleges
    and universities should **allow** offensive political speech on
    campus on student status and at least two confounders. Please
    explain why you chose to control for those two confounders (i.e.,
    why do you think that variable is a confounder?)

    How do you interpret the effect of being a current college student
    on support for allowing offensive political speech on campus?

    Some potential confounders include:

    - Party ID: `QPID100`
    - Gender: `ppgender`
    - Household income: `ppinc7`
    - Race/Ethnicity: `ppethm`
