library(tidyverse)
faithful
head(faithful)
?faithful
str(faithful)

plot1 <- ggplot(data = faithful, aes (x = eruptions)) +
  geom_histogram(binwidth = 0.25, color = "white", fill = "blue") +
  theme_minimal() 
plot1

#see slides for the rest
ggplot(data = diamonds)
geom_freqpoly(mapping = aes)

#see slides for the rest
ggplot(fligths)
geom_boxplot()

#see slides for the rest
ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
geom_violin(aes(fill = factor(cyl))) +
  geom_boxplot(width = 0.2)

#see slides for the rest ... must load (ggbeeswarm)
ggplot() +
geom_jitter()

OR 

ggplot() +
  geom_quasirandom

#see slides for the rest ... must load(lvplot::geom_lv)
ggplot() +
  geom_lv()

#see slides for the rest ... ggstance is package that makes flipping the axes easier 
#in ggplot


#10/7/21

#Data Import:
#remember the different ways for temporary files

#use read_lines() to see the first few lines
#(especially helpful for excel files where you need to get rid of some stuff)


#Tidy Data:
#different types of joins: Mutating Joins vs. Filtering Joins
#inner_join needs same variable name. it compares two columns and where they match up it is kept
#right_join: keep everything in the right table, if it doesn't match up then there's an N/A values padded on
#left_join: same but keeps left.
#outer_join keeps everything that can be kept.. stil have NA values wherever they belong

#haven package helps you read in dta files (statstician files)

#DAY13SCRIPT

library(haven)
library(stringr)
library(tidyverse)

library(nycflights13)

head(airlines)
head(airports)
head(planes)
head(weather)
head(flights)

#check that your key is primary and unique
planes %>%
  count(tailnum) %>%
  filter(n>1)

weather %>%
  count(year, month, day, hour, origin) %>%
  filter(n>1)

flights %>% 
  count(year, month, day, flight) %>%
  filter(n>1)

#make things easier, narrow down data

flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

#add the full airline name to our data set 
flights2 %>%
  select(-origin, -dest) %>%
  left_join(airlines, by = "carrier")
#left table here is flights2, right table here is airlines. Could've done reg join here too

#natural join matches up everything with the same variable name. 
#be careful w these and double check column names

#there are more examples of joins in the script

#filtering joins
top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
top_dest

#now find all the flights that go to those destiantions
flights %>%
  semi_join(top_dest)


####MORE TIDY STUFF

#use all_equal()

movie1 <- read_csv(url)
movie2 <- read_csv(url)

all_equal(movie1,movie2)

movie1%>%
  filter (row_number() == 170)

movie2 %>%
  filter(row_number() == 170)

#we can use bind_rows() to combine rows

onemovie <- movie1[1:4, ]
twomovie <- movie2[9:15, ]


###fix missing values using drop_not()

str(who)
who_noNA <- who %>%
  select(1:5)
summary(who_noNA)

who_noNA %>%
  drop_na(new_sp_m014)

###^^CHECK THIS IN SCRIPT 13


###TIDY THE WHO DATA

#can include values_drop_na = TRUE to get rid 
head(who)
who1 <- who %>%
  select(-iso2, -iso3) %>%
  pivot_longer(3:58, names_to = "key", values_to = "value",
               values_drop_na = TRUE)  

who2 <- who1 %>%
  mutate(key = stringr::str_replace(key, "newrel", "new_re"))
###^^CHECK THIS

who3 <- who2%>%
  seperate(key, into = c("h", "type", "age")) %>%
  seperate(age, into_c("gender", "age"), sep = 1)
head(who3)

#drop column h
who4 <- who3%>%
  select(-h)

#if it was a report you could take each of these steps and PIPE IT UP!!




  
  