# Oskar Lappi, 2023-11-16, wrangle Portuguese secondary school student performance dataset


# ---- setup

dataset_url <- "https://www.archive.ics.uci.edu/static/public/320/student+performance.zip"
#dataset_url <- "data/student_performance.dat" #use local file if there is no internet connection
outfile <- "data/student_performance.csv"

library(readr)
library(dplyr)

# ---- read_data

zip_archive <- tempfile()
workdir <-tempfile()
download.file(dataset_url, zip_archive)
# There's two zip files, one inside the other
unzip(zipfile = zip_archive, exdir = workdir)
unzip(zipfile = file.path(workdir,"student.zip"), exdir = workdir)

# There's two csv files, but they field-separator is actually a semicolon, add another column indicating the row in the file
student_por <- read_delim(file.path(workdir,"student-por.csv"), delim=";") %>% mutate(por_id = row_number())
student_mat <- read_delim(file.path(workdir,"student-mat.csv"), delim=";") %>% mutate(mat_id = row_number())

unlink(zip_archive)
unlink(workdir)

# ---- join_dataframes

key <- colnames(student_por)
key <- key[! key %in% c("failures", "paid", "absences", "G1", "G2", "G3", "por_id")]
merged <- inner_join(sm, sp, by = key, suffix = c(".mat", ".por")) %>% distinct(.keep_all = TRUE) %>% select(-c(por_id,mat_id))

# ---- create_alcohol_use_columns

#TODO: create columns

# ---- write_merged_data
  
write_csv(merged, "data/student_performance.csv", quote="all")