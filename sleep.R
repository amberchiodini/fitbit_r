# Plot of the times that you went to sleep and woke up over the past 3 months
## Get data 
sleep <- sleep_summary(
  start_date = today()-months(3),
  end_date = today()
)

## Implement forward pipe operator 
sleep %>% 
  ## # Get the first parts of the sleep function 
  head()

## # A tibble: 6 x 11
## log_id date       start_time          end_time            duration
## <dbl> <date>     <dttm>              <dttm>                 <int>
##  1 3.66e10 2022-04-24 2022-04-23 22:53:30 2022-04-24 08:41:00 35220000
## 2 3.66e10 2022-04-25 2022-04-24 21:32:30 2022-04-25 06:37:00 32640000
## 3 3.67e10 2022-04-26 2022-04-25 20:36:00 2022-04-26 06:25:30 35340000
## 4 3.67e10 2022-04-27 2022-04-26 21:34:00 2022-04-27 06:15:30 31260000
## 5 3.67e10 2022-04-28 2022-04-27 21:57:00 2022-04-28 06:21:00 30240000
## 6 3.67e10 2022-04-29 2022-04-28 21:10:30 2022-04-29 06:41:30 34260000
## # ... with 6 more variables: efficiency <int>, minutes_to_fall_asleep <int>, minutes_asleep <int>,
## # minutes_awake <int>, minutes_after_wakeup <int>, time_in_bed <int>

## Install more packages 
library(zoo)
library(scales)
library(ggthemes)

## Load data
sleep <- sleep %>%
  mutate(
    date = as_date(date),
    start_time = as_datetime(start_time),
    end_time = as_datetime(end_time),
    sh = ifelse(hour(start_time) < 8, hour(start_time) + 24, hour(start_time)), #create numeric times
    sm = minute(start_time),
    st = sh + sm/60,
    eh = hour(end_time),
    em = minute(end_time),
    et = eh + em/60,
    mst = rollmean(st, 7, fill = NA), #create moving averages
    met = rollmean(et, 7, fill = NA),
    year = year(start_time)
)

## Visualize data
sleep %>%
  ggplot(aes(x = date))+
  geom_line(aes(y = et), color = 'coral', alpha = .3, na.rm = T)+
  geom_line(aes(y = st), color = 'dodgerblue', alpha = .3, na.rm = T)+
  geom_line(aes(y = met), color = 'coral', na.rm=T)+
  geom_line(aes(y = mst), color = 'dodgerblue', na.rm=T)+
  scale_y_continuous(breaks = seq(0, 30, 2),
  labels = trans_format(function(x) ifelse(x > 23, x-24, x), 
  format = scales::comma_format(suffix = ':00', accuracy = 1))
  )+
  labs(x = 'Date',
  y = 'Time')+
  theme_fivethirtyeight()+
  scale_x_date(date_breaks = '1 month', date_labels = '%b', expand = c(0, 0))+
  facet_grid(. ~ year, space = 'free', scales = 'free_x', switch = 'x') +
  theme(panel.spacing.x = unit(0,'line'), 
        strip.placement = 'outside')
