library(dbplyr)
library(dplyr)
library(knitr)
library(kableExtra)
library(ggplot2)
library(ggmap)

# importing data
file1 <- "http://www.math.mcgill.ca/yyang/regression/data/abalone.csv"
abalone <- read.csv(file1, header = TRUE)


Summary_Table<-function(data,variable)
{
    data %>% summarise(Avg = mean(variable),
        Med = median(variable),
        Q25 = quantile(variable,0.25), Q75 = quantile(variable,0.75),
        StD = sd(variable), Var=var(variable), Min=min(variable),
        Max=max(variable))%>%kable()
}

Plot_Distribution<-function(data,variable,title="")
{
  ggplot(data, aes(x=variable))+geom_density(color="darkblue", fill="lightblue")+ggtitle(title)
}

Plot_Distribution(abalone,abalone$Height,"Abalone Height Distribution")
Summary_Table(abalone,abalone$Height)

ggplot(abalone,aes(x=Height,y=Rings))+geom_point()+stat_density_2d(aes(fill = ..level..), geom = "polygon")+ geom_density_2d()

ggplot(abalone,aes(x=Height,y=Rings,fill = ..level..), geom = "polygon")+geom_density_2d()+stat_density_2d(aes(fill = ..level..), geom = "polygon")+ geom_density_2d()

plot(abalone$Height,abalone$Rings,pch=19,xlab='Height',ylab='Rings')

abline(v=mean(abalone$Height),h=mean(abalone$Rings),lty=2)

fit.RP<-lm(abalone$Rings~abalone$Height)

title('Line of best fit for Abalone Data')

abline(coef(fit.RP),col='red')

summary(fit.RP)

ggplot(data = data.frame(x = abalone$Height, y = residuals(fit.RP)), aes(x = x, y = y))+geom_point(shape=21)+ylab("Residual")+xlab("Height")


plot(abalone$Height,residuals(fit.RP))
abline(h=0,col="gray")

hist(residuals(fit.RP),breaks=40,freq=FALSE,xlab="Residual",main="")
curve(dnorm(x,mean=0,sd=sd(residuals(fit.RP))),add=TRUE,col="blue")


abalone<-filter(abalone,Height<0.4)
plot(y=log(abalone$Rings),x=sqrt(abalone$Height))
transform.RP<-lm(log(abalone$Rings)~sqrt(abalone$Height))
abline(coef(transform.RP),col='red')


summary(transform.RP)

plot(sqrt(abalone$Height),residuals(transform.RP))
abline(h=0,col='gray')

hist(residuals(transform.RP),breaks=40,freq=FALSE,xlab="Residual",main="")
curve(dnorm(x,mean=0,sd=sd(residuals(transform.RP))),add=TRUE,col="blue")


par(mar=c(4,4,0,1))
x<-sqrt(abalone$Height)
y<-log(abalone$Rings)
fit.RP<-lm(y~x)

xnew<-seq(0,0.5,by=0.01)


#Confidence interval
ynew.interval<-predict(fit.RP,newdata=data.frame(x=xnew),interval='confidence')
plot(x,y,xlab='sqrt(Height)',ylab='log(Rings)')
abline(coef(fit.RP),col='red')

lines(xnew,ynew.interval[,2],lty=2,col='red')
lines(xnew,ynew.interval[,3],lty=2,col='red')

#Prediction interval

yonew.interval<-predict(fit.RP,newdata=data.frame(x=xnew),interval='prediction')
lines(xnew,yonew.interval[,2],lty=2,col='blue')
lines(xnew,yonew.interval[,3],lty=2,col='blue')
legend(0,3.25,c('Prediction','Conf. Interv.','Pred. Interv.'),col=c('red','red','blue'),lty=c(1,2,2))

title('Prediction of Age with Height',line=-17)

# importing data
file1 <- "http://www.math.mcgill.ca/yyang/regression/data/cigs.csv"
cigs <- read.csv(file1, header = TRUE)

CO<-cigs$CO
TAR<-cigs$TAR
NICOTINE<-cigs$NICOTINE
WEIGHT<-cigs$WEIGHT

Plot_Distribution(cigs,TAR,"Tar Distribution")
Plot_Distribution(cigs,NICOTINE,"Nicotine Distribution")
Plot_Distribution(cigs,WEIGHT,"Weight Distribution")
Plot_Distribution(cigs,CO,"CO2 Distribution")

plot(cigs)

summary(lm(CO~TAR+NICOTINE+WEIGHT))

anova(lm(CO~TAR+NICOTINE+WEIGHT))


plot(y=TAR,x=NICOTINE)
abline(coef(lm(TAR~NICOTINE)),col='red')
cor(TAR,NICOTINE)

anova(lm(CO~TAR+WEIGHT))


sigma(lm(CO~TAR+WEIGHT))
sigma(lm(CO~TAR))


plot(y=CO,x=TAR)

abline(coef(lm(CO~TAR)),col='red')

data.source<-"http://www.math.mcgill.ca/yyang/regression/data/birthsmokers.csv"
birthsmokers<-read.csv(file=data.source)

Plot_Distribution(birthsmokers,birthsmokers$Wgt)

Plot_Distribution(birthsmokers,birthsmokers$Gest)

plot(birthsmokers)

plot(x=subset(birthsmokers,Smoke=="no")$Gest,y=subset(birthsmokers,Smoke=="no")$Wgt,col="blue",pch=19,xlab="Gestion", ylab="Weight")

points(x=subset(birthsmokers,Smoke=="yes")$Gest,y=subset(birthsmokers,Smoke=="yes")$Wgt,col="red",pch=19)

abline(coef(lm(Wgt~Gest,data=subset(birthsmokers,Smoke=="no"))),col='blue')
abline(coef(lm(Wgt~Gest,data=subset(birthsmokers,Smoke=="yes"))),col='red')

summary(lm(Wgt~Gest,data=subset(birthsmokers,Smoke=="no")))

summary(lm(Wgt~Gest,data=subset(birthsmokers,Smoke=="yes")))

confint(lm(Wgt~Gest,data=subset(birthsmokers,Smoke=="no")))

confint(lm(Wgt~Gest,data=subset(birthsmokers,Smoke=="yes")))