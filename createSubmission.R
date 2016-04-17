# Author:tnybny
# this file defines an error function for this classification task

# error function for this is categorization accuracy
createSubmission <- function(Label, modelName){
    ImageId <- 1:length(Label)
    submission <- data.frame(ImageId, Label)
    write.table(submission, row.names = F,  
                paste("./Data/submission", modelName, ".csv", sep = ""),
                sep = ",")
}