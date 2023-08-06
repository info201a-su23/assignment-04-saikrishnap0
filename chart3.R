# Load packages
library(readr)
library(ggplot2)
library(mapdata)
library(stringr)
library(dplyr)
library(maps)

# Load data
washington <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990-WA.csv")

# Filter data for the latest year
washington <- washington %>%
  filter(year == max(year))

# Load map_data
wa_counties <- map_data("county", region = "washington")

# Changing subregion to match formatting in jail data
wa_counties <- wa_counties %>%
  mutate(subregion = str_to_title(subregion) %>% str_c(" County"))

# Combine map_data and jail data
merged_data <- left_join(wa_counties, washington, by = c("subregion" = "county_name"))

# Plot map
# Plotting the map
# Assign the plot to a variable
my_plot <- ggplot(data = merged_data, aes(x = long, y = lat, group = group, fill = total_jail_pop_rate)) +
  geom_polygon() +
  coord_fixed(1.25, ylim = c(min(merged_data$lat), max(merged_data$lat))) +
  labs(title = "Total Jail Population Rate Across Washington Counties",
       fill = "Total Jail Rate") +
  scale_fill_gradient(name = "Total Jail Rate", 
                      low = "lightblue", high = "darkblue",
                      breaks = seq(min(merged_data$total_jail_pop_rate, na.rm = TRUE), 
                                   max(merged_data$total_jail_pop_rate, na.rm = TRUE), 
                                   length.out = 5)) +
  theme_minimal() +
  theme(plot.title = element_text(),
        axis.text = element_blank(),
        axis.title = element_blank())

# Print the plot
print(my_plot)

