Getting and Cleaning Data Course Project Readme file   
==================   
This Readme file explains how the script "run_analysis.R" works.   
As for the output data set and the uploaded text file, since they are not required to be ordered by the Subject, so you may find the last rows have the Subject 24 while Subject 30 rows are in the middle position.     
*******

Actually, you can run it directly if you have unzipped the original data folder to your R work folder's subfolder named data like below:   
-----------------------------------
Work folder: 				D:\Prog\R\WorkFolder\   
Project data folder:  	 D:\Prog\R\WorkFolder\_data_\UCI HAR Dataset\   
   
Notice: The project profile mentioned that put the unzipped folder "UCI HAR Dataset" to work folder, but since I have a subfolder named data in work folder for all kinds of data, so I unzipped it there.   
If you want to run this code "run_analysis.R" directly, make sure you do unzip the original zip file to the sub "data" folder instead of the root work folder.   
-----------------------------------

Then after R prompt >, run it like    
```
source("run_analysis.R")   
```
It will first judge the needed packages were installed and loaded and finally load them like below, So avoiding any network issue to download these packages, you could manully load them in advance like below, but it's not necessary.   
-----------------------------------
```
  install.packages("plyr")   
  library(plyr)   
  install.packages("LaF")   
  library(LaF)   
  install.packages("data.table")   
  library(data.table)   
```
After load needed packages, it will begin do all the Transformations steps described in CodeBook.md.   
-----------------------------------
During its running process, it could output indicator message like below:   
*******
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
   


   
