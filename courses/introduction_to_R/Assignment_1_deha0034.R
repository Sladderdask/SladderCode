#####-----Title------####
# Introduction to R - Assignment 1



#####-----Q1------####

mtcars <- get(data("mtcars"))

car_countries <- c("Japan", "Japan", "Japan", "USA", "USA",
                   "USA", "USA", "Germany", "Germany", "Germany", "Germany",
                   "Germany", "Germany", "Germany", "USA",
                   "USA", "USA", "Italy", "Japan",
                   "Japan", "Japan", "USA", "USA",
                   "USA", "USA", "Italy", "Germany", "UK",
                   "USA", "Italy", "Italy", "Sweden")

mtcars$car_countries <- car_countries

avgeff <- mean(mtcars$mpg)

below_average = c()
above_average = c()

for(index in 1:nrow(mtcars)){
  if(mtcars$mpg[index] < avgeff){
    below_average <- c(below_average, mtcars$mpg[index])
  }else{
    above_average <- c(above_average, mtcars$mpg[index])
  }
}

#####-----Q2------####

USA_cars <- mtcars[mtcars$car_countries == "USA",]
Japan_cars <- mtcars[mtcars$car_countries == "Japan",]

#####-----Q3------####

mpg_pc <- c()
for(i in 1:nrow(USA_cars)){
  temp <- USA_cars$mpg[i] / USA_cars$cyl[i]
  mpg_pc <- c(mpg_pc, temp)
}

mpg_pc
mpg_per_cyl_USA <-mean(mpg_pc)

mpg_pc <- c()
for(i in 1:nrow (Japan_cars)){
  temp <- Japan_cars$mpg[i] / Japan_cars$cyl[i]
  mpg_pc <- c(mpg_pc, temp)
}
mpg_pc

mpg_per_cyl_Japan <-mean(mpg_pc)

mpg_per_cyl_USA
mpg_per_cyl_Japan
#####-----Q4------####
#install.packages('billboard')
#You need to run the install only once.
# Comment it out by removing the #, then comment it out again

library(billboard)
spotify_track_data <-  get(data("spotify_track_data"))
print(head(spotify_track_data))
dim(spotify_track_data)
help(data("spotify_track_data"))

artists <- c("Rihanna", "Michael Jacksson", "Elvis Presley", "Eminem")

my_playlist <- spotify_track_data[spotify_track_data$artist_name %in% artists,]

#####-----Q5------####

dance_tracks <-my_playlist[my_playlist$danceability > median(my_playlist$danceability),]

#####-----Q6------####


Rihanna_dance_tracks <- nrow(dance_tracks[dance_tracks$artist_name == "Rihanna",]) / nrow(my_playlist)
Rihanna_dance_tracks

#####-----Q7------####

# Note: Do not alter the original spotify_track_data dataset!
# You should alter only the corrected_playlist dataset.

corrected_playlist <- spotify_track_data
corrected_playlist[corrected_playlist$artist_name == "Michael Jacksson", "danceability"] <- corrected_playlist[corrected_playlist$artist_name == "Michael Jacksson", "danceability"] - 0.05
