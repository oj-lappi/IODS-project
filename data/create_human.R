# Oskar Lappi, 2023-11-27, Wrangle human development and gender inequality data

# ---- read

library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# data exploration: I don't feel like a data transformation script is the place to put summaries etc., so let's execute them and write the output as comments

## hd 

#dim(hd)
#[1] 195   8

#str(hd)
#spc_tbl_ [195 × 8] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
#$ HDI Rank                              : num [1:195] 1 2 3 4 5 6 6 8 9 9 ...
#$ Country                               : chr [1:195] "Norway" "Australia" "Switzerland" "Denmark" ...
#$ Human Development Index (HDI)         : num [1:195] 0.944 0.935 0.93 0.923 0.922 0.916 0.916 0.915 0.913 0.913 ...
#$ Life Expectancy at Birth              : num [1:195] 81.6 82.4 83 80.2 81.6 80.9 80.9 79.1 82 81.8 ...
#$ Expected Years of Education           : num [1:195] 17.5 20.2 15.8 18.7 17.9 16.5 18.6 16.5 15.9 19.2 ...
#$ Mean Years of Education               : num [1:195] 12.6 13 12.8 12.7 11.9 13.1 12.2 12.9 13 12.5 ...
#$ Gross National Income (GNI) per Capita: num [1:195] 64992 42261 56431 44025 45435 ...
#$ GNI per Capita Rank Minus HDI Rank    : num [1:195] 5 17 6 11 9 11 16 3 11 23 ...
#- attr(*, "spec")=
#  .. cols(
#    ..   `HDI Rank` = col_double(),
#    ..   Country = col_character(),
#    ..   `Human Development Index (HDI)` = col_double(),
#    ..   `Life Expectancy at Birth` = col_double(),
#    ..   `Expected Years of Education` = col_double(),
#    ..   `Mean Years of Education` = col_double(),
#    ..   `Gross National Income (GNI) per Capita` = col_number(),
#    ..   `GNI per Capita Rank Minus HDI Rank` = col_double()
#    .. )
#- attr(*, "problems")=<externalptr> 

#summary(hd)
#[OUT]:
#Education Gross National Income (GNI) per Capita GNI per Capita Rank Minus HDI Rank
#Min.   :  1.00   Length:195         Min.   :0.3480                Min.   :49.00            Min.   : 4.10               Min.   : 1.400          Min.   :   581                         Min.   :-84.0000                  
#1st Qu.: 47.75   Class :character   1st Qu.:0.5770                1st Qu.:65.75            1st Qu.:11.10               1st Qu.: 5.550          1st Qu.:  3772                         1st Qu.: -9.0000                  
#Median : 94.00   Mode  :character   Median :0.7210                Median :73.10            Median :13.10               Median : 8.400          Median : 10939                         Median :  1.5000                  
#Mean   : 94.31                      Mean   :0.6918                Mean   :71.07            Mean   :12.86               Mean   : 8.079          Mean   : 16801                         Mean   :  0.1862                  
#3rd Qu.:141.25                      3rd Qu.:0.8000                3rd Qu.:76.80            3rd Qu.:14.90               3rd Qu.:10.600          3rd Qu.: 22316                         3rd Qu.: 11.0000                  
#Max.   :188.00                      Max.   :0.9440                Max.   :84.00            Max.   :20.20               Max.   :13.100          Max.   :123124                         Max.   : 47.0000                  
#NA's   :7     

## gii

#dim(gii)
#[1] 195  10

