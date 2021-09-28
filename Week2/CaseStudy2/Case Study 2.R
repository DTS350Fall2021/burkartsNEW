#Load Library----
library(tidyverse)

#Load Data----
urlfile = "https://github.com/DTS350Fall2021/burkarts.git"
mydata <- read_csv(url(urlfile))

str(mydata)
head(mydata)

#Creating Graph----
#Theme
th <- theme(legend.title = element_blank(), legend.justification = c(0, 1), 
            legend.key.width = unit(1, "lines"), 
            plot.margin = unit(c(1, 5, 0.5, 0.5), "lines"),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            plot.caption = element_text(hjust = 0, colour = 'gray40'),
            plot.title = element_text(size = 16,margin = margin(t = 1)),
            plot.subtitle = element_text(size = 10), 
            axis.ticks.x = element_line(color = "black"),
            axis.ticks.y = element_line(color = "white"),
            axis.text.y = element_text(margin = margin(r = 0)),
            axis.text.x = element_text(margin = margin(t = 0)),
            panel.background = element_rect(fill = "white"),
            panel.grid.major.y = element_line(color = "gray", linetype = "dotted"),
            axis.text = element_text(color = "black")
)

description <- labs( 
  subtitle = "The number of moderate (up to 30% of corals affected) and severe bleaching events (more than 30% corals) measured at 100 \nfixed global locations. Bleaching occurs when stressful conditions cause corals to expel their algai symbiots.", 
  caption = "Source: Hughes, T. P., et al. (2018). Spatial and temporal patterns of mass bleaching of corals in the Anthropocene. Science. \nOurWorldInData.org/biodiversity · CC BY"
)

legend <- scale_fill_manual(values = c("cyan4", "firebrick3"), labels = c("Moderate (<30%)",
                                                                          "Severe (>30%)")
)

#Graphs----

#Australasia data
aust_data <- filter(mydata, Entity == 'Australasia')
ggplot(data = aust_data, aes(x = Year, y = Value, fill = Event)) +
  geom_col() +
  ggtitle("Number of coral bleaching events, Australasia") +
  scale_x_continuous(breaks = seq(1980, 2016, 3), expand = c(0, 0.1)) +
  scale_y_continuous(breaks = seq(0, 25, 5), expand = c(0, 0)) +
  description +
  legend +
  th

#Indian Ocean/Middle East data
ind_mideast_data <- filter(mydata, Entity == 'Indian Ocean/Middle East')
ggplot(data = ind_mideast_data, aes(x = Year, y = Value, fill = Event)) +
  geom_col() +
  ggtitle("Number of coral bleaching events, Indian Ocean/Middle East") +
  scale_x_continuous(breaks = seq(1980, 2016, 3), expand = c(0, 0.1)) +
  scale_y_continuous(breaks = seq(0, 20, 5), expand = c(0, 0)) +
  description +
  legend +
  th

#Pacific data
pac_data <- filter(mydata, Entity == 'Pacific')
ggplot(data = pac_data, aes(x = Year, y = Value, fill = Event)) +
  geom_col() +
  ggtitle("Number of coral bleaching events, Pacific") +
  scale_x_continuous(breaks = seq(1980, 2016, 3), expand = c(0, 0.1)) +
  scale_y_continuous(breaks = seq(0, 12, 2), expand = c(0, 0)) +
  description +
  legend +
  th

#West Atlantic
wst_atl_data <- filter(mydata, Entity == 'West Atlantic')
ggplot(data = wst_atl_data, aes(x = Year, y = Value, fill = Event)) +
  geom_col() +
  ggtitle("Number of coral bleaching events, West Atlantic") +
  scale_x_continuous(breaks = seq(1980, 2016, 3), expand = c(0, 0.1)) +
  scale_y_continuous(breaks = seq(0, 20, 5), expand = c(0, 0)) +
  description +
  legend +
  th

#World
worl_data <- filter(mydata, Entity == 'World')
ggplot(data = worl_data, aes(x = Year, y = Value, fill = Event)) +
  geom_col() +
  ggtitle("Number of coral bleaching events, World") +
  scale_x_continuous(breaks = seq(1980, 2016, 3), expand = c(0, 0.1)) +
  scale_y_continuous(breaks = seq(0, 70, 10), expand = c(0, 0)) +
  description +
  legend +
  th

#Response----
# Without the bleaching spike in 1988, coral bleaching appears to be slowly increasing.
# Additionally, there seems to be an increased number of bleaching spikes with larger spikes. 

#Additional graph----
#Linear Regression for all data
ggplot(mydata, aes(x = Year, y = Value)) +
  geom_point( aes(color = Event, shape = Event)) +
  geom_smooth() +
  ggtitle("Number of coral bleaching events") +
  scale_x_continuous(breaks = seq(1980, 2016, 3)) +
  scale_y_continuous(breaks = seq(0, 55, 5)) +
  description +
  theme_classic()
#The trend shows that coral bleaching is rising slowly but gradually.
