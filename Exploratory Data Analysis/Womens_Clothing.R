library(tidyverse)
library(dplyr)
library(readr)
library(knitr)
Womens_Clothing_Review<-read_csv("Womens_Clothing_Reviews.csv")
Womens_Clothing_Review<-Womens_Clothing_Review%>%drop_na()


DataVisualization<-function(data,subset,numerical=TRUE,name)
{
  
  if(numerical)
  {
    
    ggplot(data,(aes(x=subset)))+geom_bar(fill="lightblue",color="black")+
      scale_fill_viridis_d()+xlab(name)
  }
  else
  {
    ggplot(data,(aes(x=subset,fill=subset)))+
      geom_bar()+scale_fill_viridis_d()+xlab(name)
  }
  
}

FrequencyTable<-function(data)
{
  data%>%summarise(count=n())%>%mutate(prop=count/sum(count))%>%
    arrange(desc(count))%>%kable()
}


SummaryTable<-function(data,subset)
{
  data%>%summarise(Ave=mean(subset),
                   Med=median(subset),
                   '25%ile'=quantile(subset,0.25),
                   '75%ile'=quantile(subset,0.75),
                   Std=sd(subset)
                   )%>%kable()
}


DataVisualization(Womens_Clothing_Review,with(Womens_Clothing_Review,Age),name="Age")

FrequencyTable(Womens_Clothing_Review%>%group_by(Age))

SummaryTable(Womens_Clothing_Review,with(Womens_Clothing_Review,Age))





DataVisualization(Womens_Clothing_Review,
                  with(Womens_Clothing_Review,Rating),name="Rating")

FrequencyTable(Womens_Clothing_Review%>%group_by(Rating))




DataVisualization(Womens_Clothing_Review,
                  with(Womens_Clothing_Review,Recommended),name="Recommended")
FrequencyTable(Womens_Clothing_Review%>%group_by(Recommended))




DataVisualization(Womens_Clothing_Review,with(Womens_Clothing_Review,
                                              Department_Name),FALSE,"Departments")
FrequencyTable(Womens_Clothing_Review%>%
                 group_by(Department_Name))



Department_Summary<-function(department)
{
  Womens_Clothing_Review%>%filter(Department_Name==department)%>%
    summarise(Ave=mean(Age),Med=median(Age),
                    '25%ile'=quantile(Age,0.25),
                    '75%ile'=quantile(Age,0.75),
                    Std=sd(Age))%>%kable()
}

Age_Category<-function(value)
{
    if(value<=25)
    {
        return("25 and under")
    }
    else if((value>=26)&&(value<=35))
    {
        return("26-35")
    }
    else if((value>=36)&&(value<=45))
    {
        return ("36-45")
    }
    else if((value>=36)&&(value<=64))
    {
        return("46-64")
    }
    else
    {
        return("65 and over")
    }
}


ggplot(Womens_Clothing_Review,aes(Age,fill=Department_Name))+
  geom_bar()+facet_wrap(~Department_Name)


Department_Summary("Bottoms")
Department_Summary("Intimate")
Department_Summary("Jackets")
Department_Summary("Tops")
Department_Summary("Trend")



Womens_Clothing_Review<-Womens_Clothing_Review%>%
  mutate(Category=map_chr(Age,Age_Category))


ggplot(Womens_Clothing_Review,aes(x=Rating,fill=Category))+
  geom_bar()+facet_wrap(~Category)

Clothing<-function(ID)
{

    max((Womens_Clothing_Review%>%filter(Clothing_ID%in%ID)%>%
           group_by(Recommended)%>%summarise(count=n()))%>%
          mutate(prop=count/sum(count))%>%select(prop))
    
}


Compute_WLCL<-function(Womens_Clothing_Review)
{
  
  Womens_Clothing_Review<-Womens_Clothing_Review%>%
    group_by(Clothing_ID)%>%mutate(prop=map_dbl(Clothing_ID,Clothing))
  Womens_Clothing_Review<-Womens_Clothing_Review%>%
    mutate(a=(1.96**2)/(2*n))
  Womens_Clothing_Review<-Womens_Clothing_Review%>%
    mutate(b=(prop*(1-prop))/(n))
  Womens_Clothing_Review<-Womens_Clothing_Review%>%
    mutate(c=(a)/(2*n))
  Womens_Clothing_Review<-Womens_Clothing_Review%>%
    mutate(WLCL=(prop+a-1.96*sqrt(b+c))/(1+2*a))

  head(distinct(Womens_Clothing_Review%>%
                  arrange(desc(WLCL))%>%select(Clothing_ID,WLCL,n,Department_Name)),10)%>%kable()
}


Womens_Clothing_Review<-Womens_Clothing_Review%>%
  group_by(Clothing_ID)%>%mutate(n=n())

head(Womens_Clothing_Review%>%group_by(Clothing_ID)%>%
       mutate(Mean_Rating= mean(Rating))%>%select(Clothing_ID,n,Department_Name,Mean_Rating)%>%
       arrange(desc(Mean_Rating)),10)%>%kable()



head(Womens_Clothing_Review%>%group_by(Clothing_ID)%>%
       mutate(prop=map_dbl(Clothing_ID,Clothing))%>%
       select(Clothing_ID,prop,n,Department_Name)%>%
       arrange(desc(prop))%>%distinct(),10)%>%kable()


Compute_WLCL(Womens_Clothing_Review)
