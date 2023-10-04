# File Name: 	  	  knight_newhouse_data.R
# File Purpose:  	  generate knight newhouse data
# Author: 	    	  Nicholas Bell (nicholasbell@gwu.edu)
# Date Created:     2023-10-02

library(tidyverse)
library(readxl)

options(tibble.width = Inf)

kn <- read_excel("data/data-wrangling/knight_newhouse.xls") |>
  janitor::clean_names() |>
  rename(
    school = data,
    advertising_licensing = corporate_sponsorship_advertising_licensing,
    media_rights = ncaa_conference_distributions_media_rights_and_post_season_football,
    total_academic_spending = total_academic_spending_university_wide) |>
  select(-fbs_conference,-ncaa_subdivision)

ipeds <- read_csv("data/data-wrangling/ipeds.csv") |>
  janitor::clean_names() |>
  rename(
    conference = ic2022_ncaa_naia_conference_number_basketball,
    region = hd2022_bureau_of_economic_analysis_bea_regions,
    control = hd2022_control_of_institution,
    undergraduates = drvef122022_full_time_undergraduate_12_month_unduplicated_headcount)

data <- left_join(kn, select(ipeds, unitid, conference, region, control), by = join_by(ipeds_id == unitid)) |>
  mutate(region = str_extract(region, "(^.*)\\s\\(.*$", group = 1))

write_csv(data, "data/data-wrangling/knight_newhouse.csv")
