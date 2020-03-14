## Data from https://www.kaggle.com/ankkur13/boston-crime-data#

## @knitr libraries_chk
library(here)
library(tidyverse)


## @knitr crime_read_files_chk
crime <- read_csv(
  here("Data_Analyses_MATH_208/Datasets/BostonCrime/crime.csv"))


## @knitr info_crime
head(crime)


## @knitr info_crime_2
names(crime)


## @knitr info_crime_str
str(crime)

## @knitr info_crime_glimpse
glimpse(crime)

## @knitr crimes_by_day
crime %>% group_by(DAY_OF_WEEK) %>% summarise(count=n()) %>% 
  mutate(prop=count/sum(count)) 


## @knitr crimes_by_day_bycount
crime %>% group_by(DAY_OF_WEEK) %>% summarise(count=n()) %>% 
  mutate(prop=count/sum(count)) %>% arrange(desc(count))


## @knitr crimes_by_month
crime %>% group_by(MONTH) %>% summarise(count=n()) %>% 
  mutate(prop=count/sum(count)) %>% arrange(MONTH)

## @knitr crimes_by_day_bycount
crime <- crime %>% mutate(Day_of_week = 
                            fct_relevel(DAY_OF_WEEK,
                                        c("Monday","Tuesday","Wednesday",
                                          "Thursday","Friday","Saturday",
                                          "Sunday")))
crime %>% group_by(Day_of_week) %>% summarise(count=n()) %>% 
  mutate(prop=count/sum(count)) 

## @knitr neat_month_trick
month.abb
crime <- crime %>% mutate(Month = month.abb[MONTH])
crime %>% select(MONTH, Month) %>% slice(1:5)

## @knitr crimes_by_month_name
crime %>% group_by(Month) %>% summarise(count=n()) %>% 
  mutate(prop=count/sum(count)) %>% arrange(Month)


## @knitr month_factor
crime <- crime %>% mutate(Month = fct_relevel(Month,month.abb))
crime_by_month = crime %>% group_by(Month) %>% 
  summarise(count=n()) %>% 
  mutate(prop=count/sum(count)) %>% arrange(Month)
crime_by_month

## @knitr month_pie
ggplot(crime_by_month,aes(x="",y=count,
                          fill=Month)) + 
  geom_bar(stat="identity") + coord_polar("y",start=0) +
  theme(axis.title.y =element_blank(),
        axis.text.y =element_blank(),
        axis.ticks.y=element_blank())

## @knitr month_pie_prop
ggplot(crime_by_month,aes(x="",y=prop,
                          fill=Month)) + 
  geom_bar(stat="identity") + coord_polar("y",start=0) +
  theme(axis.title.y =element_blank(),
        axis.text.y =element_blank(),
        axis.ticks.y=element_blank())

## @knitr month_pie2
ggplot(crime,aes(x=factor(1),fill=Month)) + 
  geom_bar() + coord_polar("y",start=0) + 
  scale_fill_viridis_d()   +
  theme(axis.title.y =element_blank(),
        axis.text.y =element_blank(),
        axis.ticks.y=element_blank())


## @knitr month_bar
ggplot(crime,aes(x=Month,fill=Month)) + 
  geom_bar() + scale_fill_viridis_d() + ylab("Total number of crimes")


## @knitr month_bar_prop
ggplot(crime,aes(x=Month,fill=Month)) + 
  geom_bar(aes(y=..count../sum(..count..))) + scale_fill_viridis_d() +
  ylab("Proportion of crimes")


## @knitr waffle_install_code and different themes for waffle
#devtools::install_git("https://git.rud.is/hrbrmstr/waffle.git")
#install.packages("hrbrthemes")

## @knitr waffle_month
library(waffle)
library(hrbrthemes)
crime_by_month <- crime_by_month %>% 
  mutate(waffle_count = round(count/1000))
ggplot(crime_by_month, aes(fill=Month,values=waffle_count)) + 
  geom_waffle(n_rows=30,size = 0.33, flip=TRUE) +  coord_equal() +
  scale_fill_viridis_d() + theme_enhance_waffle()

