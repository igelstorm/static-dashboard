library(dplyr)

flights <- readRDS("output/data/flights.rds")

flights %>%
  count(carrier, dest) %>%
  add_count(carrier, wt = n, name = "carrier_total") %>%
  add_count(dest, wt = n, name = "dest_total") %>%
  add_count(wt = n, name = "grand_total") %>%
  mutate(
    carrier_share = n / carrier_total,
    mean_share = dest_total / grand_total,
    carrier_diff_from_mean = carrier_share - mean_share
  ) %>%
  group_by(carrier) %>%
  slice_max(n, n = 10) %>%
  ungroup() %>%
  saveRDS(file = "output/results/fancy_top_destinations.rds")
