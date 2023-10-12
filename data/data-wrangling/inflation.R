library(tidyverse)
library(readxl)
inflation <- read_xlsx("data/data-wrangling/inflation_raw.xlsx") |>
  pivot_longer(Jan:Dec, names_to = "month", values_to = "inflation_rate") |>
  mutate(month = case_match(month,
                            "Jan" ~ 1,
                            "Feb" ~ 2,
                            "Mar" ~ 3,
                            "Apr" ~ 4,
                            "May" ~ 5,
                            "Jun" ~ 6,
                            "Jul" ~ 7,
                            "Aug" ~ 8,
                            "Sep" ~ 9,
                            "Oct" ~ 10,
                            "Nov" ~ 11,
                            "Dec" ~ 12))
write_csv(inflation, "data/data-wrangling/inflation.csv")
