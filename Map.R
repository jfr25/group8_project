install.packages("ggmap")
install.packages('rvest')
library(maps)
library(ggmap)
library(rvest)

library(mapproj)
map <- get_map(location = c(lon=as.numeric(lat_lon[2,2]),lat=as.numeric(lat_lon[2,1])), zoom = 15)
ggmap(map) + geom_point(data = lat_lon, 
                        aes(lon, lat, col = , size = )) + 
  scale_size(name="Music Mapp") + 
  xlab("Longitude") + ylab("Latitude")
ggmap(map)
