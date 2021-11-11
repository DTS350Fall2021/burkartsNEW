library(readr)
library(haven)
library(readxl)
library(ggplot2)
library(tidyverse)
library(foreign)
library(downloader)

state_obesity <- tempfile()
download("https://www.cdc.gov/obesity/data/maps/2020/2020-overall.csv", state_obesity, mode = "wb")
state_obesity <- read_csv(state_obesity)
head(state_obesity)

white_obesity <- tempfile()
download("https://www.cdc.gov/obesity/data/maps/2020/2020-white.csv", white_obesity, mode = "wb")
white_obesity <- read_csv(white_obesity)
head(white_obesity)
view(white_obesity)

my_white_obesity <- white_obesity %>% slice(-c(32))
view(my_white_obesity)



state_plot <- ggplot(state_obesity, aes(x = State, y = Prevalence)) + 
  geom_col() +
  labs(x = 'State', y = 'Prevalence' , title = 'Prevalence of Obesity by State') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90))
state_plot

ggsave("state.png")


white_plot <- ggplot(my_white_obesity, aes(x = State, y = Prevalence)) + 
  geom_col() +
  labs(x = 'State', y = 'Prevalence' , title = 'Prevalence of Obesity in Non-Hispanic White Adults by State') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90)) 
white_plot

ggsave("white.png")

#From each visualization I learned that there are much more obese people in America than I thought.
#Most states have more than 30% prevalence of obesity.
#Additionally, in some states there are far less non-hispanic white people who have become obese. 
#Why in some states are there far less white people who make up the obese population?
#I will need to find better data as there are some states for specific races who have insufficient data. 
#This data limits me to talking about a percentage of obese people per state by race. If
#I want to discuss other facets of obesity like the levels of obesity, I will have to find new data. 
#I want to use visualizations to communicate how obesity and disease affects people at different time of the year.
#I plan to have my first draft completed by November 25th so I can present to my friends and family over thanksgiving break.
#I plan to have my second draft done by December 5th.
#I plan to have my final draft completed by December 7th. 
#I will present on Thursday December 9th. 
#I will use html for the .Rmd format of my presentation.
