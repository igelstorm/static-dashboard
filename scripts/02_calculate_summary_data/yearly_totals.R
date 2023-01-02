library(dplyr)

flights <- nycflights13::flights
movies <- ggplot2movies::movies

all_lengths <- movies %>%
  filter(!is.na(budget), year >= 1980) %>%
  group_by(year) %>%
  summarise(
    length_cat = "All",
    n = n(),
    mean_rating = mean(rating)
  )

by_length <- movies %>%
  filter(!is.na(budget), year >= 1980) %>%
  mutate(
    length_cat = cut(length, breaks = c(-Inf, 30, 60, 90, 120, Inf))
  ) %>%
  group_by(year, length_cat) %>%
  summarise(
    n = n(),
    mean_rating = mean(rating),
    .groups = "drop"
  )

bind_rows(all_lengths, by_length) %>%
  saveRDS(file = "output/results/yearly_totals.rds")
