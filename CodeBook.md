Getting and Cleaning Data Course Project CodeBook   
==================   
This code book that describes the variables, the data, and any transformations or work that I performed to clean up the data and get the required tidy data within a text file.   
   
## Variables    
There are 68 variables within the output data set. The first 2  Subject is subject and activity while the other 66 are mean value caculated for all original mean and std value from original train and testdata.   
-------------------------------   
Subject		The subject who performed the activity, it's an integer number from 1 to 30   
Activity		The activity name, there are 6 kind of activities in characters : Walking,Walking_Upstairs,Walking_Downstairs,Sitting,Standing,Laying   
   
#For the 66 variables below, here are desctiption in general.    
(There are 2 kind of units: gravity units 'g' for acceleration and radians/second for angular velocity, see below)   
1) t means time and f means frequency domain signal.   
2) Body means subject body while Gravity means earth gravity   
3) Acc means from accelerometer signal measurement with gravity units 'g', while Gyro means from gyroscope signal measurement with unit radians/second   
4) mean indicates the mean value of the measurements.   
5) std indicates the Standard deviation value of the measurements.   
6) Jerk means Jerk signal    
7) Mag indicates the magnitude of these three-dimensional signals were calculated using the Euclidean norm.   
6) X,Y,Z means 3-axial    
   
tBodyAcc_mean_X   
tBodyAcc_mean_Y   
tBodyAcc_mean_Z   
tBodyAcc_std_X   
tBodyAcc_std_Y   
tBodyAcc_std_Z   
tGravityAcc_mean_X   
tGravityAcc_mean_Y   
tGravityAcc_mean_Z   
tGravityAcc_std_X   
tGravityAcc_std_Y   
tGravityAcc_std_Z   
tBodyAccJerk_mean_X   
tBodyAccJerk_mean_Y   
tBodyAccJerk_mean_Z   
tBodyAccJerk_std_X   
tBodyAccJerk_std_Y   
tBodyAccJerk_std_Z   
tBodyGyro_mean_X   
tBodyGyro_mean_Y   
tBodyGyro_mean_Z   
tBodyGyro_std_X   
tBodyGyro_std_Y   
tBodyGyro_std_Z   
tBodyGyroJerk_mean_X   
tBodyGyroJerk_mean_Y   
tBodyGyroJerk_mean_Z   
tBodyGyroJerk_std_X   
tBodyGyroJerk_std_Y   
tBodyGyroJerk_std_Z   
tBodyAccMag_mean   
tBodyAccMag_std   
tGravityAccMag_mean   
tGravityAccMag_std   
tBodyAccJerkMag_mean   
tBodyAccJerkMag_std   
tBodyGyroMag_mean   
tBodyGyroMag_std   
tBodyGyroJerkMag_mean   
tBodyGyroJerkMag_std   
fBodyAcc_mean_X   
fBodyAcc_mean_Y   
fBodyAcc_mean_Z   
fBodyAcc_std_X   
fBodyAcc_std_Y   
fBodyAcc_std_Z   
fBodyAccJerk_mean_X   
fBodyAccJerk_mean_Y   
fBodyAccJerk_mean_Z   
fBodyAccJerk_std_X   
fBodyAccJerk_std_Y   
fBodyAccJerk_std_Z   
fBodyGyro_mean_X   
fBodyGyro_mean_Y   
fBodyGyro_mean_Z   
fBodyGyro_std_X   
fBodyGyro_std_Y   
fBodyGyro_std_Z   
fBodyAccMag_mean   
fBodyAccMag_std   
fBodyBodyAccJerkMag_mean   
fBodyBodyAccJerkMag_std   
fBodyBodyGyroMag_mean   
fBodyBodyGyroMag_std   
fBodyBodyGyroJerkMag_mean   
fBodyBodyGyroJerkMag_std   
   
## Data   
The output tidy data contains 68 columns as described above, and 180 rows in which shows each values for subject's each activity. As for the values, they are not have the same meaning with original feature value even they have similiar variable name, but the averaged value, here use mean value, and also can be changed to sum etc.   
   
