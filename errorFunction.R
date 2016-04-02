# Author:tnybny
# this file defines an error function for this classification task

# error function for this is categorization accuracy
error <- function(Ypred, Yactual){
    t <- table(Ypred, Yactual)
    correct = 0
    total = length(Ypred) # total number of predictions
    for(i in 1:10)
    { # count the correct predictions -- diagonal elements
        for(j in 1:10)
        {
            if(i == j)
                correct = correct + t[i, j]
        }
    }
    return((total - correct) / total * 100)
}