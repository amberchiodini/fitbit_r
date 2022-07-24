# Access fitbit data using functions from fitbitr package
library(fitbitr)
library(lubridate)
library(tidyverse)

# load_cached_token(".httr-oauth")

# Generate token if first time using package
generate_token(
  client_id = "238HCG",
  client_secret = "c2032c5eeecb4ccf6039e9d0998bc42c",
  callback = "http://localhost:1410/",
  cache = TRUE
)

#Load cached token in future sessions 
load_cached_token()
