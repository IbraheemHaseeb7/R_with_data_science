library(tidyverse)

# Importing using read_csv function
students <- read.csv(file = "https://raw.githubusercontent.com/MicrosoftDocs/ml-basics/master/data/grades.csv")

filter(students, StudyHours > 12, Grade > 80)