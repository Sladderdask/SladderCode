library(readr)
library(tidyverse)
library(ggplot2)
library(reshape2)
library(car)

data <- read.csv("C:/GitHub/SladderCode/courses/data_analytics_with_R/titanic.csv")

#Evaluate missing data, Here it seems like there is
#missing data in the sex column however upon inspecting the datafile
#it becomes apparent that a lot of cabin numbers are missing and
#two embarked are missing.
colSums(is.na(data))

#Upon observing the datasheet i will disregard the, passengerid Cabin and ticket
# columns,
# passenger id will does not provide any information either so it will be dropped.
# the cabin columns has to many missing values and the ticket column is
# too difficult to interpret if it has any information at all.
# name also has no apparent useful information and would be too diffucult to interpret

data <- data %>% select(-PassengerId, -Cabin, -Ticket, -Name)
#Summary of the data
summary(data)

#Turn embarked into factors
data$Embarked <- as.factor(data$Embarked)

#Turn sex into numeric, 1 = male, 0 = female
data <- data %>%
  mutate(Sex = if_else(Sex == "male", 1, 0))

#Select numeric data
numeric_data <- data %>% select(where(is.numeric))

#Create cor matrix
correlations <- cor(numeric_data, use = "complete.obs")
correlations
#Reshape correlation matrix into long format
cor_long <- melt(correlations)

#Plot with ggplot2
ggplot(cor_long, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  geom_text(aes(label = round(value, 2)), color = "black", size = 3) +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white",
                       midpoint = 0, limit = c(-1,1), space = "Lab",
                       name = "Correlation") +
  theme_minimal() +
  coord_fixed() +
  labs(title = "Correlation Matrix", x = "", y = "") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

#So far we have no knowledge about embarked column so we will get the average
#survival rate from each location.

#prepare dataframe where with mean survival rates for each location
plot_df <- data %>%
  group_by(Embarked) %>%
  summarise(
    survival_rate = mean(Survived),
    n = n()
  )
plot_df


#Make a plot with the survival rate on the y axis and the embarked locations
#on the x axis.
ggplot(plot_df, aes(x = Embarked, y = survival_rate, fill = Embarked)) +
  geom_col(width = 0.6) +
  scale_y_continuous(limits = c(0, 1),
                     labels = scales::percent) +
  labs(
    title = "Mean Survival Rate by Embarkation Port",
    x = "Embarked",
    y = "Survival rate"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

#this plot shows us that some embarked locations lead to higher survivability than others.

#DATA IMPUTATION

#before the regression i will begin by performing mean imputation on the age and Embarked
# columns. We will see later if these columns are relevant or not.
mean_age <- mean(data$Age, na.rm = TRUE)

data_imputed <- data

data_imputed <- data_imputed %>% mutate(Age = replace_na(Age, mean_age))

data_imputed <- data_imputed %>% mutate(Embarked = replace(Embarked, Embarked == "", "S"))

summary(data_imputed)

colSums(is.na(data_imputed))


data_imputed <- data_imputed %>% mutate(Sex = as.factor(Sex))

data_imputed <- data_imputed %>% mutate(Embarked = as.factor(Embarked))

#LOGISTIC REGRESSION

logistic_model <- data_imputed |> glm(formula = Survived ~ Pclass + Sex + Age + SibSp, family = binomial)

summary(logistic_model)

pred_probs <- predict(logistic_model, type = "response")

pred_Outcome <- ifelse(pred_probs >= 0.5, 1, 0)

actual_Outcome <- data_imputed$Survived

accuracy <- mean(pred_Outcome == actual_Outcome)
accuracy

#Checking for multicolinnearity
vif(logistic_model)





