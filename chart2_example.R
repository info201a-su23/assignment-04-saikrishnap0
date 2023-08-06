library(ggplot2)
library(readr)
library(dplyr)

plot <- ggplot(data, aes(x = total_jail_pop_rate, y = total_prison_pop_rate)) +
  geom_point() + # Scatter plot
  labs(
    title = "Total Jail Population Rate vs. Total Prison Population Rate",
    x = "Total Jail Population Rate",
    y = "Total Prison Population Rate"
  ) +
  theme_minimal()
plot