## @knitr crimes_by_group
crime %>% group_by(OFFENSE_CODE_GROUP) %>% 
  summarise(count=n()) %>% 
  mutate(prop=count/sum(count)) %>% arrange(desc(prop))

## @knitr crimes_by_group_bar
off_code_counts <- crime %>% group_by(OFFENSE_CODE_GROUP) %>% 
  summarise(count=n())  %>% mutate(prop=count/sum(count))
ggplot(off_code_counts,aes(x=OFFENSE_CODE_GROUP,fill=OFFENSE_CODE_GROUP)) + 
  geom_bar(stat="identity",aes(y=prop))+ scale_fill_viridis_d() +
  ylab("Proportion of crimes")+ 
  theme(axis.title.x =element_blank(),
        axis.text.x =element_blank(),
        axis.ticks.x=element_blank())

## @knitr crimes_by_group_bar2
ggplot(off_code_counts,aes(x=OFFENSE_CODE_GROUP,fill=OFFENSE_CODE_GROUP)) + 
  geom_bar(stat="identity",aes(y=prop))+ scale_fill_viridis_d() +
  ylab("Proportion of crimes") + theme(legend.position = "none")  + 
  theme(axis.text.x = element_text(angle = 90,hjust=0.95)) + xlab("")

## @knitr crimes_by_group_bar2_reordered
off_code_counts <- off_code_counts %>% 
  mutate(OFFENSE_CODE_GROUP=
         fct_reorder(OFFENSE_CODE_GROUP,count,.desc=TRUE))
ggplot(off_code_counts,aes(x=OFFENSE_CODE_GROUP,fill=OFFENSE_CODE_GROUP)) + 
  geom_bar(stat="identity",aes(y=prop))+ scale_fill_viridis_d() +
  ylab("Proportion of crimes") + theme(legend.position = "none")  + 
  theme(axis.text.x = element_text(angle = 90,hjust=0.95)) + xlab("")

## @knitr crimes_lump
crime <- crime %>% 
  mutate(code_lmp = fct_lump(OFFENSE_CODE_GROUP,12)) 
off_code_counts_lmp <- crime %>%
  group_by(code_lmp) %>%  count() %>%  ungroup() %>%
  mutate(prop = n/sum(n)) %>% arrange(n)
off_code_counts_lmp 

## @knitr crimes_lump_bar
ggplot(off_code_counts_lmp,aes(x=code_lmp,fill=code_lmp)) + 
  geom_bar(stat="identity",aes(y=prop))+ 
  scale_fill_viridis_d() +ylab("Proportion of crimes")  + 
  theme(axis.title.x =element_blank(),axis.text.x =element_blank(),
        axis.ticks.x=element_blank())

## @knitr crimes_lump_bar_reordered
off_code_counts_lmp <- off_code_counts_lmp %>% 
  mutate(code_lmp = fct_reorder(code_lmp, n,.desc=TRUE))
ggplot(off_code_counts_lmp,aes(x=code_lmp,fill=code_lmp)) + 
  geom_bar(stat="identity",aes(y=prop))+ scale_fill_viridis_d() +
  ylab("Proportion of crimes")  +  theme(axis.title.x =element_blank(),
        axis.text.x =element_blank(),axis.ticks.x=element_blank())


## @knitr crime_treemap
# install.packages("treemapify")
library(treemapify)
ggplot(off_code_counts_lmp, aes(area = n, fill = code_lmp)) +
  geom_treemap() + scale_fill_viridis_d()

## @knitr crime_treemap_all_create
off_code_counts <- off_code_counts %>% 
  mutate(OFFENSE_CODE_GROUP = fct_reorder(OFFENSE_CODE_GROUP,
                                          count,.desc=TRUE))
p <- ggplot(off_code_counts, 
       aes(area = count, fill = OFFENSE_CODE_GROUP)) +
  geom_treemap() 
class(p)
attributes(p)

## @knitr crime_treemap_all
p + theme(legend.position="none")

## @knitr crime_treemap_all_legend
#install.packages("ggpubr")
library(ggpubr)
as_ggplot(get_legend(p+theme(legend.text=element_text(size=8))))

