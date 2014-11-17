# This R code is for generaing a required tidy data set for week3's Course Project for Data Scientist series Getting
# and Cleaning Data Couse provided by Coursera.
# Author: David Zhiqiang MA Adam
# Creation Date: Nov 17, 2014
# Source Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Required Process:
#    1 Merges the training and the test sets to create one data set.
#    2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#    3 Uses descriptive activity names to name the activities in the data set
#    4 Appropriately labels the data set with descriptive variable names. 
#    5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#      for each activity and each subject.
#
# Result Required: A tiny data set with the average of each variable for each activity and each subject.

# Note:
# 1.There's decriptive text file named README.md and cookbook file along with this sourcecode file which can be found
#   in same github folder.
# 2.Reading the README.md file carefully and know the process as a whole, particularly Unzip downloaded data file into 
#   your R work dirctory's subfolder named data or any other subfolder name before running this R file.
# 3.Within this R file, there're lines to install needed packages, but if you want to install those packages in advance,
#   that doesn't matter. 
#   Since you may encounter with network problems to download packages during running this file, 
#   so install packages below before is encouraged.
#   Applied Package: "data.table", "LaF", "plyr"
# 4.There is a little different between the original required/suggested steps order and the real running order
#   for easier handle of data.
# 5.This file can be run more than one times but get same result.

################ Step 0 - Prepare Environment  ################
### install and load needed packages
if("plyr" %in% rownames(installed.packages())) 
  #This package may doesn't need for you and this code file, but load it 
  #here for any further more efficient means to fulfill same purposes or test/compare some middle result.
{
  library(plyr)
} else{
  install.packages("plyr")
  library(plyr)
}

if( "LaF" %in% rownames(installed.packages())) # For read hugh text file
{
  library(LaF)
} else{
  install.packages("LaF")
  library(LaF)
}

if( "data.table" %in% rownames(installed.packages())) 
{
  library(data.table)
} else {
  install.packages("data.table")
  library(data.table)
}
print("Step 0---packages are ready loaded---")

################ Step 1 - Read each data set file into different data.frame ################
print("Step 1 Entered---Read each data set file into different data.frame---")
### Prepare vectors needed by laf_open_fwf function which is for reading hugh fixed width textfile from package LaF
Vec_Width<- numeric()
Vec_Column<- character()
for (i in 1:561) { #561 means there are 561 features(columns)
  Vec_Width <- c(Vec_Width, 16) # number/column width
  Vec_Column<- c(Vec_Column, "string") # use string here, for orignal number format cannot be converted correctly.
}

##### Get Train data
datX <- laf_open_fwf(filename="./data/UCI HAR Dataset/train/X_train.txt",
                     column_types=Vec_Column,column_widths=Vec_Width,trim=TRUE)
dfXtrain <- datX[ , ]

dfYtrain<-read.table("./data/UCI HAR Dataset/train/y_train.txt",header=FALSE)
dfSubjectTrain<-read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)

##### Get Test data
datX <- laf_open_fwf(filename="./data/UCI HAR Dataset/test/X_test.txt", 
                     column_types=Vec_Column,column_widths=Vec_Width,trim=TRUE)
dfXtest <- datX[ , ]
dfYtest<-read.table("./data/UCI HAR Dataset/test/y_test.txt",header=FALSE)
dfSubjectTest<-read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)

##### Get Feature data
dfFeature<-read.table("./data/UCI HAR Dataset/features.txt",header=FALSE)

print("Step 1 Ended")
################ Step 2 - Merges the training and the test sets to create one data set named AllData  ##########
print("Step 2 Entered---Merges the training and the test sets to create one data set named AllData---")

##### Merges Training set with Training labels and subjects
TrainData<- cbind(dfSubjectTrain,dfYtrain,dfXtrain) 

##### Merges Test set with Test labels
TestData<- cbind(dfSubjectTest,dfYtest,dfXtest) 

##### Merges the training and the test sets to create one data set.
AllData<- rbind(TrainData,TestData)

print("Step 2 Ended")
################ Step 3 - Appropriately labels the data set with descriptive variable names.  ################
# As the course project profile suggested, we should do step of "Extracts only the measurements on the mean and 
# standard deviation for each measurement." now, but based on 2 reasons, we could do this later:
#  1) For measurements on the mean and standard deviation, they cuold be found every other 40 of all features, 
#     but after position 207 they change a lot, we have to location their position use vector like 
#     c(1:7,42:47,82:87,122:127,162:167,202:207,215,216...425:430,503,504,...) 
#     (Notice: the first column now is the Training Label not the first feature after we merge them together).  
#     How could we handle this kind of situation, especially when there are more features, identify their position
#     one by one manually or introduce a 3rd party program? 
#  2) Even we extract all the needed features, we should add each matched feature names for all of them, 
#     and we have to use the same position vector again to get those feature names from the features.txt. 
#     It can be done via outside program/technique or import features.txt as a new data frame, but all looks kind of troublesome. 
#     So I decide to "Appropriately labels the data set with descriptive variable names." first, then extract.

