library(tidyverse)
library(patchworkd)
library(statip)
library(glue)
library(summarytools)
library(scales)

# import data from the source
students <- read.csv(file = "https://raw.githubusercontent.com/MicrosoftDocs/ml-basics/master/data/grades.csv")

# remove the records with no data in them
students <- students %>% drop_na()

# Add a column of pass or fail
students <- students %>% 
  mutate(Status = if_else(Grade >= 60, "PASS", "FAIL"))

q01 <- students %>%
  pull(StudyHours) %>%
  quantile(1/100, name = FALSE)

col <- students %>%
  select(StudyHours) %>%
  filter(StudyHours > q01)

# Pivot data from wide to long
df_sample_long <- students %>%
  select(Status) %>% 
  pivot_longer(names_to = "Metrics", values_to = "Values")

df_normalized <- df_sample_long %>% 
  mutate(Values = rescale(Values, to = c(0, 1)))

# Show some of the normalized data
df_normalized %>% 
  slice_head(n = 5)

# Compare numeric variables with bar plots
ggplot(data = df_normalized) +
  geom_bar(mapping = aes(x = Name, y = Values, fill = Metrics), alpha = 0.7, stat = "identity", position = position_dodge(width = 0.9)) +
  xlab('Student') +
  ylab('') +
  theme(
    panel.grid = element_blank(),
    panel.grid.major.y = element_line(color = '#95a5a6',
                                      linetype = 'dashed',
                                      size = 0.5),
    axis.text.x = element_text(angle = 90),
    legend.title = element_blank()
    
  )

