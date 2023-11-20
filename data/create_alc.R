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
merged <- inner_join(student_mat, student_por, by = key, suffix = c(".mat", ".por")) %>% distinct(.keep_all = TRUE) %>% select(-c(por_id,mat_id))

# ---- create_averages

course_vars <- c("failures", "paid", "absences", "G1", "G2", "G3")
for (col in course_vars) {
  columns <- select(merged, starts_with(col))
  if (is.numeric(select(columns,1)[[1]])) {
    merged[col] = round(rowMeans(columns))
  } else {
    merged[col] = select(columns,1)
  }
}

# ---- create_alc_use_cols

merged <- merged %>% 
  mutate(alc_use = (Dalc + Walc) / 2) %>%
  mutate(high_use = alc_use > 2) %>%
  select(!ends_with(".mat")) %>% select(!ends_with(".por"))

# ---- write_merged_data
  
write_csv(merged, "data/alc.csv")

# Instead of glimpsing, I've verified the output by diffing against https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/alc.csv