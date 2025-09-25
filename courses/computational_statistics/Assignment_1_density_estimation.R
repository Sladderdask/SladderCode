#implement a kernel density estimator using the epanechnikov kernel.



# Implement one or more bandwidth selection algorithms using either AMISE
# plug- in methods or cross validation methods. Test the implementation and
# compare the results of using density() in R

# it may be a good idea to use real data to investigate how bandwidth selection
# works, but for bencmarking and profiling it is best to use sinulated data.
# think about how to make your implementatoin as general as possible.

# a kernel density estimator will estimate a density around datapoints


library(ggplot2)

estimate_R_f2 <- function(x, f_vals) {
  dx <- diff(x)[1]
  # central second differences
  f2 <- numeric(length(f_vals))
  f2[2:(length(f_vals)-1)] <- (f_vals[3:length(f_vals)] - 2*f_vals[2:(length(f_vals)-1)] + f_vals[1:(length(f_vals)-2)]) / dx^2
  # set ends with 2nd order one-sided approx (or drop the edges)
  f2_sq <- f2^2
  # integrate
  Rf2 <- sum(f2_sq) * dx
  return(Rf2)
}


bw_amise_epan <- function(x, grid = NULL, pilot_h = NULL) {
  n <- length(x)
  if (is.null(pilot_h)) pilot_h <- bw.nrd0(x)  # simple pilot
  if (is.null(grid)) grid <- seq(min(x)-3*sd(x), max(x)+3*sd(x), length.out=2048)
  pilot_f <- epanechnikov_kde(grid, x, pilot_h)
  Rf2 <- estimate_R_f2(grid, pilot_f)
  # constants for epanechnikov: R(K)/mu2^2 = 15
  h <- (15 / (Rf2 * n))^(1/5)
  return(h)
}

lec_kern_dens <- function(x, h, grid) {
  y <- numeric(length(grid))
  for (i in seq_along(grid)) {
    for (j in seq_along(x)) {
      y[i] <- y[i] + exp(-(grid[i] - x[j])^2 / (2 * h^2))
    }
  }
  y <- y / (sqrt(2 * pi) * h * length(x))
  list(x = grid, y = y)
}

make_grid <- function(lb, hb, n){
  seq(lb, hb, length.out = n)
}

my_dens <-  function(x, grid, h) {
  lec_kern_dens(x, h, grid)$y
}

r_dens <- function(x, grid, h) {
  density(x, kernel = "gaussian", bw = h,
    from = min(grid), to = max(grid), n = length(grid))$y
}


compare_densities <- function(grid, f1, f2,
                              label1 = "My KDE",
                              label2 = "R density()") {
  stopifnot(length(grid) == length(f1),
            length(grid) == length(f2))

  # put into a tidy data frame
  df <- data.frame(
    x = rep(grid, 2),
    density = c(f1, f2),
    estimator = rep(c(label1, label2), each = length(grid))
  )

  # difference
  df_diff <- data.frame(
    x = grid,
    diff = f1 - f2
  )

  # first plot: both densities
  p1 <- ggplot(df, aes(x = x, y = density, color = estimator)) +
    geom_line(linewidth = 0.2) +
    labs(title = "Comparison of Density Estimates",
         x = "x", y = "Density") +
    theme_light()

  # second plot: difference
  p2 <- ggplot(df_diff, aes(x = x, y = diff)) +
    geom_line(color = "black", linewidth = 0.2) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    labs(title = paste(label1, "-", label2),
         x = "x", y = "Difference") +
    theme_light()

  list(densities = p1, difference = p2)
}



set.seed(69)

x <- rnorm(200)

grid <- make_grid(-5, 5,512)

h <- bw.nrd0(x)

f1 <- my_dens(x, grid, h)

f2 <- r_dens(x, grid, h)


compare_densities(grid, f1, f2)
















