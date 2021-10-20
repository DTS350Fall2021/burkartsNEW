#load libraries
library(tidyverse) 
library(readr) 

# Load our text files
RandomLetters <- read_lines("https://github.com/WJC-Data-Science/DTS350/raw/master/randomletters.txt")
head(RandomLetters)

RandomLetters_wNumbers <- read_lines("https://raw.githubusercontent.com/WJC-Data-Science/DTS350/master/randomletters_wnumbers.txt")
head(RandomLetters_wNumbers)

# Create a new list comprised of every 1700th character
NewLetterList <- c(str_sub(RandomLetters, start = 1, end = 1))
for (i in seq(0, str_length(RandomLetters)/1700)) {
  NewLetterList <- str_c(NewLetterList, str_sub(RandomLetters, start = i*1700, end = i*1700))
}
NewLetterList1 <- str_split(NewLetterList, "\\.", n = 2) [[1]][1]
NewLetterList1


#convert hidden numbers to letters
hidden_message <- unlist(str_extract_all(RandomLetters_wNumbers, ("(\\d)+")))
decipher <- c()

for (i in seq(1,length(hidden_message))) {
  decipher <- append(decipher,letters[as.integer(hidden_message[i])])
}
decipher <- paste(decipher,collapse = " ")
decipher

#find longest palindrome

str_extract_all(RandomLetters, "(.)(.)(.)(.)\\4\\3\\2\\1")


#find longest string of vowels
longest <- c("1")
RandomLetters_no_spaces_periods <- RandomLetters %>%
  str_remove_all(" ") %>%
  str_remove_all("\\.")

vowels <- unlist(str_extract_all(RandomLetters_no_spaces_periods,"([aeiou])+"))
vowels

for (i in seq(1,length(vowels))) {
  if (str_length(vowels[i]) > str_length(longest[length(longest)])) {
    longest <- vowels[i]
  }
}
longest
