#install tidyverse first, then call the library for use 
library(tidyverse)
library(ggplot2)

#Familiaring self with dataset. Pulling unique values from the month and days column
forestfires %>% pull(month) %>% unique
forestfires %>% pull(day) %>% unique

#reordering month and date levels
forestfires$month <- factor(
  forestfires$month, 
  levels = c("jan", "feb", "mar", "apr", "may", "jun", 
             "jul", "aug", "sep", "oct", "nov", "dec"),
  ordered = TRUE
)

forestfires$day <- factor(
  forestfires$day,
  levels = c("mon","tue", "wed", "thu", "fri", "sat","sun"),
  ordered = TRUE
)
#reordering the actual rows in the dataset
forestfires <- forestfires[order(forestfires$month, forestfires$day),]
print(forestfires)

#counting the number of forest fires per month
forestfirescounts_m <- forestfires %>% 
  group_by(month) %>% 
  summarise(count = n()) %>%
  as_tibble()
print(forestfirescounts_m)



#counting number of fires per day
forestfirescounts_d <- forestfires %>%
  group_by(day) %>%
  summarise(count = n()) %>%
  as_tibble()
print(forestfirescounts_d)

#bar chart to visualise forest fires per month 
ggplot(data = forestfirescounts_m, aes(x = month, y = count)) + 
  geom_bar(stat = "identity", fill = "coral") +
  labs(title = "Forest Fires per Month", x = "Month", y = "Number of Fires") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) #customisation of axes font and style

#barchart for fires per day 
ggplot(data = forestfirescounts_d, aes(x = day, y = count)) +
  geom_bar(stat = "identity", fill = "darkgoldenrod1") +
  labs(title = "Forest Fires per Day of the Week", x = "Day", y = "Number of Fires") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#looking at the average temperature of each month against number of fires.
month_temp <- forestfires %>% 
  group_by(month) %>% 
  summarise(avg_temp = mean(temp, na.rm = TRUE)) %>%
  as_tibble()
print(month_temp)

#joining temp data & fires count for viz
avgtemp_fires <- forestfirescounts_m %>%
  inner_join(month_temp, by = "month")
print(avgtemp_fires)

ggplot(data = avgtemp_fires, aes(x = month)) +
  # Bar chart for number of fires
  geom_bar(aes(y = count), stat = "identity", fill = "coral", alpha = 0.7) +
  # Line chart for average temperature
  geom_line(aes(y = avg_temp * max(count) / max(avg_temp)), group = 1, color = "deepskyblue", size = 1) +
  geom_point(aes(y = avg_temp * max(count) / max(avg_temp)), color = "deepskyblue", size = 2) +
  # Add secondary y-axis for temperature
  scale_y_continuous(
    name = "Number of Fires",
    sec.axis = sec_axis(~ . * max(avgtemp_fires$avg_temp) / max(avgtemp_fires$count), name = "Average Temperature (°C)")
  ) +
  labs(
    title = "Forest Fires and Average Temperature by Month",
    x = "Month",
    y = "Number of Fires"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
  )


# Summarize data by month for all required variables
monthly_data <- forestfires %>%
  group_by(month) %>%
  summarise(
    count = n(),
    avg_DMC = mean(DMC, na.rm = TRUE),
    avg_DC = mean(DC, na.rm = TRUE),
    avg_RH = mean(RH, na.rm = TRUE),
  ) %>%
  as_tibble()

# Normalize data for better visualization
monthly_data_scaled <- monthly_data %>%
  mutate(
    scaled_count = count / max(count, na.rm = TRUE),
    scaled_DMC = avg_DMC / max(avg_DMC, na.rm = TRUE),
    scaled_DC = avg_DC / max(avg_DC, na.rm = TRUE),
    scaled_RH = avg_RH / max(avg_RH, na.rm = TRUE),
  )

# Reshape data into long format for plotting
long_data_scaled <- monthly_data_scaled %>%
  select(month, scaled_count, scaled_DMC, scaled_DC, scaled_RH) %>%
  pivot_longer(
    cols = -month,
    names_to = "variable",
    values_to = "value"
  )

# Ensure 'month' is ordered correctly
long_data_scaled$month <- factor(long_data_scaled$month, 
                                 levels = c("jan", "feb", "mar", "apr", "may", "jun", 
                                            "jul", "aug", "sep", "oct", "nov", "dec"),
                                 ordered = TRUE)
# Custom legend labels
custom_labels <- c(
  "scaled_count" = "Number of Fires",
  "scaled_DMC" = "Duff Moisture Code",
  "scaled_DC" = "Drought Code Index",
  "scaled_RH" = "Relative Humidity (%)"
)

# Plot normalized data
ggplot(data = long_data_scaled, aes(x = month, y = value, color = variable, group = variable)) +
  geom_line(size = 1) +
  scale_color_manual(
    values = c("scaled_count" = "black", 
               "scaled_DMC" = "coral", 
               "scaled_DC" = "darkgreen", 
               "scaled_RH" = "cornflowerblue"),
    labels = custom_labels
  ) +
  labs(
    title = "Forest Fires and Related Variables by Month (Scaled)",
    x = "Month",
    y = "Scaled Values",
    color = "Legend",
    linetype = NULL
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

