if (!file.exists("~/R/data.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="~/R/data.zip")
}  
if (!file.exists("~/R/UCI HAR Dataset")) { 
  unzip("~/R/data.zip",exdir="~/R") 
}

# Read training data:
xtrain <- read.table("~/R/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("~/R/UCI HAR Dataset/train/y_train.txt")
subtrain <- read.table("~/R/UCI HAR Dataset/train/subject_train.txt")

# Read test data:
xtest <- read.table("~/R/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("~/R/UCI HAR Dataset/test/y_test.txt")
subtest <- read.table("~/R/UCI HAR Dataset/test/subject_test.txt")

# Reading feature vector & activity labels:
features <- read.table('~/R/UCI HAR Dataset/features.txt')
activityLabels = read.table('~/R/UCI HAR Dataset/activity_labels.txt')
colnames(activityLabels) <- c('activity','activityType')

#merging files
train <- cbind(ytrain, subtrain, xtrain)
test <- cbind(ytest, subtest, xtest)
final <- rbind(train, test)

featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)
 
final_mean_std<-final[,c(1,2,featuresWanted)]
colnames(final_mean_std) <- c("activity","subject", featuresWanted.names)
final_with_ActivityNames <- merge(final_mean_std, activityLabels,by='activity',all.x=TRUE)

TidySet <- aggregate(. ~subject + activity, final_with_ActivityNames, mean)
TidySet <- TidySet[order(TidySet$subject, TidySet$activity),]

write.table(TidySet, "TidySet.txt", row.name=FALSE)