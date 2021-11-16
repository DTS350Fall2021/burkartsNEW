install.packages("USAboundariesData", repos = "https://ropensci.r-universe.dev", type = "source")
library(USAboundaries)
library(USAboundariesData)
library(maps)
library(sf)
library(lwgeom)


states <- sf::st_as_sf(map("state", plot = FALSE, fill = TRUE))
Idaho <- us_counties(states = "ID")

cities <- us_cities()

head(cities)

#Top 3 from

top3 <- cities %>%
  filter(state_name != "Alaska", state_name != "Hawaii") %>%
  group_by(state_name)%>%
  arrange(desc(population))%>%
  slice(1:3)
  
#top city name for each state
top_city <- top3 %>%
  slice(1:1)

second_city <- top3 %>%
  slice(2:2)

third_city <- top3 %>%
  slice(3:3)
  

ggplot() +
  geom_sf(data = states, fill = NA) +
  geom_sf(data = Idaho, fill = NA) +
  geom_sf(data = third_city, color = 'lightblue', aes(size = population/1000)) +
  geom_sf(data = second_city, color = 'darkblue', aes(size = population/1000)) +
  geom_sf(data = top_city, color = 'blue', aes(size = population/1000)) +
  geom_sf_label(data = top_city, aes(label = city), color = 'darkblue', nudge_x = 1.5, nudge_y = 0.5, size = 2.5) +
  theme_bw() +
  scale_size_continuous(name = "Population (1000)") +
  labs(x = " ", y = " ")
  
ggsave("task20plot.png")

  