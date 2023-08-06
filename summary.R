# Loading required libraries
library(dplyr)
library(readr)

# Reading the CSV file
data <- read_csv('https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv')

# Calculating the average total jail and prison population rate by urbanicity
average_rates_by_urbanicity <- data %>%
  group_by(urbanicity) %>%
  summarise(
    avg_jail_pop_rate = mean(total_jail_pop_rate, na.rm = TRUE),
    avg_prison_pop_rate = mean(total_prison_pop_rate, na.rm = TRUE)
  )

# Finding the urbanicity with the highest and lowest total prison population rate
highest_prison_rate_urbanicity <- data %>%
  arrange(desc(total_prison_pop_rate)) %>%
  slice_head(n = 1) %>%
  select(urbanicity) %>%
  pull()

lowest_prison_rate_urbanicity <- data %>%
  arrange(total_prison_pop_rate) %>%
  slice_head(n = 1) %>%
  select(urbanicity) %>%
  pull()

# Analyzing the trend of prison population rate across all years, grouped by urbanicity
trend_by_urbanicity <- data %>%
  group_by(urbanicity) %>%
  summarise(
    change = max(total_prison_pop_rate, na.rm = TRUE) - min(total_prison_pop_rate, na.rm = TRUE)
  )