The data looks like:   
Subject	Activity 	  tBodyAcc_mean_X  	           tBodyAcc_mean_Y...    fBodyBodyGyroJerkMag_std   
	1          Standing     0.278917629						-0.01613759010			-0.980096981   
	1          Sitting         0.261237565						-0.00130828765			-0.567447732   
	...   
	2    		Walking       -0.233444629						-0.01613759010			-0.478030486   
	2    		Laying          0.006344429						-0.01613759010			-0.653876951   
	...   
   
## Transformations steps to get the required tidy data in 7 steps (it's a little different with the step description in the code file)   
   
#1. Unzip the download file to work folder's subfolder named data, it looks like this:   
Work folder: 				D:\Prog\R\WorkFolder\   
Project data folder:  		D:\Prog\R\WorkFolder\data\UCI HAR Dataset\   
Notice: The project profile mentioned that put the unzipped folder "UCI HAR Dataset" to work folder, but since I have a subfolder data in work folder for all kinds of data, so I unzipped it there.   
If you wnat to run my code "run_analysis.R",  make sure you do unzip the original zip file to the sub "data" folder instead of the root work folder.   
   
#2. Read each data set file into different data.frame   
For the hugh text file I take advantages of LaF package, see steps below:   
install.packages("LaF")   
library(LaF)   
   
# The following is for preparing parameters for the fixed width text data.   
   
Vec_Width<- numeric()   
Vec_Column<- character()   
for (i in 1:561) { #561 means there are 561 features(columns)   
Vec_Width <- c(Vec_Width, 16)   
Vec_Column<- c(Vec_Column, "string")   
}   
# Begin reading data    
# Get Train data   
datX <- laf_open_fwf(filename="D:/Prog/R/WorkForder/data/UCI HAR Dataset/train/X_train.txt", column_types=Vec_Column,column_widths=Vec_Width,trim=TRUE)   
dfXtrain <- datX[ , ]   
dfYtrain<-read.table("D:/Prog/R/WorkForder/data/UCI HAR Dataset/train/y_train.txt",header=FALSE)   
dfSubjectTrain<-read.table("D:/Prog/R/WorkForder/data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)   
   
print(object.size(dfXtrain),units="Mb") #get size of data.frame dfXtrain : 235.1 Mb   
   
# Get Test data   
datX <- laf_open_fwf(filename="D:/Prog/R/WorkForder/data/UCI HAR Dataset/test/X_test.txt", column_types=Vec_Column,column_widths=Vec_Width,trim=TRUE)   
dfXtest <- datX[ , ]   
dfYtest<-read.table("D:/Prog/R/WorkForder/data/UCI HAR Dataset/test/y_test.txt",header=FALSE)   
dfSubjectTest<-read.table("D:/Prog/R/WorkForder/data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)   
   
# Get Feature data   
dfFeature<-read.table("D:/Prog/R/WorkForder/data/UCI HAR Dataset/features.txt",header=FALSE)   
   
# 2. Merges the training and the test sets to create one data set.   
2.1 Merges Training set with Training labels and subjects   
TrainData<- cbind(dfSubjectTrain,dfYtrain,dfXtrain)    
   
2.2 Merges Test set with Test labels   
TestData<- cbind(dfSubjectTest,dfYtest,dfXtest)    
   
2.3  Merges the training and the test sets to create one data set.   
AllData<- rbind(TrainData,TestData)   
   
#3. As the course project profile suggested, we should do step of "Extracts only the measurements on the mean and standard deviation for each measurement." now, but based on 2 reasons, we could do this later:   
1) For measurements on the mean and standard deviation, they cuold be found every other 40 of all features, but after position 207 they change a lot, we have to location their position use vector like c(1:7,42:47,82:87,122:127,162:167,202:207,215,216...425:430,503,504,...) (Notice: the first column now is the Training Label not the first feature after we merge them together).  How could we handle this kind of situation, especially when there are more features, identify their position one by one?    
2) Even we extract all the needed features, we should add each matched feature names for all of them, and we have to use the same position vector again to get those feature names from the features.txt. It can be done via outside program/technique or import features.txt as a new data frame, but all looks kind of troublesome.    
   
# So I decide to "Appropriately labels the data set with descriptive variable names." first, then extract.   
While the column names could be from features data frame dfFeature. Since we have a combined data frame AllData with the subject and activity as its first 2 columns, so add "Subject" and "Activity" as the first 2 columns' name.   
   
