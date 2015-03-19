#GettingAndCleaningDataCourseProject

This repository includes the following files:
README.md
CodeBook.md
run_analysis.R


run_analysis.R assumes that the UCI HAR Dataset (from the link below) is saved in your working directory.
-UCI HAR Dataset link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For information on the data in the dataset, see the README file in the UCI HAR Dataset folder.

The script run_analysis.R does the following:

1. Merges the training and the test sets from UCI HAR Dataset to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6. Writes the tidy data to a file Sensor_Mean_by_Activity.txt in your home directory. 

The following R packages are needed to run run_analysis.R. You will be prompted if they are not installed.
- data.table
- reshape2
- dplyr

See the CODE_BOOK for information on the transformations and variables in Sensor_Mean_by_Activity. 