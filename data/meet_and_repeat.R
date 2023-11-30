library(readr)
library(dplyr)
library(tidyr)

url1 <- "https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt"
url2 <- "https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt"

# BPRS: brief psychiatric rating scale, used as indicator of schizophrenia

bprs <- read_delim(url1) %>%
        pivot_longer(cols = -c(treatment, subject), names_to = "weeks", values_to = "bprs") %>%
        arrange(weeks) %>% 
        mutate(week = as.integer(substring(weeks, 5))) %>%
        select(!one_of("weeks"))

#This includes standardization
#bprs <- read_delim(url1) %>%
#        pivot_longer(cols = -c(treatment, subject), names_to = "weeks", values_to = "bprs") %>%
#        arrange(weeks) %>% 
#        mutate(week = as.integer(substring(weeks, 5))) %>%
#        select(!one_of("weeks")) %>%
#        group_by(week) %>%
#        mutate(stdbprs = scale(bprs)) %>%
#        ungroup()

#This includes summarizing by treatment
#bprs_sum <- bprs %>%
#            group_by(treatment, week) %>%
#            summarise( mean = mean(stdbprs), se = sd(stdbprs)/sqrt(n())) %>%
#            ungroup()

df2 <- read.table(url2) %>%
        pivot_longer(df2, cols = -c(ID, Group), names_to = "days", values_to = "bodyweight") %>%
        arrange(days) %>% 
        mutate(day = as.integer(substring(days, 3))) %>%
        select(!one_of("days"))