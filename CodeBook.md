## Getting and Cleaning Data Project

### Description
#Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.
### Source Data
#A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
#[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


##  Part 1: Merge the training and the test sets to create one data set
# I install first the required packages such as read.table and download the file from the internet
# Setting up my working directory in my computer
# Read in the data from files using read.table()
# Setting column names to the data imported
# Merge the training and the test sets to create one data set
# Assign column names to the test data imported above
# Create the final test set by merging the xTest, yTest and subjectTest data
# Combine the row data of training and test data to create a final data set
# Create a vector for the column names from the finalData

## Part 2: Extract only the measurements on the mean and standard deviation for each measurement.
# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
# Subset finalData table based on the logicalVector to keep only desired columns

## Part 3: Use descriptive activity names to name the activities in the data set
# Merge the finalData set with the acitivityType table to include descriptive activity names
# Updating the colNames vector to include the new column names after merge

## Part 4: Appropriately label the data set with descriptive activity names.
# Cleaning up the variable names
# Reassigning the new descriptive column names to the finalData set

## Part 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.
# Create a new table, finalDataNoActivityType without the activityType column
# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
# Merging the finaltidyDataset with activityType to include descriptive acitvity names
# Export the finaltidyDataset set

