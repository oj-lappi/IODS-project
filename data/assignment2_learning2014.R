# Oskar Lappi, 2023-11-08, wrangle learning2014 dataset


# ---- setup

dataset_url <- "http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt"
#dataset_url <- "data/learning2014.dat" #use local file if there is no internet connection
outfile <- "data/learning2014.csv"

library(readr)
library(dplyr)

# ---- read_data

lrn2014 <- read_delim(dataset_url,
                           delim = "\t",
                           escape_double = FALSE, 
                           trim_ws = TRUE)

# ---- wrangle_columns
# Question categories, deep learning, surface learning, strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

lrn2014$deep <- rowMeans(lrn2014[, deep_questions])
lrn2014$surf <- rowMeans(lrn2014[, surface_questions])
lrn2014$stra <- rowMeans(lrn2014[, strategic_questions])

#Final bit of filtering, renaming, and normalizing Attitude
lrn2014 <- lrn2014 %>% 
  mutate(attitude = Attitude/10) %>% 
  rename(age = Age, points = Points) %>%
  filter(points > 0) %>%
  select(gender, age, attitude, deep, stra, surf, points)

# ---- write_data
write_csv(lrn2014, outfile, quote="all")

# ---- check_data
lrn2014_reproduced <-read_csv(outfile)
print(paste("Consistency check, reading the csv back gives the same dataframe:",
            all(lrn2014_reproduced == lrn2014)))

