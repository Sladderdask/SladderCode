gauss <- function(x, h = 1) {
  exp(-x^2 / (2 * h^2)) / (h * sqrt(2 * pi))
}


gauss_opt <- function(x, h = 1) {
  c1 <- -1 / 2 * h^2
  c2 <- 1 / h* sqrt(2 * pi)
  c2 * exp(c1 * x^2)
}
