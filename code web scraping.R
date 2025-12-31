install.packages(c("rvest", "httr", "dplyr", "stringr"))

library(httr)
library(dplyr)
library(stringr)
library(rvest)  

url <- "https://www.vlr.gg/event/agents/2276/vct-2025-emea-kickoff"

page <- httr::GET(url, 
                  httr::add_headers('User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'))

html <- rvest::read_html(page)

tables <- html %>% rvest::html_elements("table")

cat("Nombre de tableaux trouvés :", length(tables), "\n")

df <- tables[[1]] %>% rvest::html_table(fill = TRUE)

names(df) <- ifelse(is.na(names(df)) | names(df) == "", paste0("V", seq_along(df)), names(df))

df <- df %>% mutate(across(everything(), ~str_squish(.)))

head(df)
