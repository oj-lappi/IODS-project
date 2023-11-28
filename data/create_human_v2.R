# Oskar Lappi, 2023-11-28, Wrangle human development and gender inequality data, v2

# ---- read

library(readr)
library(dplyr)
library(tidyr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# ---- rename 

# give shorter names and create Edu2.FM and Labo.FM

hd <- hd %>% rename(GNI = "Gross National Income (GNI) per Capita") %>%
  rename(Life.Exp = "Life Expectancy at Birth") %>%
  rename(Edu.Exp = "Expected Years of Education") %>%
  rename(HDI = "Human Development Index (HDI)") %>%
  rename(HDI.Rank = "HDI Rank") %>%
  rename(GNI_minus_HDI = "GNI per Capita Rank Minus HDI Rank") %>%
  rename(Edu.Mean = "Mean Years of Education")

gii <- gii %>% rename(GII = "Gender Inequality Index (GII)") %>%
  rename(GII.Rank = "GII Rank") %>%
  rename(Mat.Mor = "Maternal Mortality Ratio") %>%
  rename(Ado.Birth = "Adolescent Birth Rate") %>%
  rename(Parli.F = "Percent Representation in Parliament") %>%
  rename(Edu2.F = "Population with Secondary Education (Female)") %>%
  rename(Edu2.M = "Population with Secondary Education (Male)") %>%
  rename(Labo.F = "Labour Force Participation Rate (Female)") %>%
  rename(Labo.M = "Labour Force Participation Rate (Male)") %>%
  mutate(Edu2.FM = Edu2.F /Edu2.M) %>%
  mutate(Labo.FM = Labo.F /Labo.M)


# ---- join

human <- inner_join(hd, gii, by = "Country")

## Brief explanation
#-------------------

# The dataset is from the United Nations Development Program, and contains data related to the human development indices.
# The human development indices are a set of five indicators of the wellbeing and development of a country's population.
# The ones we're looking at are the human development index (HDI) and the gender inequality index (GII).
# All indices contain data across three dimensions: health, education, and standard of living. The gender inequality index also contains data comparing female and male outcomes in education, the labor market, and politics.

## Rows
#------

# The dataset contains 7 larger regions, and 188 countries or territories.

## Columns
#---------

# Identifiers
# - Country, country or region name


# The human development index data contains:
# - GNI, gross national income per capita
# - Life.Exp, the life expectancy at birth
# - Edu.Exp, expected years of education
# - Edu.mean, mean years of education
# - HDI, the index itself, calculated from the above quantities
# - HDI rank, rank of the country within the set of all countries in the index
# - GNI_minus_HDI, a rank diff of the two indices (a little strange, in my opinion)

# The gender inequality data contains:
# - Mat.Mor, the maternal mortality ratio
# - Ado.Birth, adolescent birth rate (births due to adolescent pregnancy)
# - Edu2.F, Edu2.M, the proportion of population with secondary education, female and male
# - Edu2.FM, ratio of the two
# - Labo.F, Labo.M, the proportion of population participating in the labor market
# - Labo.FM, the ratio of the two
# - Parli.F, proportion of female members of parliament
# - GII, the index itself, calculated from the above quantities
# - GII.Rank, rank of the country within the set of all countries in the index

# ---- filter

# Drop unneeded almost all columns, then drop rows with NA in the remaining columns, then drop HDI.Rank
# This way, drop_na will drop the rows which don't have an HDI rank, which means they aren't countries
drop <- c("HDI", "GNI_minus_HDI", "Edu.Mean", "GII", "GII.Rank", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")
human <- human %>% select(-drop) %>% drop_na %>% select(-c("HDI.Rank"))

# ---- write

write_csv(human, "data/human_v2.csv")
