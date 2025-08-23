library(tidyverse)
library(ggplot2)
data(msleep)
?msleep

summary(msleep)

msleep_sorted <- msleep %>% arrange(sleep_total)
msleep_sorted

# 1. Convert into factors
msleep <- msleep %>%
  mutate(across(c(genus, vore, order, conservation), as.factor))

# 2. Shortest sleep time
shortest_sleep <- min(msleep$sleep_total)
shortest_sleep_mammal <-
  msleep %>% filter(sleep_total == shortest_sleep) %>% pull(name)

# 3. Most missing
missing_values <- max(colSums(is.na(msleep)))
most_missing <- names(msleep[which.max(colSums(is.na(msleep)))])
most_missing

# 4. Correlations
numeric <- msleep %>% select(where(is.numeric))
correlations <- cor(numeric, use = "pairwise.complete.obs", method = "pearson")
correlations

# 5. Highest correlation
correlations_copy <- correlations
correlations_copy[correlations_copy == 1] <- 0
correlations_copy[correlations_copy == min(correlations_copy)] <- 0
correlations_copy
highest_corr <- max(correlations_copy)

# 6. Sleep time distribution
sleep_histogram <- ggplot(data = msleep, aes(x = sleep_total)) +
  geom_histogram(binwidth = 1) +
  labs(title = "Distribution of tot. sleep",
       x = "Total Sleep (hours per day)",
       y = "Count") +
  theme_minimal()
print(sleep_histogram)


# 7. Bar chart for food categories
food_barchart <- ggplot(data = msleep, aes(x = vore)) +
  geom_bar(stat = "count") +
  labs(title = "Frequency of Vore Type",
       x = "vore",
       y = "count")
food_barchart

# 8. Grouped box plot for sleep time
sleep_boxplot <-  ggplot(data = msleep, aes(x = vore, y = sleep_total)) +
  geom_boxplot(stat = "boxplot") +
  labs(title = "Vore total sleep boxplot")
sleep_boxplot

# 9. Longest average sleep time
avgsleep_vore <- msleep %>% group_by(vore) %>% summarize(avg_sleep = mean(sleep_total))
highest_average <- max(avgsleep_vore$avg_sleep)

# 10. REM sleep vs. total sleep, colored by order
sleep_scatterplot <- ggplot(data = msleep, aes(x = sleep_total, y = sleep_rem, color = order)) +
  geom_point() +
  labs(title = "Rem vs Total Sleep Scatterplot")
sleep_scatterplot

# 11. REM sleep vs. total sleep for the order most common in the data
common_order <- msleep %>% group_by(order) %>% summarize(count = n())
common_order
common_order_df <- msleep %>% filter(order == "Rodentia")
common_order_df

sleep_scatterplot2 <- sleep_scatterplot <- ggplot(data = common_order_df, aes(x = sleep_total, y = sleep_rem)) +
  geom_point() +
  labs(title = "Rem vs Total Sleep Scatterplot, Rodentia")
sleep_scatterplot
