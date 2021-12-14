library(readr)
library(haven)
library(readxl)
library(ggplot2)
library(tidyverse)
library(foreign)
library(downloader)
library(maps)
library(sf)
library(cowplot)

obesity_data <- read_csv("rows.csv")
head(obesity_data)
tail(obesity_data)
view(obesity_data)



#read in state obesity data

state_obesity <- tempfile()
download("https://www.cdc.gov/obesity/data/maps/2020/2020-overall.csv", state_obesity, mode = "wb")
state_obesity <- read_csv(state_obesity)
head(state_obesity)

#create tibble with only state names
my_states <- state_obesity%>%
  select(State)
head(my_states)
str(my_states)
view(my_states)

my_states1 <- my_states %>% filter(!State %in% c("Guam", "District of Columbia", "Puerto Rico", "Alaska", "Hawaii"))
view(my_states1)

#create "State" column 
my_us_obesity <- obesity_data%>%
  mutate(States = LocationDesc)
view(my_us_obesity)

#filter out any non-states 
us_obesity <- semi_join(my_us_obesity, my_states1, by = c("States"="State"))
head(us_obesity)

#group_by question_id
questions <- us_obesity %>%
  arrange(QuestionID)
head(questions)

#select useful columns
less_columns <- questions%>%
  select(c("YearEnd", "Question", "Data_Value", "QuestionID", "States", "GeoLocation"))%>%
  drop_na("Data_Value")
head(less_columns)
view(less_columns)

#average out the Data_Values
avg_ID <- less_columns%>%
  group_by(YearEnd, States, QuestionID) %>%
  summarise(Values_Percent = mean(Data_Value))
head(avg_ID)
view(avg_ID)

#pivot wider: give question ID its own column headings
separated_ID <- avg_ID %>%
  #select(-Question) %>%
  pivot_wider(names_from = "QuestionID", values_from = "Values_Percent")
head(separated_ID)
tail(separated_ID)
write.csv(separated_ID, "separated_ID.csv")
rm(separated_ID)
separated_ID <- read_csv("separated_ID.csv")
rm(separated)

#make lower case states column
case_insensitive_states <- separated_ID%>%
  mutate(ID = tolower(States)) %>%
  filter(YearEnd == "2019") %>%
  select("Q036", "ID")
head(case_insensitive_states)
tail(case_insensitive_states)
view(case_insensitive_states)

#create US map
states <- sf::st_as_sf(map("state", plot = FALSE, fill = TRUE))

#join data sets
map_state <- inner_join(case_insensitive_states, states)

head(map_state)
  
sf_map <- st_as_sf(map_state)
head(sf_map)

obesity_map <- ggplot() +
  geom_sf(data = map_state, aes(geometry = geom, fill = Q036)) +
  labs(x = '', y = '' , title = 'Prevalence of Obesity in the Continental United States', fill = "Obesity Rate") +
  scale_size_continuous(name = "Obesity Rates")
obesity_map
ggsave("obesity_map.png")

#select the top 10 states
head(separated_ID)
tail(separated_ID)
view(separated_ID)


Q018 <-  separated_ID %>%
  filter(YearEnd == 2019) %>%
  slice_max(Q018, n=10)
Q036 <- separated_ID %>%
  filter(YearEnd == 2019) %>%
  slice_max(Q036, n=10)
Q019 <-  separated_ID %>%
  filter(YearEnd == 2019) %>%
  slice_max(Q019, n=10)
Q037 <- separated_ID %>%
  filter(YearEnd == 2019) %>%
  slice_max(Q037, n=10)
Q043 <-  separated_ID %>%
  filter(YearEnd == 2019) %>%
  slice_max(Q043, n=10)
Q044 <- separated_ID %>%
  filter(YearEnd == 2019) %>%
  slice_max(Q044, n=10)
Q045 <-  separated_ID %>%
  filter(YearEnd == 2019) %>%
  slice_max(Q045, n=10)
Q046 <- separated_ID %>%
  filter(YearEnd == 2019) %>%
  slice_max(Q046, n=10)
Q047 <-  separated_ID %>%
  filter(YearEnd == 2019) %>%
  slice_max(Q047, n=10)
head(Q044)
view(Q044)


#average the obesity rate across the years
avg_Q036 <- separated_ID %>%
  group_by(YearEnd) %>%
  summarise(Average_Obesity_Rate = mean(Q036))
view(avg_Q036)


# PLOT 1 ... Obesity rates in america from 2011-2019

obesity_time <- ggplot(data = avg_Q036, aes(x = YearEnd, y = Average_Obesity_Rate)) +
  geom_line() +
  theme_bw() +
  ylab("Obesity Rate") +
  xlab("Year") +
  scale_y_continuous(trans='log10') +
  scale_x_continuous(breaks=seq(2011,2019,by=1)) +
  ggtitle("Obesity Across Time") 
obesity_time
ggsave("obesity_time.png")


