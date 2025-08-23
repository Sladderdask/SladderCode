library(readr)
library(tidyverse)
library(ggplot2)
library(reshape2)

data <- read.csv("C:/GitHub/SladderCode/courses/data_analytics_with_R/titanic.csv")
summary(data)
data %>% data %>% mutate(across(outcome, as.factor))
summary(data)
data_numeric <- data[, sapply(data, is.numeric)]

correlations <- cor()
correlations #Strongest correlations for survival is Pclass and Fare.

ggcorrplot(correlations, lab = TRUE, type = "upper")

boxplot <- ggplot(data = data, aes(data)) +
  corrplot

boxplot

data$ex
