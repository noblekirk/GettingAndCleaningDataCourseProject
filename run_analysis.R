## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

##Read in labels files: activity_labels.txt, features.txt
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

##Subset of column names for mean and standard deviation measurements
colset <- grepl(".*mean\\(\\)|.*std\\(\\)", features)

##Read in files for test dataset: X_test.txt, Y_test.txt, subject_test.txt
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
testsubj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
##Rename columns from label files
names(xtest) = features
ytest[,2] = activity[ytest[,1]]
names(ytest) = c("activityCode", "activity")
names(testsubj) = "subject"
##Extract only the measurements on the mean and standard deviation for each measurement in xtest
xtest = xtest[,colset]
##Combine data into test dataset
testset <- cbind(testsubj, ytest, xtest)

##Read in files for train dataset: X_train.txt, Y_train.txt, subject_train.txt
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")
trainsubj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
##Rename columns from label files
names(xtrain) = features
ytrain[,2] = activity[ytrain[,1]]
names(ytrain) = c("activityCode", "activity")
names(trainsubj) = "subject"
##Extract only the measurements on the mean and standard deviation for each measurement in xtrain
xtrain = xtrain[,colset]
##Combine data into test dataset
trainset <- cbind(trainsubj, ytrain, xtrain)

##Merge the training and the test sets to create one data set
dataset <- rbind(testset, trainset)

##Appropriately label the data set with descriptive variable names
names(dataset)<-gsub("^t", "time", names(dataset))
names(dataset)<-gsub("^f", "frequency", names(dataset))
names(dataset)<-gsub("Acc", "Acceleration", names(dataset))
names(dataset)<-gsub("Gyro", "Gyroscope", names(dataset))
names(dataset)<-gsub("Mag", "Magnitude", names(dataset))
names(dataset)<-gsub("BodyBody", "Body", names(dataset))
names(dataset)<-gsub("mean\\(\\)", "Mean", names(dataset))
names(dataset)<-gsub("std\\(\\)", "StdDev", names(dataset))
names(dataset)<-gsub("-", ".", names(dataset))

##Create a second independent tidy data set with the average of each variable for each 
##activity and each subject
melt_data <- melt(dataset, id=c("subject","activity","activityCode"))
tidy_data <- dcast(melt_data, formula = subject + activity + activityCode ~ variable, mean) %>% arrange(subject, activityCode)
write.table(tidy_data, file="Sensor_Mean_by_Activity.txt")