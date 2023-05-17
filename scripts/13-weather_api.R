library(openmeteo)
library(dplyr)

#gc <- geocode("Chennai")

fun_gc <- function(city_name = "Chennai") {
  gc <- geocode(city_name) %>%
        dplyr::select(id, name,  latitude, longitude, country_code, timezone)
  return(gc)
}

city_lst <- c("Bengaluru", "Chennai", "Delhi" , "Madurai" ,  "Mumbai")

list_gc <- list()

for(i in 1:length(city_lst)){
  print(i)
  list_gc[[i]] <- fun_gc(city_lst[i])
}

city_gc <- do.call(rbind, list_gc) 

#?
## Save a single object to a file
#saveRDS(city_gc, "city_gc.rds")
## Restore it under a different name
#city_gc <- readRDS("city_gc.rds")

#? save as rda
save(city_gc, file = "./data/city_gc.rda")
load("./data/city_gc.rda")

#
#weather_now(location, timezone = "auto")
#weather_now(c(9.92,78.1), timezone = "Asia/Kolkata")

#? compute weather for multiple cities

# empty list
list_city_weather <- list()

# run through list object
for(i in 1:length(city_lst)){
  print(city_lst[i])
  list_city_weather[[i]] <- weather_now(c(city_gc$latitude[i] , city_gc$longitude[i] ), timezone = city_gc$timezone[i])
}

city_weather_now <- do.call(rbind, list_city_weather) %>%
                    mutate(city = city_lst) %>%
                    relocate(city, .after = datetime )
  
  
