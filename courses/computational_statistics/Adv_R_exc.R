library(tidyverse)
library(lobstr)

df <- data.frame(runif(3), runif(3))
names(df) <- c(1, 2)
df$"3" <- runi
df


x <- runif(1e6)
y <- list(x, x, x)
obj_size(y)

# the names: a,b,c point toward an object 1:10, d point toward an object 1:10

ref(x, character = TRUE)



#1
#> because the object 1:10 that is created in the tracemem instance will
#>trace how that object is transferred and copied, since it  will be "stuck"
#>inside of the function it will not be transferred.

#2
x <- c(1L, 2L, 3L)
tracemem(x)

x[[3]] <- 4
x
# First it is copied over to


#> obj.size returns an estimates size of an r object while obj size returs the
#> actual size of an object.
#>
#>
#>
#>
funs <- list(mean, sd, var)
obj_size(funs)
#> 18.76 kB
#> this shows the size of the actual functions in r, so the code that represents
#> the different functions.
x <- data.frame(matrix(runif(5 * 1e4), ncol = 5))
head(x)
medians <- vapply(x, median, numeric(1))
medians
for (i in seq_along(medians)) {
  x[[i]] <- x[[i]] - medians[[i]]
}


x <- list()
x[[1]] <- x
ref(x)

#> lists can't contain themselves

y <- as.list(x)
cat(tracemem(y), "\n")
#> <0x7f80c5c3de20>
library(bench)

x <- data.frame(matrix(runif(5 * 1e4), ncol = 100))
medians <- vapply(x, median, numeric(1))

y <-  as.list(x)



f1 <-  function(x,medians){
  for (i in seq_along(medians)) {
    x[[i]] <- x[[i]] - medians[[i]]
  }
}

f2 <- function(y,medians){
  for (i in 1:5) {
    y[[i]] <- y[[i]] - medians[[i]]
  }
}

bnch <- bench::mark(
  f1(x,medians),
  f2(y,medians)
)

bnch

e1 <- rlang::env(a = 1, b = 2, c = 3)

tracemem(e1)
#> i get an error since environments will always reserve the same spot in
#> memory, it will never change. therefore there is no reaon to trace
#> its location.


