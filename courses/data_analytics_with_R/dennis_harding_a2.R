summary(iris)
library(ggplot2)
library(tidyverse)

iris[,1:4]

# 1. Corriris# 1. Correlations
correlations <- cor(iris[,1:4], method = "pearson")
correlations
# Text answer...
# All strong correlations are positive, the weaker correlations are negative.
# The stronger positive correlations make sense since a larger flower would
# be larger in all aspects, larger sepal and petal. however the different parts
# of the flower does not seem to overlap, so for example if the petal is wide
# the sepal would have to be more narrow and vice-versa, resulting in a
# negative correlation.

# 2. Plot Sepal.Width against Sepal.Length
plot1 <- ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_point() +
  labs(x = "sepal width (cm)",
       y = "sepal length (cm)")
# Text answer...
# The amount of visible correlation in this plot matches the result from the
# correlation matrix of -0.1175698, with some mental gymnastics i can discern
# a weak negative correlation pattern.

# 3. Fit a linear model using Sepal.Width as predictor and Sepal.Length as response
model1 <- lm(data = iris, formula = Sepal.Length ~ Sepal.Width)
model1
# Text answer...
# The linear model coefficient: -0.2234, corr coefficient 0.1175, this is
# the coefficients have the same sign but similar in size, the same sign is
# most important here.

# 4. Setosa correlations
setosa <- iris %>% filter(Species == "setosa")
correlations_setosa <- cor(setosa[,1:4], method = "pearson")
correlations_setosa
# Text answer...
# All of these correlations are positive, in this case a larger flower will be
# larger in all dimensions. Aspecially the width to length ratio of sepals
# seems to be consistent among individuals

# 5. Plot Sepal.Width against Sepal.Length, color by species
plot2 <- ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, color = Species)) +
  geom_point() +
  labs(x = "Sepal width",
       y = "Sepal length")
plot2
# Text answer..
# Yes this does match the correlation matrix of the Setosa species. I can see a
# quite strong positive linear relationship in the red dots.

# 6. Fit second model using species and Sepal.Width as predictors and Sepal.Length as respons
model2 <- glm(data = iris, formula = Sepal.Length ~ Sepal.Width + Species)
model2
# Text answer...
# Yes it makes sense since based on what plot 2 looks like, each of the species
# are have on their own a positive relationship between s-length and s-width
# which should how up as a positive relationship in the linear model as well.
# The specific correlation for setosa also showed us that sepal length and width
# was positivley correlated for that species specifically.

# 7. Predict the sepal length of a setosa with a sepal width of 3.6 cm
prediction <- model2 |> predict(data.frame(Sepal.Width = 3.6, Species = "setosa"))
prediction
# Text answer...
# Yes based on the distribution of points with species setosa on plot2,
# this seems reasonable.

# Download the dataset from Canvas an place in current directory
getwd()

# Load the data
diabetes_data <- read_csv("a2_diabetes.csv") # Don't change this line!

# Reflect over important variables
# From canvas
# Pregnancies: Number of pregnancies
# Glucose: Plasma glucose concentration a 2 hours in an oral glucose tolerance test
# BloodPressure: Diastolic blood pressure (mm Hg)
# SkinThickness: Triceps skin fold thickness (mm)
# Insulin: 2-Hour serum insulin (mu U/ml)
# BMI: Body mass index (weight in kg/(height in m)^2)
# DiabetesPedigreeFunction: The likelihood of diabetes based on family history
# Age: Age (years)
# Outcome: 0 if non-diabetic and 1 if diabetic
# there are 9 variables, quite a lot of missing data.
summary(diabetes_data)
# In the insulin column there are 239 out of 500 values missing.

# i think that Tricep skin fold Thickness and DIebetesPedigreeFunction will be
# most important

# I could not find any information about the missing values in the paper.
# I did however identify a pattern in the missing data where they seem to be
# dependent on eachoether. for example if skinthickness data is missing,
# insulin data will allways also be missing. And several other similar
# patterns. I would say that the missingness of the data is not random and
# therefore a mean value imputation should not be made, since this assumes that
# the missingness of the data is random. Please comment about this because i
# woul like to know if i am missing the point. Since i can identify this pattern
# the missingness is not random?

cor(x = diabetes_data[,1:8], method = "pearson")

reflection_plot1 <- ggplot(data = diabetes_data, aes(x = Glucose, y = is.na(Insulin)))+
  geom_boxplot()
reflection_plot1
# In this plot we can see that glucose level does not affect missingness of
# insulin data. I would say that this argues for that the missingness is more
# more random.

# 8. Recode Outcome as a factor
diabetes_data <- diabetes_data %>% mutate(across(Outcome, as.factor))

# 9. Impute missing values
mean_Glucose <- mean(diabetes_data$Glucose, na.rm = TRUE)
mean_BP <- mean(diabetes_data$BloodPressure, na.rm = TRUE)
mean_ST <- mean(diabetes_data$SkinThickness, na.rm = TRUE)
mean_Insulin <- mean(diabetes_data$Insulin, na.rm = TRUE)
mean_BMI <- mean(diabetes_data$BMI, na.rm = TRUE)


diabetes_data_imputed <- diabetes_data |>
    mutate(Glucose = replace_na(Glucose, mean_Glucose))
diabetes_data_imputed <- diabetes_data_imputed |>
    mutate(BloodPressure = replace_na(BloodPressure, mean_BP))
diabetes_data_imputed <- diabetes_data_imputed |>
    mutate(SkinThickness = replace_na(SkinThickness, mean_ST))
diabetes_data_imputed <- diabetes_data_imputed |>
    mutate(Insulin = replace_na(Insulin, mean_Insulin))
diabetes_data_imputed <- diabetes_data_imputed |>
    mutate(BMI = replace_na(BMI, mean_BMI))

imputed_data <- diabetes_data_imputed

# 10. Find a logistic regression model with significant predictors
logistic_model <- diabetes_data_imputed |> glm(formula = Outcome ~ Pregnancies + Glucose + BMI, family = binomial)
summary(logistic_model)
# 11. Compute accuracy of your model
pred_probs <- predict(logistic_model, type = "response")

pred_Outcome <- ifelse(pred_probs >= 0.5, 1, 0)

actual_Outcome <- diabetes_data_imputed$Outcome

accuracy <- mean(pred_Outcome == actual_Outcome)
accuracy
# Text answer...
# Since in reality we would want to use the model to predict diabetes for new
# individuals it would have been better to either do a cross validation or train
# test split in order to ensure the robustness of the prediction. If the
# prediction cases are completely new and unseen by the model we would be able
# to prove its performance on new data.