#str(gii)
#spc_tbl_ [195 × 10] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
#$ GII Rank                                    : num [1:195] 1 2 3 4 5 6 6 8 9 9 ...
#$ Country                                     : chr [1:195] "Norway" "Australia" "Switzerland" "Denmark" ...
#$ Gender Inequality Index (GII)               : num [1:195] 0.067 0.11 0.028 0.048 0.062 0.041 0.113 0.28 0.129 0.157 ...
#$ Maternal Mortality Ratio                    : num [1:195] 4 6 6 5 6 7 9 28 11 8 ...
#$ Adolescent Birth Rate                       : num [1:195] 7.8 12.1 1.9 5.1 6.2 3.8 8.2 31 14.5 25.3 ...
#$ Percent Representation in Parliament        : num [1:195] 39.6 30.5 28.5 38 36.9 36.9 19.9 19.4 28.2 31.4 ...
#$ Population with Secondary Education (Female): num [1:195] 97.4 94.3 95 95.5 87.7 96.3 80.5 95.1 100 95 ...
#$ Population with Secondary Education (Male)  : num [1:195] 96.7 94.6 96.6 96.6 90.5 97 78.6 94.8 100 95.3 ...
#$ Labour Force Participation Rate (Female)    : num [1:195] 61.2 58.8 61.8 58.7 58.5 53.6 53.1 56.3 61.6 62 ...
#$ Labour Force Participation Rate (Male)      : num [1:195] 68.7 71.8 74.9 66.4 70.6 66.4 68.1 68.9 71 73.8 ...
#- attr(*, "spec")=
#  .. cols(
#    ..   `GII Rank` = col_double(),
#    ..   Country = col_character(),
#    ..   `Gender Inequality Index (GII)` = col_double(),
#    ..   `Maternal Mortality Ratio` = col_double(),
#    ..   `Adolescent Birth Rate` = col_double(),
#    ..   `Percent Representation in Parliament` = col_double(),
#    ..   `Population with Secondary Education (Female)` = col_double(),
#    ..   `Population with Secondary Education (Male)` = col_double(),
#    ..   `Labour Force Participation Rate (Female)` = col_double(),
#    ..   `Labour Force Participation Rate (Male)` = col_double()
#    .. )
#- attr(*, "problems")=<externalptr> 

#summary(gii)
#[OUT]:
#GII Rank        Country          Gender Inequality Index (GII) Maternal Mortality Ratio Adolescent Birth Rate Percent Representation in Parliament Population with Secondary Education (Female)
#Min.   :  1.00   Length:195         Min.   :0.0160                Min.   :   1.0           Min.   :  0.60        Min.   : 0.00                        Min.   :  0.9                               
#1st Qu.: 47.75   Class :character   1st Qu.:0.2030                1st Qu.:  16.0           1st Qu.: 15.45        1st Qu.:12.47                        1st Qu.: 27.8                               
#Median : 94.00   Mode  :character   Median :0.3935                Median :  69.0           Median : 40.95        Median :19.50                        Median : 55.7                               
#Mean   : 94.31                      Mean   :0.3695                Mean   : 163.2           Mean   : 49.55        Mean   :20.60                        Mean   : 54.8                               
#3rd Qu.:141.25                      3rd Qu.:0.5272                3rd Qu.: 230.0           3rd Qu.: 71.78        3rd Qu.:27.02                        3rd Qu.: 81.8                               
#Max.   :188.00                      Max.   :0.7440                Max.   :1100.0           Max.   :204.80        Max.   :57.50                        Max.   :100.0                               
#NA's   :7                           NA's   :33                    NA's   :10               NA's   :5             NA's   :3                            NA's   :26                                  
#Population with Secondary Education (Male) Labour Force Participation Rate (Female) Labour Force Participation Rate (Male)
#Min.   :  3.20                             Min.   :13.50                            Min.   :44.20                         
#1st Qu.: 38.30                             1st Qu.:44.50                            1st Qu.:68.88                         
#Median : 60.00                             Median :53.30                            Median :75.55                         
#Mean   : 60.29                             Mean   :52.61                            Mean   :74.74                         
#3rd Qu.: 85.80                             3rd Qu.:62.62                            3rd Qu.:80.15                         
#Max.   :100.00                             Max.   :88.10                            Max.   :95.50                         
#NA's   :26                                 NA's   :11                               NA's   :11                   

# ---- rename 

# give shorter names and create Edu2.FM and Labo.FM

hd <- hd %>% rename(GNI = "Gross National Income (GNI) per Capita") %>%
  rename(Life.Exp = "Life Expectancy at Birth") %>%
  rename(Edu.Exp = "Expected Years of Education") %>%
  rename(HDI = "Human Development Index (HDI)") %>%
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

# ---- write

write_csv(human, "data/human.csv")

## There are some NA's in the data which have to be handled when the data is eventually processed, other than that, the csv looks good
