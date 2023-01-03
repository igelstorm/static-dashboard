library(dplyr)

flights <- readRDS("output/data/flights.rds")

all_carriers <- flights %>%
  group_by(origin, month_name) %>%
  summarise(
    carrier = "All carriers",
    n = n(),
    n_delayed = sum(dep_delay > 0, na.rm = TRUE),
    .groups = "drop"
  )

by_carrier <- flights %>%
  group_by(origin, month_name, carrier) %>%
  summarise(
    n = n(),
    n_delayed = sum(dep_delay > 0, na.rm = TRUE),
    .groups = "drop"
  )

bind_rows(all_carriers, by_carrier) %>%
  saveRDS(file = "output/results/daily_totals.rds")
