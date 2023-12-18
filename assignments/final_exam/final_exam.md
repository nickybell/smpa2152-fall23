# Final Exam
Prof. Bell

The American National Election Study (ANES) is a federally-funded survey
of the American electorate taken at each presidential and mid-term
election cycle. The survey is used by academic researchers to track
American public opinion over time and is known for its high-quality
data. For this assignment, we will be using data from the 2022 ANES.
This particular survey is considered a pilot study, and was conducted by
YouGov using a non-probability sample.

You must submit your exam as a rendered Quarto document (HTML preferred,
PDF and Word acceptable). Please ensure that all code used to generate
the document (including your `setup` chunk) are visible in the report.
However, extraneous code that is not required for answering the
questions but that appears in your Quarto document will result in a
deduction (for example, `glimpse()` should not appear anywhere in your
rendered report).

Please turn in your `.qmd` file, the `_files` directory, and your
rendered Quarto document as a `.zip` folder on Blackboard. When you
export multiple items from Posit Cloud at once, it will automatically be
exported as a `.zip` file.

1.  Load the data and remove any rows that are missing a value in the
    `weight` column.

2.  We will be working with the question, “On the whole, how satisfied
    are you with the way democracy works in the United States?” The
    relevant variable is `demsatisfy` and the values in this field
    represent:

    - 1 - Extremely satisfied
    - 2 - Very satisfied
    - 3 - Moderately satisfied
    - 4 - Slightly satisfied
    - 5 - Not at all satisfied

    Modify this variable so that we can compare those who are
    moderately, very, or extremely satisfied to all other responses.

    In addition, political party is represented by the variable `pid_x`,
    and the values in this field represent:

    - 1 - Strong Democrat
    - 2 - Democrat
    - 3 - Lean Democrat
    - 4 - Independent
    - 5 - Lean Republican
    - 6 - Republican
    - 7 - Strong Republican

    Modify this variable so that we can compare Democrats, Republicans,
    and Independents.

3.  Generate a nicely-formatted graph that shows the weighted topline
    results of the democratic satisfaction question, comparing
    Democrats, Republicans, and Independents.

4.  Conduct a weighted hypothesis test showing whether a majority of
    Americans are satisfied with American democracy. You must write both
    the $H_0$ and the $H_A$. How do you interpret the results of your
    hypothesis test?

5.  Conduct a linear probability regression model of satisfaction with
    American democracy (the dependent variable) on political party. Use
    Independents as your reference level for political party.

    How do you interpret the effect of political party on satisfaction
    with American democracy?

6.  A “feeling thermometer” question asks respondents to rate their
    feelings towards a person, place, or thing on a scale of 0 to 100,
    where 0 is very “cold” or negative and 100 is very “warm” or
    positive.

    Conduct a linear regression of how warmly respondents feel towards
    President Biden (variable `ftbiden`, the dependent variable) on
    satisfaction with democracy and at least two confounders. Please
    explain why you chose to control for those two confounders (i.e.,
    why do you think that variable is a confounder?)

    How do you interpret the effect of satisfaction with American
    democracy on feelings toward President Biden?

    Some potential confounders include:

    - Birth year: `birthyr_dropdown` (be sure to convert this to age)
    - Gender: `gender` (1 - Male, 2 - Female)
    - Education: `educ` (1 - No high school, 2 - High school, 3 - Some
      college, 4 - Associate’s degree, 5 - Bachelor’s, 6 - Post-grad)
    - Family income: `faminc_new` (treat this as a continuous variable)
    - Urban-rural status: `urbanicity2` (1 - Big city, 2 - Smaller city,
      3 - Suburban area, 4 - Small town, 5 - Rural area)

    *Hint: Make sure that categorical variables are treated as such in
    the regression, and not as continuous variables.*
