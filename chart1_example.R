# Loading required libraries
library(ggplot2)
library(readr)
library(dplyr)

# Reading the CSV file
data <- read_csv('https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv', show_col_types = FALSE)

# Prepare data for plotting
data_trend <- data %>%
  select(year, urbanicity, total_prison_pop_rate) %>%
  group_by(urbanicity, year) %>%
  summarise(total_prison_pop_rate = mean(total_prison_pop_rate, na.rm = TRUE), .groups = 'drop')

# Create the plot
plot_trend <- ggplot(data_trend, aes(x = year, y = total_prison_pop_rate, color = urbanicity)) +
  geom_line() +
  labs(
    title = "Trend of Prison Population Rate in the U.S. by Urbanicity",
    x = "Year",
    y = "Total Prison Population Rate",
    caption = "Data: Source Name"
  ) +
  theme_minimal() +
  theme(legend.title = element_text("Urbanicity Categories"))

# Print the plot
print(plot_trend)
