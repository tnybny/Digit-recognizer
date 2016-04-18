# Author:tnybny
# model of regularized 1-vs-all logistic regression

# load the data
if(!exists("X"))
    source("loadData.R")
# load error and viz functions to assist modeling
source("errorFunction.R")
source("visualize.R")
source("createSubmission.R")

# load required libraries
require(LiblineaR)

X <- rbind(X, Xval, Xtest)
Y <- c(Y, Yval, Ytest)

# geomSeries <- function(base, max) {
#     base^(0:floor(log(max, base)))
# }
# g <- geomSeries(base = 5, max = 2 ^ 19)
# tryCosts <- rep(0.01, length(g)) * g # try different values for regularization
tryCosts <- seq(500, 600, 20)

maxacc <- 0
mincost <- NA
for(co in tryCosts)
{
    sub = sample(1:length(Y), 10000)
    Xsub = X[sub, ]
    Ysub = Y[sub]
    print(co)
    # 10 fold cv: cross = 10
    acc <- LiblineaR(Xsub, Ysub, type = 0, cross = 10, bias = TRUE, cost = co)
    if(acc > maxacc)
    {
        maxacc <- acc
        mincost <- co
    }
}

model <- LiblineaR(X, Y, type = 0, bias = TRUE, cost = mincost, verbose = FALSE)
pred <- predict(model, X, proba = F, decisionValues = TRUE)
error(pred$predictions, Y)

test = read.table("./Data/test.csv", sep = ",", header = TRUE)
pred <- predict(model, test, proba = F, decisionValues = TRUE)
createSubmission(pred$predictions, "RegLogReg")
