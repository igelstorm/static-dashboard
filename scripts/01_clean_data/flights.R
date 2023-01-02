library(dplyr)
library(lubridate)

flights <- nycflights13::flights

flights %>%
  mutate(
    sched_dep_datetime = make_datetime(year, month, day, hour, minute),
    sched_dep_date = make_date(year, month, day),
    month_name = month(sched_dep_date, label = TRUE)
  ) %>%
  saveRDS(file = "output/data/flights.rds")
