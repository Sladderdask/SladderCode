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








