#FIRST COMPARISON PLOT
#Obesity rates compared to low fruit consumption in the U.S.
p1 <- ggplot(data = Q018, aes(x = States, y = Q018)) +
  geom_col() +
  theme_bw() +
  ylab("% Fruit Eaters") +
  labs(title = "10 States with Lowest Fruit Consumption", 
       subtitle = "Consume Fruit Less Than One Time Daily") +
  theme(axis.text.x=element_text(angle = 25, face = "bold", color = "red"))
p1

p2 <- ggplot(data = Q036, aes(x = States, y = Q036)) +
  geom_col() +
  theme_bw() +
  ylab("Obesity Rate") +
  labs(title = "10 most Obese States in the Continental U.S.",
       subtitle = "Percent Obesity Rates") +
  theme(axis.text.x=element_text(angle = 25, face = "bold", color = "red"))
p2

#combine the two plots
plot_row <- plot_grid(p1, p2)

# now add the title
title <- ggdraw() + 
  draw_label(
    "Low Fruit Consumption vs. High Obesity Rates",
    fontface = 'bold',
    x = 0,
    hjust = 0
  ) +
  theme_bw()

low_fruit_consumption <- plot_grid(
  title, plot_row,
  ncol = 1,
  # rel_heights values control vertical title margins
  rel_heights = c(0.1, 1)
)
low_fruit_consumption
ggsave("low_fruit_consumption.png")

#SECOND COMPARISON PLOT
#Obesity rates compared to low vegetable consumption in the U.S.
p3 <- ggplot(data = Q019, aes(x = States, y = Q019)) +
  geom_col() +
  theme_bw() +
  ylab("% Vegetable Eaters") +
  labs(title = "10 States with Lowest Vegetable Consumption", 
       subtitle = "Consume Vegetables Less Than One Time Daily") +
  theme(axis.text.x=element_text(angle = 25, face = "bold", color = "red"))
p3


#combine the two plots
plot_row1 <- plot_grid(p3, p2)

# now add the title
title1 <- ggdraw() + 
  draw_label(
    "Low Vegetable Consumption vs. High Obesity Rates",
    fontface = 'bold',
    x = 0,
    hjust = 0
  ) +
  theme_bw()

low_vegetable_consumption <- plot_grid(
  title1, plot_row1,
  ncol = 1,
  # rel_heights values control vertical title margins
  rel_heights = c(0.1, 1)
)
low_vegetable_consumption
ggsave("low_vegetable_consumption.png")


#THIRD COMPARISON PLOT

p4 <- ggplot(data = Q043, aes(x = States, y = Q043)) +
  geom_col() +
  theme_bw() +
  ylab("Aerobic Adults") +
  labs(title = "Top 10 Most Active States",
       subtitle = "150 of Moderate or 75 of Vigorous Aerobic Exercise") +
  theme(axis.text.x=element_text(angle = 25, face = "bold", color = "red"))
p4

#combine the two plots
plot_row2 <- plot_grid(p4, p2)

# now add the title
title2 <- ggdraw() + 
  draw_label(
    "Aerobic Adults vs. High Obesity Rates",
    fontface = 'bold',
    x = 0,
    hjust = 0
  ) +
  theme_bw()

aerobic_adults <- plot_grid(
  title2, plot_row2,
  ncol = 1,
  # rel_heights values control vertical title margins
  rel_heights = c(0.1, 1)
)
aerobic_adults
ggsave("aerobic_adults.png")


#FOURTH COMPARISON PLOT
p5 <- ggplot(data = Q046, aes(x = States, y = Q046)) +
  geom_col() +
  theme_bw() +
  ylab("Lifting Adults") +
  labs(title = "Top 10 Most Active States",
       subtitle = "Muscle-Strengthening Activities >=2 Days/Week") +
  theme(axis.text.x=element_text(angle = 25, face = "bold", color = "red"))
p5


#combine the two plots
plot_row3 <- plot_grid(p5, p2)

# now add the title
title3 <- ggdraw() + 
  draw_label(
    "Lifting Adults vs. High Obesity Rates",
    fontface = 'bold',
    x = 0,
    hjust = 0
  ) +
  theme_bw()

lifting_adults <- plot_grid(
  title3, plot_row3,
  ncol = 1,
  # rel_heights values control vertical title margins
  rel_heights = c(0.1, 1)
)
lifting_adults
ggsave("lifting_adults.png")


#FOURTH COMPARISON PLOT
p6 <- ggplot(data = Q047, aes(x = States, y = Q047)) +
  geom_col() +
  theme_bw() +
  ylab("Inactive Adults") +
  labs(title = "Top 10 Most Inactive States",
       subtitle = "Engage in No Leisure-Time Physical Activity") +
  theme(axis.text.x=element_text(angle = 25, face = "bold", color = "red"))
p6

#combine the two plots
plot_row4 <- plot_grid(p6, p2)

# now add the title
title4 <- ggdraw() + 
  draw_label(
    "Inactive Adults vs. High Obesity Rates",
    fontface = 'bold',
    x = 0,
    hjust = 0
  ) +
  theme_bw()

inactive_adults <- plot_grid(
  title4, plot_row4,
  ncol = 1,
  # rel_heights values control vertical title margins
  rel_heights = c(0.1, 1)
)
inactive_adults
ggsave("inactive_adults.png")
