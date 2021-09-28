library(tidyverse)

str(mtcars)
?mtcars

mymtcars <- mtcars %>%
  mutate(vs = as.factor(vs),
         am = as.factor(am),
         gear = as.factor(gear),
         cyl = as.factor(cyl))
#as.factor says make them discrete

str(mymtcars)

ggplot(mymtcars) +
  geom_point(aes(x = cyl, y = mpg, color = vs))

#next one
gss_cat
#how many marital?
gss_cat %>%
  count(marital)

#reorder
relig_summary <- gss_cat %>%
  group_by(relig) %>%
  summarise(
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

ggplot(relig_summary, aes(tvhours, relig)) + geom_point()

#reorder things
ggplot(relig_summary, aes(tvhours, fct_reorder(relig, tvhours))) +
  geom_point()


#next exercise
mpg
str(mpg)

ggplot(mpg, aes( x = class, y = hwy, color = class)) +
  geom_boxplot()

#x values are class
#y values are hwy
#color is class
#must do fct_reorder(as.factor(class, hwy))

mympg <- mpg%>%
  mutate(class = fct_reorder(as.factor(class), hwy))

str(mympg)

ggplot(mympg) +
  geom_boxplot(aes(x = class, y = hwy, fill = class))

mpg %>% count(class)
#final exercise
str(mympg)
mympg %>%
  mutate(class = fct_recode(class,
                              "mini" = "2seater",
                              "light" = "subcompact", 
                            "compact" = "compact",
                            "medium" = "midsize", 
                            "SUV" = "suv",
                            "Pickup trucks and Vans" = "pickup",
                            "Pickup trucks and Vans" = "minivan"))
