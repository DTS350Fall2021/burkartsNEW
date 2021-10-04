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