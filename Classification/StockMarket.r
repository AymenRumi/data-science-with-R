library(ISLR)
library(MASS)
library(class)

names(Weekly)
head(Weekly)
attach(Weekly)
cor(Weekly[1:8])

plot(Volume)

glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,family = binomial,data=Weekly)

summary(glm.fit)

contrasts(Direction)

glm.probabilities=predict(glm.fit,type="response")

glm.prediction=rep("Down",dim(Weekly)[1])

glm.prediction[glm.probabilities>0.5]="Up"

table(glm.prediction,Direction)

mean(glm.prediction==Direction)
mean(glm.prediction!=Direction)

train=Year<2007

Data.predictors=Weekly[!train,]
Data.response=Direction[!train]


glm.fit=glm(Direction~Lag2,data=Weekly,family=binomial,subset=train)

summary(glm.fit)

glm.probabilities=predict(glm.fit,Data.predictors,type="response")

glm.prediction=rep("Down",length(Data.response))
glm.prediction[glm.probabilities>0.5]="Up"

table(glm.prediction,Data.response)

mean(glm.prediction==Data.response)
mean(glm.prediction!=Data.response)

lda.fit=lda(Direction~Lag2,data=Weekly,subset=train)

lda.fit

plot(lda.fit)

lda.prediction=predict(lda.fit, Data.predictors)
lda.class=lda.prediction$class

table(lda.class,Data.response)

mean(lda.class==Data.response)
mean(lda.class!=Data.response)

qda.fit=qda(Direction~Lag2,data=Weekly,subset=train)

qda.fit


qda.prediction=predict(qda.fit, Data.predictors)
qda.class=lda.prediction$class

table(qda.class,Data.response)

mean(qda.class==Data.response)
mean(qda.class!=Data.response)

qda.fit=qda(Direction~Lag2,data=Weekly,subset=train)

qda.fit


qda.prediction=predict(qda.fit, Data.predictors)
qda.class=lda.prediction$class

table(qda.class,Data.response)

mean(qda.class==Data.response)
mean(qda.class!=Data.response)
```

## K-Nearest Neighbors
```{r}

train.X=cbind(Lag1,Lag2)[train,]


test.X=cbind(Lag1,Lag2)[!train,]


train.Direction=Direction[train]


set.seed(1)
knn.pred=knn(train.X,test.X,train.Direction,k=1)
table(knn.pred,Data.response)
mean(knn.pred==Data.response)


knn.pred=knn(train.X,test.X,train.Direction,k=3)
table(knn.pred,Data.response)

mean(knn.pred==Data.response)