## @knitr stacked_bar
crime = crime %>% mutate(code_lmp = fct_infreq(code_lmp))
ggplot(crime,aes(x=Month,fill=code_lmp)) + 
  geom_bar() + scale_fill_viridis_d() + ylab("Total number of crimes")


## @knitr stacked_bar_dodge
ggplot(crime,aes(x=Month,fill=code_lmp)) + 
  geom_bar(position="dodge") + scale_fill_viridis_d() + 
  ylab("Total number of crimes")

## @knitr stacked_bar_facet
ggplot(crime,aes(x=code_lmp,fill=code_lmp)) +
  geom_bar(position="dodge") + facet_wrap(~Month) + 
  scale_fill_viridis_d() + ylab("Total number of crimes")+  
  theme(axis.title.x =element_blank(),
        axis.text.x =element_blank(),axis.ticks.x=element_blank())


## @knitr stacked_bar_prop_calc
month_and_code_counts <- crime %>% group_by(Month,code_lmp) %>% 
  summarise(n = n()) %>% group_by(Month) %>% mutate(prop=n/sum(n))
month_and_code_counts %>% filter(code_lmp == "Other")


## @knitr stacked_bar_prop_calc
ggplot(month_and_code_counts,aes(x=Month,fill=code_lmp,y=prop)) + 
  geom_bar(stat="identity") + 
  scale_fill_viridis_d() + ylab("Total number of crimes")


## @knitr mosaic_first 
ggplot(crime) + geom_mosaic(aes(x=product(Day_of_week),fill=Day_of_week))

## @knitr mosaic_second
library(ggmosaic)
ggplot(crime) + geom_mosaic(aes(x=product(code_lmp,Day_of_week),
                                fill=Day_of_week))

## @knitr mosaic_third
ggplot(crime) + geom_mosaic(aes(x=product(Day_of_week,code_lmp),
                                fill=code_lmp))+ 
  theme(axis.title.x =element_blank(),axis.text.x =element_blank(),
        axis.ticks.x=element_blank())

## @knitr mosaic_fourth
ggplot(crime) + 
  geom_mosaic(aes(x=product(Day_of_week,code_lmp),fill=code_lmp,
                  divider="hbar"))+ 
  theme(axis.title.x =element_blank(),axis.text.x =element_blank(),
        axis.ticks.x=element_blank())


## @knitr mosaic_fifth
ggplot(crime) + 
  geom_mosaic(aes(x=product(code_lmp,Month),fill=Month))+ 
  theme(axis.title.x =element_blank(),axis.text.x =element_blank(),
        axis.ticks.x=element_blank())

## @knitr date_format
crime %>% select(OCCURRED_ON_DATE) %>% head(20)

## @knitr date_format_2
crime %>% summarise(min=min(OCCURRED_ON_DATE),
                    med = median(OCCURRED_ON_DATE),
                    max = max(OCCURRED_ON_DATE))
crime %>% pull(OCCURRED_ON_DATE) %>%  class(.)
crime %>% pull(OCCURRED_ON_DATE) %>% head(10) %>%  as.numeric(.)

## @knitr make_your_own
library(lubridate)
my_date <- "1991-05-25"
class(my_date)
my_date <- ymd(my_date)  
my_date
class(my_date) 

## @knitr make_your_own2
other_date = ymd_hms("2009-05-02 02:57:00", tz="America/Montreal")
other_date

## @knitr easy_arithmetic
my_date + days( (-2):2)
my_date + months( (-2):2)
now()

## @knitr easy_arithmetic2
now() - other_date
interval(other_date,now())/years(1)


## @knitr crimes_by_date
by_date_tbl = crime %>% mutate(date_only = date(OCCURRED_ON_DATE)) %>% 
  group_by(date_only) %>%
  summarise(count=n())
by_date_tbl %>% arrange(desc(count)) %>% head(5)

## @knitr crimes_by_date2
ggplot(by_date_tbl,
       aes(x=date_only, y= count)) + geom_line() + 
  labs(x="Date",y="Number of crimes committed") + geom_smooth()

