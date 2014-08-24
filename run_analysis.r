## Getting and Cleaning Data Course Project
## Jp Munoz
## August 24, 2014
# File Description:
# Create one R script called run_analysis.R that does the following.
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# Date for the Project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


#Installing first the packages data.table
install.packages("data.table")

library(base)
library(utils)
library(data.table)

#Downloading the file from the internet using download.file() function and unzipping it
download.file(url="http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile= "C:/Users/Online University/Desktop/Getting and Cleaning Data/Course Project/data.zip")
zip.file<-'data.zip'
unzip(zip.file)

#Setting up my working directory in my computer

setwd('C:/Users/Online University/Desktop/Getting and Cleaning Data/Course Project/UCI HAR Dataset');

# Read in the data from files
activity_labels = read.table('./activity_labels.txt',header=FALSE);
features = read.table('./features.txt',header=FALSE); 
subject_train = read.table('./train/subject_train.txt',header=FALSE);
x_train = read.table('./train/x_train.txt',header=FALSE);
y_train = read.table('./train/y_train.txt',header=FALSE);

# Setting column names to the data imported
colnames(activity_labels) = c('activityId','activity_labels');
colnames(subject_train) = "subjectId";
colnames(x_train) = features[,2];
colnames(y_train) = "activityId";

## Answer to 1: Merge the training and the test sets to create one data set
trainingData = cbind(y_train,subject_train,x_train);
subjectTest = read.table('./test/subject_test.txt',header=FALSE);
xTest = read.table('./test/x_test.txt',header=FALSE);
yTest = read.table('./test/y_test.txt',header=FALSE);

# Assign column names to the test data imported above
colnames(subjectTest) = "subjectId";
colnames(xTest) = features[,2];
colnames(yTest) = "activityId";

# Create the final test set by merging the xTest, yTest and subjectTest data
testData = cbind(yTest,subjectTest,xTest);

# Combine the row data of training and test data to create a final data set
finalData = rbind(trainingData,testData);

# Create a vector for the column names from the finalData
colNames = colnames(finalData);


## Answer to 2: Extract only the measurements on the mean and standard deviation for each measurement.
# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset finalData table based on the logicalVector to keep only desired columns
finalData = finalData[logicalVector==TRUE];

 
## Answer to 3: Use descriptive activity names to name the activities in the data set
# Merge the finalData set with the acitivityType table to include descriptive activity names
finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames = colnames(finalData);

# Answer to 4: Appropriately label the data set with descriptive activity names.
# Cleaning up the variable names
for (i in 1:length(colNames))
{
colNames[i] = gsub("\\()","",colNames[i])
colNames[i] = gsub("-std$","StdDev",colNames[i])
colNames[i] = gsub("-mean","Mean",colNames[i])
colNames[i] = gsub("^(t)","time",colNames[i])
colNames[i] = gsub("^(f)","freq",colNames[i])
colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};
# Reassigning the new descriptive column names to the finalData set
colnames(finalData) = colNames;

## Answer to 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.
# Create a new table, finalDataNoActivityType without the activityType column
finalDataNoActivityType = finalData[,names(finalData) != 'activityType'];

# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
finaltidyDataset = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);

# Merging the finaltidyDataset with activityType to include descriptive acitvity names
finaltidyDataset = merge(finaltidyDataset,activityType,by='activityId',all.x=TRUE);

# Export the finaltidyDataset set
write.table(finaltidyDataset, './FinalDataSet.txt',row.names=TRUE,sep='\t');