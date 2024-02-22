####
# Copy the network from the Madina example. Remove extra columns, and add
# weight and weighted distance columns

library(tidyverse)
library(sf)
library(here)

network <- here("Cities",
                "madina-data",
                "Data",
                "network.geojson") |>
  st_read() |>
  mutate(weight = 1,
         distance = as.numeric(st_length(geometry))) |>
  mutate(weighted_distance = weight * distance) |>
  select(distance, weight, weighted_distance) 

st_write(network,
         here("Cities",
              "project-data",
              "network.geojson"))  