print("Step 3 Entered---Appropriately labels the data set with descriptive variable names---")

##### Add columns/variable names for AllData
# The column names could be in features data frame dfFeature. 
# Since we have a combined data frame AllData with the subject and activity as its first 2 columns, so add "Subject" 
# and "Activity" as the first 2 columns' name first.
cnames <- character()
cnames <- c(cnames,c("Subject","Activity"))
cnames<-c(cnames,as.character(dfFeature[[2]])) 
#The 2nd column of dfFeature are feature names while the first column are indice of feature.

# Add column names with the data set, you can type "names(AllData)" after R prompt to see the whole names
colnames(AllData) <- cnames 


print("Step 3 Ended")
################ Step 4 - Extracts only the measurements on the mean and standard deviation for each measurement. 
#The output data named AllDataExtracted #
print("Step 4 Entered---Extracts only the measurements on the mean and standard deviation for each measurement---")
AllDataExtracted<-AllData[,grep("Subject|Activity|\\b-mean()\\b|\\b-std()\\b", colnames(AllData))]  
# Keep those columns contain "Subject", "Activity, "-mean()" and "-std()", while all others will be removed.
# you can type names(AllDataExtracted) to see what we get 68 variables names for all variables 
# contian "mean()" and "std()" as part of their name, and the first 2 are "Subject" and "Activity".

# Notice: There are column names like "tBodyAcc-mean()-X" from original features.txt and following dfFeature, 
#         it doesn't matter for the data frame itself, but will affect later calculation, so they need to be 
#         modified with normal name.
# Change Rule:
#   1) - to _
#   2) remove ()

cnames <- colnames(AllDataExtracted)
for(i in 3:length(cnames)) # 3 means to omit the first 2 columns which is subject and Activity
{
  cnames[i]<-gsub("-","_",cnames[i]) # - to _ 
  cnames[i]<-gsub("\\(\\)","",cnames[i]) # remove ()
}

colnames(AllDataExtracted) <- cnames #Rename it 
print("Step 4 Ended")

################ Step 5 - Uses descriptive activity names to name the activities in the data set ##########
print("Step 5 Entered---Uses descriptive activity names to name the activities in the data set---")

# Get the matching policy from activity_labels.txt and change their name from Upper case to Lower case 
# except the first letter.
# If there are more activiries, we could create data set from original file then link/convert them, 
# since only 6 here, so use easy way like below.

for (i in 1: nrow(AllDataExtracted))
{
  if (AllDataExtracted[i,2]==1 ) AllDataExtracted[i,2]<-"Walking" 
# here, [i,2] means the i row and 2nd column, it's the Activity column.
  if (AllDataExtracted[i,2]==2 ) AllDataExtracted[i,2]<-"Walking_Upstairs"
  if (AllDataExtracted[i,2]==3 ) AllDataExtracted[i,2]<-"Walking_Downstairs"
  if (AllDataExtracted[i,2]==4 ) AllDataExtracted[i,2]<-"Sitting"
  if (AllDataExtracted[i,2]==5 ) AllDataExtracted[i,2]<-"Standing"
  if (AllDataExtracted[i,2]==6 ) AllDataExtracted[i,2]<-"Laying"
}

print("Step 5 Ended")
################ Step 6 - From the data set AllDataExtracted in step5, creates a second, independent 
#tidy data set named DataRequired with the average of each variable for each activity and each subject. #####
print("Step 6 Entered---create and output the needed tidy data---")
options(digits=9) # Set the dot digit to confirm no number accuration lose
AllDataExtracted[, c(3:68)] <- sapply(AllDataExtracted[, c(3:68)], as.numeric) 
#convert column (all together 68 columns, the first 2 are Subject and Activity)  type from string to number

DataRequired = data.table(AllDataExtracted)
DataRequired <-DataRequired[,lapply(.SD,mean),by='Subject,Activity']

write.table(DataRequired, file="DataRequired.txt", row.names=FALSE, col.names=FALSE, sep=",", quote=FALSE) 
# output the required final Data set into a file named DataRequired.txt in the work directoty.

print("Step 6 Ended--All done. Find the needed file DataRequired.txt in work folder---")