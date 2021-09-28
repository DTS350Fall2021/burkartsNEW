library(tidyverse) 
iris

dim(iris)
str(iris)

head(iris)
tail(iris)
?iris

ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Width, y = Sepal.Length, color = Species, shape = Species))
#Do longer sepal lengths among the species lead to greater sepal widths?
#The sepal length appear to not be positively related to the sepal widths of the species.


ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Width, y = Sepal.Length, color = Species)) + 
  facet_wrap(~ Species) +
  theme(legend.position = "none")
#Which species on average is the largest in length and width?
#The virginica species is the the largest on average.


ggplot(data=iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_point(mapping = aes(color = Species, shape = Species)) +
  geom_smooth()
#As petal length increase does petal width increase as well?
#It appears petal length is positively related to petal width.


ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) +
  geom_bar(color = "black", stat = "bin", bins = 19) + 
  geom_vline(xintercept = mean(iris[["Sepal.Length"]]), linetype = "dotted")
#Which species have the most flowers for a given length?
#This visualization shows how many flowers there are for a given length.