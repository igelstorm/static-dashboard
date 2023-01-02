library(dplyr)

flights <- readRDS("output/data/flights.rds")

flights %>%
  group_by(date(sched_dep_date)) %>%
  summarise(
    n = n()
  )

bind_rows(all_lengths, by_length) %>%
  saveRDS(file = "output/results/yearly_totals.rds")