## @knitr crimes_by_date3
ggplot(by_date_tbl %>% filter(year(date_only)==2016),
       aes(x=date_only, y= count)) + geom_line() + 
  labs(x="Date",y="Number of crimes committed")+ geom_smooth()


## @knitr
# http://rstudio-pubs-static.s3.amazonaws.com/3369_998f8b2d788e4a0384ae565c4280aa47.html

## @knitr crimes_by_month_1 
by_month_tbl  = crime %>% group_by(YEAR,Month) %>% 
  summarise(count=n())
by_month_tbl %>% arrange(desc(count)) %>% head(5)

## @knitr crimes_by_month_1a
by_month_tbl = by_month_tbl %>% ungroup() %>%
  mutate(Month_Year=factor(interaction(Month,YEAR),
                           levels=interaction(Month,YEAR)))
Jan_levels = by_month_tbl %>% 
                      filter(Month=="Jan") %>% pull(Month_Year)%>% 
  unique(.)
tibble(Jan_levels,as.numeric(Jan_levels))

## @knitr crimes_by_month_1b
ggplot(by_month_tbl,aes(x=Month_Year,y=count,group=1)) + 
  geom_point() +   geom_line(stat="summary",fun.y=sum) +
  theme(axis.text.x = element_text(angle = 90)) + 
  labs(x="Date",y="Count",title="Number of crimes by month") + 
  geom_vline(xintercept=as.numeric(Jan_levels),
             col="red",linetype="dashed")


## @knitr crimes_by_month_2
crime = crime %>% mutate(First_of_month = 
                           floor_date(OCCURRED_ON_DATE,unit="month"))
crime %>% slice(sample(x=1:n(),size=10)) %>% 
  select(OCCURRED_ON_DATE,First_of_month) 
  
## @knitr crimes_by_month_2a
by_month_tbl2  = crime %>% group_by(First_of_month) %>% 
  summarise(count=n())
ggplot(by_month_tbl2,aes(x=First_of_month,y=count)) + 
  geom_point() +   geom_line() + 
  labs(x="Date",y="Count",title="Number of crimes by month") + 
  geom_vline(xintercept=
               as.POSIXct(c("2016-01-01","2017-01-01","2018-01-01")),
             col="red",linetype="dashed")

# Missing values, NaN, and Inf
## @knitr missing
crime %>% summarise_all(list(~sum(is.na(.)))) %>% 
  pivot_longer(cols=everything(),names_to = "Variable")

## @knitr missing2
crime %>% summarise_all(list(~sum(is.na(.)))) %>% 
  pivot_longer(cols=everything(),names_to = "Variable") %>% 
  filter(value>0)
  
## @knitr missing_drop
crime_no_na <- crime %>% drop_na()
crime %>% summarise(n())

## @knitr missing_drop2
crime_no_na %>% summarise(n())
crime %>% drop_na(UCR_PART) %>% summarise(n())


## @knitr recode_1
crime %>% pull(code_lmp) %>% unique(.) %>% sort(.)

## @knitr recode_2
crime = crime %>% mutate(code_lmp_alt = 
                           recode(code_lmp, 
                                  'Investigate Person' = "Investigate",
                                  'Investigate Property' = "Investigate",
                                  'Motor Vehicle Accident Response' = 
                                    "Motor Vehicle", 
                                  'Larceny From Motor Vehicle' = 
                                    "Motor Vehicle"))
## @knitr recode_3
crime %>% group_by(code_lmp_alt) %>% summarise(count=n()) %>% 
  arrange(desc(count))

## @knitr recode_4
crime %>% group_by(Location) %>% summarise(count=n())%>% 
  arrange(desc(count))


## @knitr recode_5 
crime = crime %>% mutate(Location_alt = 
                           fct_recode(as.character(Location),
                                  NULL = "(-1.00000000, -1.00000000)", 
                                  NULL = "(0.00000000, 0.00000000)"))

## @knitr recode_6
crime %>% group_by(Location_alt) %>% summarise(count=n())%>% 
  arrange(desc(count)) 
