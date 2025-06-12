library(tidyverse)
data(msleep)
?msleep

msleep$genus

msleep["genus"]

(msleep)

class(new[1])

colnames(msleep[2])
msleep

msleep_sorted <- msleep %>% arrange(sleep_total)
msleep_sorted

# 1. Convert into factors
msleep$genus <- as.factor(msleep$genus)
msleep$vore <- as.factor(msleep$vore)
msleep$order <- as.factor(msleep$order)
msleep$conservation <- as.factor(msleep$conservation)

msleep <- msleep %>%
  mutate(across(c(genus, vore, order, conservation), as.factor))

# 2. Shortest sleep time
shortest_sleep <- min(msleep$sleep_total)
shortest_sleep_mammal <-
  msleep %>% filter(sleep_total == shortest_sleep) %>% pull(name)

# 3. Most missing
most_missing <- msleep %>% count(brainwt = NA)
most_missing


missing_values <- colSums((is.na(msleep)))
msleep %>% group_by(across((msleep), count(NA)))

# 4. Correlations
correlations <- ...

# 5. Highest correlation
correlations_copy <- correlations
highest_corr <- ...

# 6. Sleep time distribution
sleep_histogram <- ...

# 7. Bar chart for food categories
food_barchart <- ...

# 8. Grouped box plot for sleep time
sleep_boxplot <- ...

# 9. Longest average sleep time
highest_average <- ...

# 10. REM sleep vs. total sleep, colored by order
sleep_scatterplot <- ...

# 11. REM sleep vs. total sleep for the order most common in the data
sleep_scatterplot2 <- ...
