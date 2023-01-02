library(dplyr)

flights <- readRDS("output/data/flights.rds")

all_carriers <- flights %>%
  count(dest) %>%
  slice_max(n, n = 10) %>%
  mutate(carrier = "All carriers")

by_carrier <- flights %>%
  count(carrier, dest) %>%
  group_by(carrier) %>%
  slice_max(n, n = 10) %>%
  ungroup()

bind_rows(all_carriers, by_carrier) %>%
  saveRDS(file = "output/results/top_destinations.rds")
