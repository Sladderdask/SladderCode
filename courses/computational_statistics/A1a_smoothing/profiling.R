library(profvis)

source(here::here("courses/computational_statistics/", "profiling.R"))


profvis(lec_kern_dens(x, 0.2, grid))

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

