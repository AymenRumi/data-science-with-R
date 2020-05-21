library(ISLR)
library(dplyr)
library(knitr)
library(class)
library(leaps)
library(class)
library(caTools)
library(glmnet)
library(pls)

summary(lm(data=College,Apps~.))

College<-College

regfit.full=regsubsets(Apps~.,data=College,nvmax=17,method="forward")
reg.summary=summary(regfit.full)

reg.summary


par(mfrow=c(2,2))

which.max(reg.summary$adjr2)
plot(reg.summary$adjr2,xlab="Number of Variables",
      ylab="Adjusted RSq",type="l")
points(which.max(reg.summary$adjr2),reg.summary$adjr2[which.max(reg.summary$adjr2)], col="red",cex=2,pch=20)

which.min(reg.summary$rss)
plot(reg.summary$adjr2,xlab="Number of Variables",
      ylab="RSS",type="l")
points(which.min(reg.summary$rss),reg.summary$adjr2[which.min(reg.summary$rss)], col="red",cex=2,pch=20)


which.min(reg.summary$cp)
plot(reg.summary$cp,xlab="Number of Variables",
      ylab="Cp",type="l")
points(which.min(reg.summary$cp),reg.summary$cp[which.min(reg.summary$cp)], col="red",cex=2,pch=20)


which.min(reg.summary$bic)
plot(reg.summary$bic,xlab="Number of Variables",
      ylab="BIC",type="l")
points(which.min(reg.summary$bic),reg.summary$bic[which.min(reg.summary$bic)], col="red",cex=2,pch=20)

set.seed(4)

# split the dataset

sample <- sample.split(College$Apps, SplitRatio = .70)

train <- subset(College, sample == TRUE)
test  <- subset(College, sample == FALSE)

regfit.fwd=regsubsets(Apps~.,data=train, nvmax=17,method="forward")

test.mat=model.matrix(Apps~.,data=test)

validation.errors=rep(NA,17)


for(i in 1:17){
  coefi=coef(regfit.fwd,id=i)
  pred=test.mat[,names(coefi)]%*%coefi
  validation.errors[i]=mean((test$Apps-pred)^2)
  
}

validation.errors

which.min(validation.errors)

coef(regfit.fwd,id=which.min(validation.errors))

set.seed(1)
k=10
folds=sample(1:k,nrow(College),replace=TRUE)
cv.errors=matrix(NA,k,17, dimnames=list(NULL, paste(1:17)))


predict.regsubsets=function(object,newdata,id,...){
  form=as.formula(object$call[[2]])
 mat=model.matrix(form,newdata)
 coefi=coef(object,id=id)
 xvars=names(coefi)
 mat[,xvars]%*%coefi 
}


for(j in 1:k)
{
  best.fit=regsubsets(Apps~.,data=College[folds!=j,],nvmax=17)
  
  for (i in 1:17)
  {
    pred=predict.regsubsets(best.fit,College[folds==j,],id=i)
    cv.errors[j,i]=mean((College$Apps[folds==j]-pred)^2)
  }
}

mean.cv.errors=apply(cv.errors,2,mean)

which.min(mean.cv.errors)
x=model.matrix(Apps~.,College)[,-1]
y=College$Apps

# Ridge Regression

grid=10^seq(10,-2,length=100)

ridge.mod=glmnet(x,y,alpha=0,lambda=grid)

# Train & Test

train=sample(1:nrow(x),nrow(x)/2)

test=(-train)

y.test=y[test]

ridge.mod=glmnet(x[train,],y[train],alpha=0,lambda=grid,thresh=1e-12)

ridge.pred=predict(ridge.mod,s=4,newx=x[test,])

mean((ridge.pred-y.test)^2)


# cross validation

set.seed(1)

cv.out=cv.glmnet(x[train,],y[train],alpha=0)
plot(cv.out)

bestlam=cv.out$lambda.min

bestlam

ridge.pred=predict(ridge.mod,s=bestlam,newx=x[test,])
mean((ridge.pred-y.test)^2)

# lasso regression

cv.out=cv.glmnet(x[train,],y[train],alpha=1)
plot(cv.out)

bestlam=cv.out$lambda.min

bestlam

ridge.pred=predict(ridge.mod,s=bestlam,newx=x[test,])
mean((ridge.pred-y.test)^2)

set.seed(1)

pcr.fit=pcr(Apps~.,data=College,scale=TRUE,validation="CV")
pcr.fit

# try on training & testing

pcr.fit=pcr(Apps~.,data=College,subset=train,scale=TRUE,validation="CV")

validationplot(pcr.fit,val.type="MSEP")

pcr.pred=predict(pcr.fit,x[test,],ncomp=17)
mean((pcr.pred-y.test)^2)