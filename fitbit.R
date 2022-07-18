# Generate token if first time using package
generate_token(
  client_id = "238HCG",
  client_secret = "c2032c5eeecb4ccf6039e9d0998bc42c",
  callback = "http://localhost:1410/",
  cache = TRUE
)

#Load cached token in future sessions 
load_cached_token()

# Access fitbit data using functions from fitbitr package
library(fitbitr)
library(lubridate)
library(tidyverse)
# load_cached_token(".httr-oauth")

# Get data 
sleep <- sleep_summary(
  start_date = today()-months(3),
  end_date = today()
)
# Forward pipe operator; forward a value into the next function call/expression
sleep %>% 
  head()

## # A tibble: 6 x 11
## log_id date start_time end_time duration efficiency
## <dbl> <date> <dttm> <dttm> <int> <int>
## 1 3.12e10 2021–03–09 2021–03–08 22:28:30 2021–03–09 07:23:30 32100000 96
## 2 3.13e10 2021–03–10 2021–03–09 22:35:30 2021–03–10 07:19:30 31440000 98
## 3 3.13e10 2021–03–11 2021–03–10 23:48:00 2021–03–11 06:51:00 25380000 95
## 4 3.13e10 2021–03–12 2021–03–11 23:08:00 2021–03–12 06:28:00 26400000 96
## 5 3.13e10 2021–03–13 2021–03–12 23:16:00 2021–03–13 07:42:30 30360000 96
## 6 3.13e10 2021–03–14 2021–03–13 22:55:00 2021–03–14 08:05:00 33000000 96
## # … with 5 more variables: minutes_to_fall_asleep <int>, minutes_asleep <int>,
## # minutes_awake <int>, minutes_after_wakeup <int>, time_in_bed <int>