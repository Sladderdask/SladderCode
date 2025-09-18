library(ggplot2)

#definitions Anki
#smoothing descriptive tool for summarizing and visuzlizing data,
#as well as computational topics
#monte carlo methods
#Optimization
#implementation
#correctness
#efficiency

# Lecture 1
greet <- function(name = NA){
  if(is.na(name)){
    return("Hello World")
  }
  paste("Hello", name)
}

greet("Dennis")

is_even <- function(x = NA){
  if(is.na(x)){
    return("ERROR, Please enter value.")
  }
  stopifnot(is.numeric(x))
  i <- x%%2
  if(i == 1){
    return(paste(x, "is odd"))
  }
  paste(x, "is even.")
}

is_even()

x <- seq(50,100,10)
x[2] <- NA
x
w <- seq(1,0.5,-0.1)
w

wheighted_mean <- function(x,w,...){

  sum(x*w, ...)/sum(w)
}


wheighted_mean(x,w, na.rm = TRUE)
x*w


sum(w)

#LeCture 2


make_point <- function(x, y) {
  structure(
    list(
    x = x,
    y = y
    ),
    class = "point"
  )
}

p <- make_point(3,4)
p

print.point <- function(obj) {
  cat("(", obj$x, ",", obj$y, ")\n", sep = "")
}
print.point(p)


distance_from_origin <- function(x,...){
  UseMethod("distance_from_origin")
}

distance_from_origin.point <- function(x) {
  sqrt(point$x^2 + point$y^2)
}

distance_from_origin.defult <- function(x, ...){
  if (!is.numeric || length(x) != 2) {
    stop("x must be a numeric vector of length 2")
  }

  sqrt(x[1]^2 + y[2]^2)

}

distance_from_origin(p)
p


#----------------------------------------

Alice <- list(name= "Alice", age = 25)
Bob <- list(name= "Bob", age = 30)

class(Alice) <- "my_person"
class(Bob) <- "my_person"

print.my_person <- function(x, ...) {
  cat("my_person:", x$name, "is", x$age, "years old.\n")
}

birthday <- function(x, ...){
  UseMethod("birthday")
}

birthday.my_person <- function(x) {
  x$age <- x$age + 1
  cat(x$name, "had a birthday! Now", x$name, "is", x$age, "years old\n")
  return(x)
}

Charlie <- list(name = "Charlie", age = 20, major = "Math")
class(Charlie) <- c("student", "my_person")

print.student <- function(x) {
  cat("Student:", x$name, "is", x$age, "and studies", x$major, ".\n")
}

birthday(Charlie)
Charlie2 <- birthday(Charlie2)

birthday(Charlie2)

Charlie2
birthday(Charlie)

birthday(Alice)
birthday(Bob)

Bob$age <- 31
class(Bob)
Alice
Bob

class(Charlie)

methods("birthday")

methods(class = "my_person")

getS3method("print","person")


#3 gaussians,

n = 1000
probs <- c(0.4,0.4,0.2)
means <- c(0,3,4)
sds <- c(2,0.5,2)






y = c(rnorm(100,mean = 1, sd = 0.4), rnorm(100,mean = 3.5, sd = 0.4), rnorm(100,mean = 5, sd = 0.4))
density(y)
y

library(ggplot2)

# Assume y is your data
# Histogram as data frame
df <- data.frame(y = y)

# Compute density estimates
dens1 <- density(y, adjust = 0.5, bw = "nrd0")
dens2 <- density(y, adjust = 2, bw = "nrd")
dens3 <- density(y, adjust = 0.5, bw = "SJ")

# Convert to data frames
df_dens1 <- data.frame(x = dens1$x, y = dens1$y, method = "nrd0, adjust=0.1")
df_dens2 <- data.frame(x = dens2$x, y = dens2$y, method = "nrd, adjust=2")
df_dens3 <- data.frame(x = dens3$x, y = dens3$y, method = "SJ, adjust=0.5")

# Combine densities
df_dens <- rbind(df_dens1, df_dens2, df_dens3)

ggplot(df, aes(x = y)) +
  geom_histogram(aes(y = ..density..),  bins = 100, fill = "grey80") +
  geom_line(data = df_dens, aes(x = x, y = y, color = method), size = 1) +
  theme_minimal() +
  labs(y = "y", x = "Density", color = "Bandwidth Method")


df <- diamonds

summary(df)

df[cut]

sort(df$cut)


ggplot(df, aes(x = reorder(cut, -..count..), fill = cut)) +
  geom_bar()
















# Plot
ggplot(df, aes(x = y)) +
  geom_histogram(aes(y = ..density..), bins = 200, fill = "grey80") +
  geom_line(data = df_dens, aes(x = x, y = y, color = method), size = 1) +
  theme_minimal() +
  labs(x = "y", y = "Density", color = "Bandwidth Method")


hist(y, freq=FALSE, breaks = 100)
lines(density(y, adjust = 0.1, bw = "nrd0"), col = "blue")
lines(density(y, adjust = 2, bw = "nrd"), col = "red")
lines(density(y, adjust = 0.5,bw = "SJ"), col = "green")

plot(y)
h <- ggplot(y, aes(y)) +
  geom_histogram(bins = 100)
h


density(x, bw = "nrd")


library(bench)

#Exercise 1
# Benchmark gauss() against dnorm(); plot and compare the results.
# Before starting:
# which do you think will be faster?

gauss <- function(x, h = 1) {
  exp(-x^2 / (2 * h^2)) / (h * sqrt(2 * pi))
}


gauss_opt <- function(x, h = 1) {
  c1 <- -1 / 2 * h^2
  c2 <- 1 / h* sqrt(2 * pi)
  c2 * exp(c1 * x^2)
}

x <- seq(-5,5,length.out = 1e6)

first_bench <- bench::mark(
  gauss(x),
  gauss_opt(x),
  dnorm(x)
)

first_bench

#gauss was faster which i did not expec since dnorm is written in C++ code which
# should be faster. however gauss was faster

library(profvis)

#Exercise 2
# Profile gauss(). Where is the bottleneck? Can you improve the performance?

y <- source(here::here("courses","computational_statistics", "profiling.R"))
y
profvis(gauss_opt(x))

#Exercise 3
# Write a parallelized version of the gauss() function using the foreach package. Your
# function should take a vector and devide the work across multiple cores.
# Benchmark your implementation against the original gauss() function.


#E1
library(foreach)
library(doParallel)
cl <- makeCluster(2)
registerDoParallel(cl)

foreach(i=seq_len(3)) %dopar%
  {
    paste(
      sqrt(i),
      Sys.getpid()
    )
  }




v <- c(1,2,3,4,5,6)











