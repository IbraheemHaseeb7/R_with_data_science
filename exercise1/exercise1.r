
library(dplyr)
library(tidyr)

students <- read.csv(file = "https://raw.githubusercontent.com/MicrosoftDocs/ml-basics/master/data/grades.csv")


# Replace NA in column StudyHours with the mean study hours
students <- students %>% 
  drop_na()

results <- students %>%
  mutate(Status = if_else(Grade >= 60, "PASS", "FAIL"))

results %>% arrange(desc(Grade))