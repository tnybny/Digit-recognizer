# Author:tnybny
# this file loads the MNIST dataset and creates subsets

#load required libraries
require(caret)

# read the data
mnist = read.table("./Data/train.csv", sep = ",", header = TRUE)

# partition into train and {cv and test}
inTrain = createDataPartition(mnist[, 1], p = 0.6, list = FALSE)

# get training set and rest
train = mnist[inTrain, ]
rest = mnist[-inTrain, ]

# partition into cv and test
inCv = createDataPartition(rest[, 1], p = 0.5, list = FALSE)

# get cv set and test
cv = rest[inCv, ]
test = rest[-inCv, ]
    
X = train[, -1]
Y = train[, 1]
Xval = cv[, -1]
Yval = cv[, 1]
Xtest = test[, -1]
Ytest = test[, 1]

# remove unnecessary objects
rm(test, train, cv, rest, mnist, inTrain, inCv)
