#Install and load packages
library(tidyverse)
install.packages("gapminder")
library(gapminder)

#Remove gapminder
view(gapminder)
life_data <- gapminder %>%
  filter(country != "Kuwait")
view(life_data)

#Recreate graphics
plot1 <- ggplot(data = life_data) +
  scale_y_continuous(trans = "sqrt") +
  geom_point(mapping = aes(size = pop/100000, x = lifeExp, y = gdpPercap, color = continent)) +
  facet_wrap(~ year, nrow = 1) +
  scale_size_continuous(name = "Population (100k)") +
  theme_bw() 
plot1

weighted_gdpPercap <-  life_data %>%
  group_by(year, continent) %>%
  summarise(gdpPercap_weighted = weighted.mean(gdpPercap),
            Population=pop/10000)

plot2 <- ggplot(data = life_data) +
  geom_point(mapping = aes(x = year, y = gdpPercap, color = continent)) +
  geom_line(mapping = aes(x = year, y = gdpPercap, color = continent, group = country )) +
  geom_point(data=weighted_gdpPercap, mapping = aes(x = year, y = gdpPercap_weighted, size = Population)) +
  geom_line(data=weighted_gdpPercap, mapping = aes(x = year, y = gdpPercap_weighted)) +
  facet_wrap(~ continent, nrow = 1) +
  xlab("Year") + ylab("GDP per capita") +
  scale_size_continuous(breaks = c(10000, 20000, 30000)) +
  theme_bw() 
plot2

oceania <- life_data %>%
  filter(continent == "Oceania")
oceania
tail(oceania)
