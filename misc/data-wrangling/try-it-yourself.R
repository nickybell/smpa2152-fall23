library(tidyverse)
print(
  read_csv("data/data-wrangling/knight_newhouse.csv", show_col_types = FALSE) |>
  filter(year == 2022) |>
  mutate(ratio = total_expenses/total_academic_spending) |>
  group_by(region) |>
  summarize(avg_ratio = mean(ratio, na.rm = TRUE)) |>
  filter(!is.na(region)) |>
  ggplot() +
    geom_bar(aes(x = region, y = avg_ratio), stat = "identity") +
    labs(x = "Region",
         y = "Average Athletics to Academics Ratio",
         title = "Athletics to Academics Ratio by Region",
         caption = "Source: Knight-Newhouse Commission") +
    theme_classic() +
    theme(plot.title = element_text(hjust = .5),
          axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))
)

