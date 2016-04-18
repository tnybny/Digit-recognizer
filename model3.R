# Author:tnybny
# model of weighted k-nearest neighbors

# load the data
if(!exists("X"))
    source("loadData.R")
# load error and viz functions to assist modeling
source("errorFunction.R")
source("visualize.R")
source("createSubmission.R")

# load required libraries
require(kknn)

X <- rbind(X, Xtest)
Y <- as.factor(c(Y, Ytest))
sub <- sample(1:length(Y), 5000)
Xsub <- X[sub, ]
Ysub <- Y[sub]

maxacc <- 0
bestk <- 0
for(kay in seq(7, 10, 1)) # try different values of k, find optimal
{
    print(kay)
    m <- kknn(Ysub ~ ., data.frame(Xsub, Ysub), Xval, k = kay)
    err <- error(m$fitted.values, Yval)
    if(maxacc < (100 - err))
    {
        maxacc <- 100 - err
        bestk <- kay
    }
}

m <- kknn(Y ~ ., data.frame(X, Y), Xval, k = bestk) # good estimate of test err
error(m$fitted.values, Yval)

test = read.table("./Data/test.csv", sep = ",", header = TRUE)
X <- rbind(X, Xval)
Y <- as.factor(c(Y, Yval))
m <- kknn(Y ~ ., data.frame(X, Y), test, k = bestk)
createSubmission(m$fitted.values, "kNN")
