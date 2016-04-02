# Author:tnybny
# simple dirty first model of unregularized 1-vs-all logistic regression

# load the data
if(!exists("X"))
    source("loadData.R")
# load error and viz functions to assist modeling
source("errorFunction.R")
source("visualize.R")

# load required libraries
require(caret)

X = X[1:2000, ]
Y = Y[1:2000]

# try 1-vs-all logistic regression
model <- list()
pred <- matrix(0, nrow = 10, ncol = length(Y))
for(class in 0:9)
{
    Yprime = ifelse(Y == class, 1, 0)
    ctrl = glm.control(maxit = 20)
    model[[class + 1]] <- glm(Yprime ~., family = binomial(link = 'logit'),
                            data = data.frame(X, Yprime), control = ctrl)
    pred[class + 1, ] = predict(model[[class + 1]], newdata = X,
                                type = "response")
}

# make predictions on training set
trainFit = apply(pred, 2, FUN = which.max)
error(trainFit, Y)
# 0 error

# make predictions on cv set
pred <- matrix(0, nrow = 10, ncol = length(Yval))
for(class in 0:9)
    pred[class + 1, ] = predict(model[[class + 1]], newdata = Xval,
                                type = "response")
valFit = apply(pred, 2, FUN = which.max) - 1
error(valFit, Yval)
viz(Xval, valFit)
# 32% error

# In conclusion, we are likely overfitting - let's try regularization/pca next!