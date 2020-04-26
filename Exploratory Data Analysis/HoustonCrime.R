library(dbplyr)
library(dplyr)
library(knitr)
library(kableExtra)
library(ggplot2)
library(ggmap)
data(crime)

writeLines(names(crime))

crime_by_hour<-crime%>%group_by(hour)%>%summarise(count=n())%>%mutate(prop=count/sum(count))

crime_by_week<-crime%>%group_by(day)%>%summarise(count=n())%>%mutate(prop=count/sum(count))

crime_by_month<-crime%>%group_by(month)%>%summarise(count=n())%>%mutate(prop=count/sum(count))

crime_by_offense<-crime%>%group_by(offense)%>%summarise(count=n())%>%mutate(prop=count/sum(count))

ggplot(crime_by_offense, aes(x=offense,y=count,fill=offense)) +   geom_bar(stat="identity")+geom_text(aes(label=count), vjust=1.6, color="white", size=3.5)+theme_minimal()+ggtitle("Offense Distribution")

crime_by_offense%>%kable()

ggplot(data=crime_by_month, aes(x=month, y=count)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=count), vjust=1.6, color="white", size=3.5)+
  theme_minimal()+ggtitle("Crime by Month Distribution")

ggplot(data=crime_by_week, aes(x=day, y=count)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=count), vjust=1.6, color="white", size=3.5)+
  theme_minimal()+ggtitle("Crime by Day Distribution")

ggplot(crime_by_hour, aes(x=hour,y=count)) +  geom_density(stat="identity",color="darkblue", fill="lightblue",alpha=0.5)+theme_minimal()+ggtitle("Crime by Hour Distribution")

slice(crime_by_hour%>%arrange(desc(count)),1:10)%>%kable()


ggplot(crime, aes(x = lon, y = lat)) + 
  coord_equal() + 
  xlab('Longitude') + 
  ylab('Latitude') + 
  stat_density2d(aes(fill = ..level..), alpha = .5,
                 h = .02, n = 300,
                 geom = "polygon", data = crime) + 
  scale_fill_viridis_c() + 
  theme(legend.position = 'none')+ggtitle("Crime Density by Location")