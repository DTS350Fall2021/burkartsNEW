library(tidyverse)
iris_data <- iris 

tibble(iris_data)

#arrange the iris data by Sepal.Length
arrange_Sepal.Length <- arrange(iris_data, Sepal.Length)
head(arrange_Sepal.Length, 10)

#Select Species and Petal.Width 
testdat <- select(iris_data, Species, Petal.Width)

#Create species_mean
species_mean <- group_by(iris_data, Species)
species_mean <- summarize(species_mean, v1 = mean(Sepal.Length), v2 = mean(Sepal.Width), 
                                                          v3 = mean(Petal.Length),
                                                          v4 = mean(Petal.Width))
species_mean

#Create iris_min
iris_min <- filter(iris_data, Sepal.Width >= 3, Petal.Width != 2.5)
head(iris_min)

#Create iris_size
iris_size <- iris_data %>%
  mutate(Sepal.Size = 
           case_when(
             Sepal.Length < 5 ~ "small",
             Sepal.Length >= 5 & Sepal.Length < 6.5 ~ "medium",
             Sepal.Length >= 6.5 ~ "large"))
head(iris_size)   

#Create iris_rank
iris_rank <- iris_data %>%
  arrange(desc(Petal.Length))
head(iris_rank)

#Use summarise_all()
?summarise_all
means_sd_species <- iris_data %>%
  group_by(Species) %>%
  summarize_all(list(Mean=mean, Std_dev = sd))

means_sd_species
  
            



