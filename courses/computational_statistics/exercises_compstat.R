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

#A4
infrared <- read.table("https://math-ku.github.io/compstat/data/infrared.txt", header = TRUE)
F12 <- infrared$F12
summary(F12)
head(F12)
F12

df <- data.frame(x = log(F12))
df

ggplot(df, aes(x = x, fill = "grey")) +
  geom_histogram(aes(x = x), binwidth = 0.2, col = "black")



