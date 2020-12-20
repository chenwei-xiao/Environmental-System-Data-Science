############################
## ESDS Primers
## Exercise 1
## Chenwei Xiao
## September 2020
############################

# This very first exercise is creating and reading tidy data.

# Download data from Groenigen et al., 2014, containing soil organic matter content data from a meta analysis of CO2 experiments, and available on Moodle. Open the file in Excel and navigate to the tab 'Database S1'. You'll find a short description in the top-left cell: "Database S1. Overview of CO2 enrichment studies reporting soil C contents that were used in our analysis.". There is an issue with this dataset. Of course, .xls files are not easily readable into R without an extra package. What's more is that even after saving the tab 'Database S1' as a CSV file, the table you get is not **machine-readable** into a data frame that we can work with in R. The way the data is organised into cells doesn't follow the structure of a dataframe and is not tidy. Recall the **tidy data** rules from the 01_primers.ipynb tutorial.

# Your task is to:

# 1. Manually manipulate the .xls file to make it tidy.
# 2. Save the data as a .csv file (comma-separated-values).
# 3. Read the .csv file into R.
# 4. Calculate the logarithmic response ratio as the logarithm of the ratio of soil C contents at elevated CO2 divided by soil C contents at ambient CO2, for each data point (experiment and sample date).
# 5. Visualise the distribution of the response ratio and save the plot as a .pdf file.

# Implement steps 3.-5. in an R script, applying some of the points for good coding practices. For the peer review round, share your code and the figure file (.pdf) with your partner.

##----------------------------------------
## Set Workspace
##----------------------------------------
getwd()
setwd('./exercise')
##----------------------------------------
## Load libraries
##----------------------------------------
library("tidyverse")

##----------------------------------------
## Task 1,2 already solved and csv saved under ~/01_primers/data/exercise/groenigen14sci.csv
## -Simplify the Sample date to only year.
## -Simplify the Depth to (0-Depth)cm
##----------------------------------------

##----------------------------------------
## Task 3 Read the .csv file into R.
##----------------------------------------
greo_data <- read_csv('~/01_primers/data/exercise/groenigen14sci.csv')
head(greo_data)
dim(greo_data)
names(greo_data)
summary(greo_data)

##----------------------------------------
## Task 4 Calculate the logarithmic response ratio as the logarithm of the ratio of soil C contents 
## at elevated CO2 divided by soil C contents at ambient CO2
##----------------------------------------
log_response_co2 <- log(greo_data$`increased CO2 (mean)`/greo_data$`ambient CO2 (mean)`)
greo_data$log_response_co2 <- log_response_co2
summary(log_response_co2)

##----------------------------------------
## Task 5 Visualise the distribution of the response ratio and save the plot as a .pdf file.
##----------------------------------------
options(repr.plot.width = 10, repr.plot.height = 8)
p1 <- ggplot(data = greo_data, mapping = aes(x = log_response_co2)) + theme(text = element_text(size = 20))
p1 <- p1 + labs(x = 'logarithmic response ratio of increased CO2 and ambient CO2')
p1 <- p1 + geom_histogram()
p1

ggsave('./distribution_of_the_CO2_response_ratio.pdf')

