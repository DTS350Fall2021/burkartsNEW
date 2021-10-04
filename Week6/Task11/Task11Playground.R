#investigate data
library(tidyverse)
library(dplyr)
library(ggplot2)

devtools::install_github("drsimonj/ourworldindata")
head(financing_healthcare)
tail(financing_healthcare)
summary(financing_healthcare)

#GOAL ==> summarize child mortality(child_mort) in a single plot
#filter out the years before 1960 to get more current information <- 
#group by continent and year 


plot1 <- financing_healthcare %>% 
  filter(year >= 1925 & !is.na(continent)) %>%
  group_by(continent, year) %>% 
  summarise(child_mort = mean(child_mort, na.rm = TRUE)) %>% 
  ggplot(aes(x = year, y = child_mort, color = continent)) +
  geom_line(size = 1) +
  theme_bw() +
  labs(title = "Child Mortality by Continent",
   x = "",
    y = "The Share of Children Dying Before Their Fifth Birthday")
plot1

