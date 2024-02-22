####
# This is a rough approximation of students attending
# each school, based on enrollment data in https://somerville.k12.ma.us/sites/default/files/Somerville%20Enrollment%20Forecast%20Memo%202023_2033.pdf

# Attendance areas are approximated based on: http://www.somerville.k12.ma.us/sites/default/files/PIC%20STREET%20DIRECTORY.pdf
# and adjusted to align with census tract boundaries.

library(sf)
library(here)
library(tidyverse)

network <- here("Cities",
                "madina-data",
                "Data",
                "network.geojson") |>
  st_read()

ma_st_plane_meters <- st_crs(network)

school_boundaries <- here("set-up-code",
                          "school-boundaries.geojson") |>
  st_read() |>
  st_transform(ma_st_plane_meters)

brown_students_1to5 <- st_sample(school_boundaries,
                                 size = c(8,
                                          69,
                                          8,
                                          18,
                                          20,
                                          25,
                                          21))

brown_students_k <- st_sample(school_boundaries,
                              size = c(1,
                                       22,
                                       1,
                                       0,
                                       8,
                                       4,
                                       6))

brown_students <- append(brown_students_1to5, brown_students_k) 

wh_students_6to8 <- st_sample(school_boundaries,
                              size = c(23,
                                       0,
                                       44,
                                       37,
                                       9,
                                       5,
                                       63))


wh_students_1to5 <- st_sample(school_boundaries,
                                 size = c(6,
                                          9,
                                          18,
                                          50,
                                          9,
                                          7,
                                          84))

wh_students_k <- st_sample(school_boundaries,
                              size = c(3,
                                       1,
                                       2,
                                       7,
                                       2,
                                       1,
                                       20))

wh_students <- append(wh_students_1to5, wh_students_6to8)
wh_students <- append(wh_students, wh_students_k) 

ggplot(wh_students) +
  geom_sf(color = "purple", alpha = 0.5) +
  geom_sf(data = brown_students, color = "tan", alpha = 0.5) +
  theme_void()


st_write(brown_students, here("Cities",
                              "brown",
                              "Data",
                              "brown-students.geojson"),
         delete_dsn = TRUE)

st_write(wh_students, here("Cities",
                           "winter-hill",
                           "Data",
                           "wh-students.geojson"),
         delete_dsn=TRUE)


tibble(name = c("Willow Ave Entrance",
                "Josephine Ave Entrance"),
       lat = c(42.39730723532119,
               42.397166600027894),
       lon = c(-71.11454082046285, 
               -71.11393866456035)) |>
  st_as_sf(coords = c("lon", "lat"), crs = "WGS84") |>
  st_transform(ma_st_plane_meters) |>
  st_write(here("Cities",
                "brown",
                "Data",
                "brown.geojson"),
           delete_dsn = TRUE)


tibble(name = c("Sycamore St Entrance",
                "Thurston St Entrance",
                "Evergreen St Entrance"),
       lat = c(42.39213011267765, 
               42.39170661243841,
               42.392128554079726),
       lon = c(-71.098730531333, 
               -71.09768895335094,
               -71.09782306379539)) |>
  st_as_sf(coords = c("lon", "lat"), crs = "WGS84") |>
  st_transform(ma_st_plane_meters) |>
  st_write(here("Cities",
                "winter-hill",
                "Data",
                "wh.geojson"),
           delete_dsn=TRUE)

tibble(name = c("Otis St Entrance"),
       lat = c(42.387307948338915),
       lon = c(-71.0876140508018)) |>
  st_as_sf(coords = c("lon", "lat"), crs = "WGS84") |>
  st_transform(ma_st_plane_meters) |>
  st_write(here("Cities",
                "edgerly",
                "Data",
                "edgerly.geojson"),
           delete_dsn=TRUE)
