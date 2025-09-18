#implement a kernel density estimator using the epanechnikov kernel.



# Implement one or more bandwidth selection algorithms using either AMISE
# plug- in methods or cross validation methods. Test the implementation and
# compare the results of using density() in R

# it may be a good idea to use real data to investigate how bandwidth selection
# works, but for bencmarking and profiling it is best to use sinulated data.
# think about how to make your implementatoin as general as possible.

# a kernel density estimator will estimate a density around datapoints

#




library(tidyverse)



head(greenland)

y = c(0,11,12,13,14,30,56,57,70)

nuuk_year = tibble(Year = y )

dens1 <- density(y, "SJ")

densdf <- tibble(x = dens1$x, y = dens1$y)

summary(nuuk_year)

nuuk_plot <- ggplot(nuuk_year, aes(Year),) +
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = "skyblue") +
  geom_line(data = densdf, aes( x = x, y = y), size = 0.1, color = "red") +
  scale_x_continuous(limits = c(-50, 100)) +
  scale_y_continuous(limits = c(0, 0.2))
nuuk_plot

function(y){

}
