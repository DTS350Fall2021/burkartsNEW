library(lubridate)
library(tidyverse)
library(downloader)
library(readxl)
library(ggrepel)

urlfile = "https://raw.githubusercontent.com/fivethirtyeight/data/master/candy-power-ranking/candy-data.csv"
fav_candy <- read_csv(url(urlfile))

view(fav_candy)
head(fav_candy)
tail(fav_candy)

ggplot(fav_candy, aes(x = winpercent, y = competitorname, color = "Orange")) +
  geom_bar(stat = "identity") 

top_fav_candy <- filter(fav_candy, winpercent>=66)


plot1 <- ggplot(top_fav_candy, aes(x = winpercent, fct_reorder(competitorname, winpercent), fill = "orange")) +
  geom_bar(stat = "identity") + 
  theme(legend.position = "none",axis.title.y = element_blank()) + 
  xlab(label = "Win Percentage (%)") +
  ggtitle("How often did a fun-sized candy of a given type win its matchups against the rest of the field?") +
  geom_text(aes(label=winpercent), position=position_dodge(width=0.9), vjust=-0.25)
plot1

ggsave("plot1.png")


#Second Graphic
winpercent2 <- fav_candy %>%
  select(competitorname, winpercent)

head(winpercent2)

candyLonger <- fav_candy %>%
  select(competitorname:pluribus) %>%
  pivot_longer(!competitorname, names_to = 'description', values_to = 'yesno') %>%
  filter(yesno == 1) %>%
  select(competitorname, description) %>%
  left_join(winpercent2)

head(candyLonger)
view(candyLonger)



plot2 <- ggplot(candyLonger, aes(x = winpercent, fct_reorder(description, winpercent), fill = description)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Oranges") +
  theme(legend.position = "none",axis.title.y = element_blank()) + 
  xlab(label = "Win Percentage")
plot2
ggsave("plot2.png")

#coord_flip makes the bars horizontal on a geom_col

