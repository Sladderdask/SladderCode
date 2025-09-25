#A1
(0.1 + 0.1 + 0.1) > 0.3
#This is true because of how float numbers are stored, since they are
#64 bit which means that they they can not be exact, instead they will be the
#closest 64 bit approximation to 64. do sprintf("%.17f",0.1)
#A2


x = seq(0,1,0.1)
h = 0.3

a2(x,h)

gt_h <- function(x,h, tol = 1e-10) x[x-h > tol]

gt_h(x,h)


x > h

#A3

x[2] <- NA
x[3] <- NaN
x[4] <- Inf
x[5] <- -Inf

x
gt_h <- function(x,h, tol = 1e-10) {
  na_removed <- x[!(is.nan(x) | is.na(x))]
  na_removed[na_removed-h > tol]
  }
gt_h(x,h)


gt_h4 <- function(x,h) (x <- x[!(is.na(x)|is.nan(x))])[h < x]

gt_h4(x,h)

library(ggplot2)
library(bench)
#A4
infrared <- read.table("https://math-ku.github.io/compstat/data/infrared.txt", header = TRUE)
F12 <- infrared$F12
summary(F12)
head(F12)
F12

df <- data.frame(x = log(F12))
df

ggplot(df, aes(x = x, fill = "grey")) +
  geom_histogram(aes(x = x), binwidth = 1, col = "black")


#A5
my_breaks <- function(x, h = 5){
  x <- sort(x)
  ux <- unique(x)
  i <- seq(1, length(ux), h)

  if (i[length(i)] < length(ux)) {
    i[length(i) + 1] <- length(ux)
  }
  ux[i]

}

x <- c(1,2,3,4,5,6,7)
h <- 2

print(my_breaks(x,h))

my_breaks <- function(x, h = 5) (us <- unique(sort(x)))[c(seq(1, length(us), h), length(us)[!!(length(us) - 1) %% h])]

#6


set.seed(42)
n = 100
x = runif(n, min = 0, max = 100)

set.seed(42)
n <- 100
x <- runif(n, min = 0, max = 100)

m <- 0  # Initial slope
b <- 0  # Initial intercept
alpha <- 0.00001  # Learning rate
iterations <- 10  # Number of iterations

a <-  1+exp(x)

b <-  (x - 2)^2

y <-  log(a, base = 10) + b/2




gradient_descent <- function(x, y, m, b, alpha, iterations) {
  n <- length(y)  # Number of data points
  cost_history <- numeric(iterations)  # To store the cost at each iteration

  for (i in 1:iterations) {
    # Predicted values
    y_pred <- m * x + b

    # Calculate gradients
    gradient_m <- -(2/n) * sum(x * (y - y_pred))  # Gradient for slope (m)
    gradient_b <- -(2/n) * sum(y - y_pred)  # Gradient for intercept (b)

    # Update parameters
    m <- m - alpha * gradient_m
    b <- b - alpha * gradient_b

    # Calculate and store the cost (Mean Squared Error)
    cost <- sum((y - y_pred)^2) / n
    cost_history[i] <- cost

    # Print the cost every 100 iterations
    if (i %% 100 == 0) {
      cat("Iteration:", i, " Cost:", cost, "\n")
    }
  }

  return(list(m = m, b = b, cost_history = cost_history))
}

# Run the gradient descent algorithm
result <- gradient_descent(x, y, m, b, alpha, iterations)

# Extract final slope, intercept, and cost history
final_m <- result$m
final_b <- result$b
cost_history <- result$cost_history
cost_history

plot(x, y, main = "Gradient Descent: Fitted Line", xlab = "x", ylab = "y")
abline(a = final_b, b = final_m, col = "red", lwd = 2)




bench::mark()





