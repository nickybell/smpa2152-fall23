library(tidyverse)
library(tidycensus)
data <- read_csv("~/smpa2152-fall23/data/midterm/bridges_raw.txt")
data |>
  select(STATE_CODE_001, STRUCTURE_NUMBER_008, YEAR_BUILT_027, ADT_029, HIGHWAY_SYSTEM_104, BRIDGE_CONDITION) |>
  mutate(HIGHWAY_SYSTEM_104 = case_match(HIGHWAY_SYSTEM_104,
                                         0 ~ FALSE,
                                         1 ~ TRUE),
         BRIDGE_CONDITION = case_match(BRIDGE_CONDITION,
                                       "G" ~ "Good",
                                       "F" ~ "Fair",
                                       "P" ~ "Poor")) |>
  filter(YEAR_BUILT_027 %in% c(1798:2023)) |>
  rename(FIPS = STATE_CODE_001,
         `Bridge ID` = STRUCTURE_NUMBER_008,
         `Year Built` = YEAR_BUILT_027,
         Traffic = ADT_029,
         `National Highway System` = HIGHWAY_SYSTEM_104,
         Condition = BRIDGE_CONDITION
         ) |>
  write_csv("~/smpa2152-fall23/data/midterm/bridges.csv")

data(fips_codes)
fips_codes |>
  distinct(state_name, state_code) |>
  rename(fips = state_code) |>
  filter(as.numeric(fips) <= 56) |>
  write_csv("~/smpa2152-fall23/data/midterm/fips.csv")
