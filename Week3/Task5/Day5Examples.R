install.packages("downloader")
library(tidyverse)
library(downloader)
library(readxl)

money <- c("4,554,25", "$45", "8025.33cents", "288f45")

as.numeric(money)
#my output is a warning message
parse_number(money)
#with parse several numbers were ouputted but the numeric gave me a warning message


#example 2
my_string <- c("123", ".", "3a", "5.4")
parse_integer(my_string, na = ".")

problems(my_string)
#this code gives me an error message because ".", "3a", and "5.4" are all not integers
#the code expected to see an actual integer.

#Example 3
challenge <-  read_csv(readr_example("challenge.csv"))

problems(challenge)
head(challenge)
tail(challenge)

#there is no data type for Y

challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)

head(challenge)
tail(challenge)
view(challenge)
#Now there are dates for the last several y values. We can assume they did not start keeping track of the date until later on.

#Example 4
download("https://educationdata.urban.org/csv/ipeds/colleges_ipeds_completers.csv",
              "colleges_ipeds_completers.csv")
ipeds <- read_csv("colleges_ipeds_completers.csv")


#Example 5
bob <- tempfile()
download("https://educationdata.urban.org/csv/ipeds/colleges_ipeds_completers.csv", bob, mode = "wb")
ipeds <- read_csv(bob)

#Example 6
ipeds_2011 <- ipeds %>%
  filter(year == 2011)

write_csv(ipeds_2011, "colleges_ipeds_completers_2011.csv")

#Exercises
iped_2014_2015 <- ipeds %>%
  filter(year == 2014:2015, fips == 6)
head(iped_2014_2015)

write_csv(iped_2014_2015, "colleges_ipeds_completers_ca.csv")

#Example 7
download.file("https://www.hud.gov/sites/dfiles/Housing/documents/FHA_SFSnapshot_Apr2019.xlsx",
              "sfsnap.xlsx", mode = "wb")
excel_sheets("sfsnap.xlsx")
purchases <- read_excel("sfsnap.xlsx", sheet = "Purchase Data April 2019")

#Exercise
refinances <- read_excel("sfsnap.xlsx", sheet = "Refinance Data April 2019")
