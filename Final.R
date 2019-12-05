# Purpose:

# I want to look at the amounts of sorghum grown across the country at the county level. Want to look and compare the sizes of farms producing sorghum based on their locations. Also I might look at this production in comparison to the location of bio-refineries since a lot of sorghum is used to create ethanol.





# clear workspace

rm(list=ls(all=TRUE))



library(tidyverse)

library(dplyr)





sorghum_data <- read_csv("Data/USDA Sorghum Data.csv")

corn_data <- read_csv("Data/USDA Corn Data.csv")

refine <- read_csv("Data/Bio_Refineries.csv")



head(sorghum_data)

head(corn_data)

summary(sorghum_data)

summary(corn_data)



# removing columns with NA's



sorghum_data %>%
  
  select(c( Year, State, County, `County ANSI`, `Ag District`, `Data Item`, `Domain Category`, Value)) -> sorghum



corn_data %>%
  
  select(c( Year, State, County, `County ANSI`, `Ag District`, `Data Item`, `Domain Category`, Value)) -> corn



# removes rows that do not contial anything in the value column and only totals per column



sorghum %>%
  
  filter(Year == "2017", Value != "(D)", `Data Item` %in% c("SORGHUM, GRAIN - ACRES HARVESTED", "SORGHUM, SILAGE - ACRES HARVESTED")) -> us_sorghum



corn %>%
  
  filter(Value != "(D)", `Data Item` %in% c("CORN, GRAIN - ACRES HARVESTED", "CORN, SILAGE - ACRES HARVESTED")) -> us_corn



#converts the value column to numeric from character



as.numeric(gsub(",","",us_sorghum$Value)) -> us_sorghum$Value

as.numeric(gsub(",","",us_corn$Value)) -> us_corn$Value



summary(us_sorghum)

summary(us_corn)



us_corn %>%
  
  summarise(total = sum(Value))