install.packages("ggrepel")
library(tidyverse)
library(ggrepel)

#investigate relationship between sepal width and sepal length
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point()

#Properly label chart
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  labs(x = "Sepal Width (cm)",
       y = "Sepal Length (cm)",
       title = "We can predict Setosa's sepal length from its width",
       subtitle = "Versicolor and Virginica are not predictable",
       caption = "Source: iris",
       shape = "Species of Iris",
       color = "Species of Iris")
#It kept both legends because there was a seperate color.
#Once we add in color = "Species of Iris" the old legend is dropped off. 


best_flower <- iris %>%
  group_by(Species) %>%
  filter(row_number(desc(Sepal.Width)) == 1)

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length)) +
  geom_point(aes(color = Species, shape = Species)) +
  geom_point(size = 3, shape = 1, color = "black", data = best_flower) +
  ggrepel::geom_label_repel(aes(color = Species, label = Species), data = best_flower) +
  labs(x = "Sepal Width (cm)",
       y = "Sepal Length (cm)",
       title = "We can predict Setosa's sepal length from its width",
       subtitle = "Versicolor and Virginica are not predictable",
       caption = "Source: iris") +
  theme(legend.position = "none")

#Changing x and y axis to a scale and change the color.
ggplot(data = iris, mapping = aes(x=Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("purple", "darkorange", "blue")) +
  scale_shape_manual(values =  c(1, 5, 7)) 

#Calculating averages.
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, color = Species, shape = Species)) +
  geom_point() +
  geom_hline(data = averages, mapping = aes( yintercept = avglength), color = "red") +
  scale_shape_manual(values =  c(1, 5, 7)) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("purple", "orange", "blue")) +
  labs(x = "Sepal Width (cm)",
       y = "Sepal Length (cm)",
       title = "This is where I would put a title",
       shape = "Species of Iris",
       color = "Species of Iris") +
  theme_bw()
averages <- iris %>% group_by(Species) %>% mutate(avglength = mean(Sepal.Length))
