library(dbplyr)
library(dplyr)
library(knitr)
library(kableExtra)
library(ggplot2)
library(ISLR)
library(MASS)
library(class)
library(caTools)

Auto<-Auto%>%mutate(mileage=ifelse(mpg > median(mpg),1,0))

attach(Auto)
names(Auto)


ggplot(data=Auto,aes(y=mpg,x=cylinders))+geom_point(color="blue")
ggplot(data=Auto,aes(y=mpg,x=displacement))+geom_point(color="blue")
ggplot(data=Auto,aes(y=mpg,x=horsepower))+geom_point(color="blue")
ggplot(data=Auto,aes(y=mpg,x=weight))+geom_point(color="blue")
ggplot(data=Auto,aes(y=mpg,x=acceleration))+geom_point(color="blue")
ggplot(data=Auto,aes(y=mpg,x=year))+geom_point(color="blue")
ggplot(data=Auto,aes(y=mpg,x=origin))+geom_point(color="blue")

set.seed(1)
sample <- sample.split(Auto$mileage, SplitRatio = .75)
train <- subset(Auto, sample == TRUE)
test  <- subset(Auto, sample == FALSE)

glm.fit<-glm(mileage~displacement+horsepower+weight+acceleration+year+cylinders+origin,family=binomial,data=train)

summary(glm.fit)

glm.probs=predict(glm.fit,test,type="response")

glm.prediction=rep(0,length(test$mileage))
glm.prediction[glm.probs>0.5]=1

table(glm.prediction,test$mileage)

mean(glm.prediction==test$mileage)
mean(glm.prediction!=test$mileage)


lda.fit=lda(mileage~displacement+horsepower+weight+acceleration+year+cylinders+origin,data=train)

lda.fit

plot(lda.fit)

lda.prediction=predict(lda.fit, test)
lda.class=lda.prediction$class

table(lda.class,test$mileage)

mean(lda.class==test$mileage)
mean(lda.class!=test$mileage)

qda.fit=qda(mileage~displacement+horsepower+weight+acceleration+year+cylinders+origin,data=train)

qda.fit


qda.prediction=predict(qda.fit, test)
qda.class=qda.prediction$class

table(qda.class,test$mileage)

mean(qda.class==test$mileage)
mean(qda.class!=test$mileage)

knn.pred=knn(train[2:8],test[2:8],train$mileage,k=1)

table(knn.pred,test$mileage)
mean(knn.pred==test$mileage)


knn.pred=knn(train[2:8],test[2:8],train$mileage,k=3)
table(knn.pred,test$mileage)
mean(knn.pred==test$mileage)



knn.pred=knn(train[2:8],test[2:8],train$mileage,k=10)
table(knn.pred,test$mileage)
mean(knn.pred==test$mileage)