cnames <- character()   
cnames <- c(cnames,c("Subject","Activity"))   
cnames<-c(cnames,as.character(dfFeature[[2]])) # the 2nd column of dfFeature are feature names while the first column are indice of feature.   
   
#Add this vector as columns to the data frame.   
colnames(AllData) <- cnames   
   
you can type "names(AllData)" after R prompt to see the whole names.   
   
# 4. Extracts only the measurements on the mean and standard deviation for each measurement.   
AllDataExtracted<-AllData[,grep("Subject|Activity|\\b-mean()\\b|\\b-std()\\b", colnames(AllData))]  # Keep those columns contain "Subject", "Activity, "-mean()" and "-std()", while all others will be removed.   
   
# You can type "names(AllDataExtracted)" and you should find 68 variables with all variables contian "mean()" and "std()" as part of their name, and the first 2 are "Subject" and "Activity".   
   
#Notice: There are column names like "tBodyAcc-mean()-X" from original features.txt and following dfFeature , it doesn't matter for the data frame itself, but will affect later calculation, so they need to be modified with normal name.   
Change Rule:   
1) - to _   
2) remove ()   
   
cnames <- colnames(AllDataExtracted)   
for(i in 3:length(cnames)) # 3 means omit the first 2 columns which is subject and Activity   
{   
cnames[i]<-gsub("-","_",cnames[i])   
cnames[i]<-gsub("\\(\\)","",cnames[i])   
}   
colnames(AllDataExtracted) <- cnames #Rename it    
   
# 5. Uses descriptive activity names to name the activities in the data set   
Get the matching policy from activity_labels.txt and change their name from Upper case to Lower case except the first letter.   
If there are more activiries, we could create data set from original file then link/convert them, since only 6 here, so use easy way like below.   
   
for (i in 1: nrow(AllDataExtracted))   
{   
if (AllDataExtracted[i,2]==1 ) AllDataExtracted[i,2]<-"Walking"  # here, [i,2] means the i row and 2 column, it's the Activity column.   
if (AllDataExtracted[i,2]==2 ) AllDataExtracted[i,2]<-"Walking_Upstairs"   
if (AllDataExtracted[i,2]==3 ) AllDataExtracted[i,2]<-"Walking_Downstairs"   
if (AllDataExtracted[i,2]==4 ) AllDataExtracted[i,2]<-"Sitting"   
if (AllDataExtracted[i,2]==5 ) AllDataExtracted[i,2]<-"Standing"   
if (AllDataExtracted[i,2]==6 ) AllDataExtracted[i,2]<-"Laying"   
}   
   
# 6. From the data set in step5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.   
Firstly, convert the current columns' type from character to number for the following average calculation.   
   
options(digits=9) # Set the dot digit to confirm no number accuration lose   
AllDataExtracted[, c(3:68)] <- sapply(AllDataExtracted[, c(3:68)], as.numeric) # convert column (all together 68 columns, the first 2 are Subject and Activity)  type from string to number   
   
# Convert from data.frame to data.table to take advanatge of its function.   
DataRequired = data.table(AllDataExtracted)   
DataRequired <-DataRequired[,lapply(.SD,mean),by='Subject,Activity']   
   
# Output the required final Data set into a file named DataRequired.txt in the work folder.   
write.table(DataRequired, file="DataRequired.txt", row.names=FALSE, col.names=FALSE, sep=",", quote=FALSE)   
   
# 7. Compose a R code file and run it like below:   
source("run_analysis.R")   
There are will be step description output like below in several minutes:   
[1] "Step 0---packages are ready loaded---"   
[1] "Step 1 Entered---Read each data set file into different data.frame---"   
[1] "Step 1 Ended"   
[1] "Step 2 Entered---Merges the training and the test sets to create one data set named AllData---"   
[1] "Step 2 Ended"   
[1] "Step 3 Entered---Appropriately labels the data set with descriptive variable names---"   
[1] "Step 3 Ended"   
[1] "Step 4 Entered---Extracts only the measurements on the mean and standard deviation for each measurement---"   
[1] "Step 4 Ended"   
[1] "Step 5 Entered---Uses descriptive activity names to name the activities in the data set---"   
[1] "Step 5 Ended"   
[1] "Step 6 Entered---create and output the needed tidy data---"   
[1] "Step 6 Ended--All done. Find the needed file DataRequired.txt in work folder---"   
   
