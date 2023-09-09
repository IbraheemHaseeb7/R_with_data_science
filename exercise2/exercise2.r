library(tidyverse)
library(patchwork)
# Create a function that you can reuse
# Create a function that returns a density plot
show_density <- function(var_data) {
  
  # Get statistics
  mean_val <- mean(pull(var_data))
  med_val <- median(pull(var_data))
  mod_val <- statip::mfv(pull(var_data))
  
  
  # Plot the density plot
  density_plot <- ggplot(data = var_data) +
  geom_density(aes(x = pull(var_data)), fill="orangered", color="white", alpha=0.4) +
    
  # Add lines for the statistics
  geom_vline(xintercept = mean_val, color = 'cyan', linetype = "dashed", size = 1.3) +
  geom_vline(xintercept = med_val, color = 'red', linetype = "dashed", size = 1.3 ) +
  geom_vline(xintercept = mod_val, color = 'yellow', linetype = "dashed", size = 1.3 ) +
    
  # Add titles and labels
  ggtitle('Data Density') +
  xlab('') +
  ylab('Density') +
  theme(plot.title = element_text(hjust = 0.5))
  
  
  
  return(density_plot) # End of returned outputs
  
} # End of function

df_students <- read.csv(file = "https://raw.githubusercontent.com/MicrosoftDocs/ml-basics/master/data/grades.csv")

df_students <- df_students %>% drop_na()

# Get the density of Grade
col <- df_students %>% select(Grade)
show_density(var_data = col)
