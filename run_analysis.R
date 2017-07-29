## ----------------------------------------------------------------------------
## File Name - run_analysis.R
## This R script was developed for the final project of the Getting and 
## Cleaning Data Course 
## It's intent is to produce clean data to be used later. 
## It does the following - 
##    1) Merges the training and the test sets to create one data set.
##    2) Extracts only the measurements on the mean and standard deviation 
##       for each measurement.
##    3) Uses descriptive activity names to name the activities in the data set
##    4) Appropriately labels the data set with descriptive variable names.
##    5) From the data set in step 4, creates a second, independent tidy 
##       data set with the average of each variable for each activity and 
##       each subject.
## ----------------------------------------------------------------------------

library(dplyr)

## Read the data into dataframes
## The folder containing the data has been renamed to UCI_HAR_Dataset
X_test <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
y_test <- read.table("./UCI_HAR_Dataset/test/y_test.txt")
subject_test <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")

X_train <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
y_train <- read.table("./UCI_HAR_Dataset/train/y_train.txt")
subject_train <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")

# Read in features name and activity names
feat_names <- read.table("./UCI_HAR_Dataset/features.txt", colClasses = c("NULL",NA))
act_names <- read.table("./UCI_HAR_Dataset/activity_labels.txt", colClasses = c("NULL",NA))

## Create data frame tbl
X_test_tbl_df <- tbl_df(X_test)
y_test_tbl_df <- tbl_df(y_test)
subject_test_tbl_df <- tbl_df(subject_test)

X_train_tbl_df <- tbl_df(X_train)
y_train_tbl_df <- tbl_df(y_train)
subject_train_tbl_df <- tbl_df(subject_train)


## Bind row before doing a final merge
X_bind <- bind_rows(X_test_tbl_df, X_train_tbl_df)
y_bind <- bind_rows(y_test_tbl_df, y_train_tbl_df)
subject_bind <- bind_rows(subject_test_tbl_df, subject_train_tbl_df)

## Add meaningful label for each column of the tables
## X_bind contains the 561 colums of data coinciding with labels in feat tables
for(ii in 1:ncol(X_bind)){
  colnames(X_bind)[ii] <- as.character(feat_names[ii,1])
}

## Add meaningful names to the subject and activity columns
colnames(y_bind) <- "Activity"
colnames(subject_bind) <- "Subject_ID"

## Change to meaningful names for the values of the activity data
for(jj in 1:nrow(y_bind)){
  ## rename as WALKING
  if(y_bind[jj,1] == 1) {
    y_bind[jj,1] <- as.character(act_names[1,1])
  }
  ## rename as WALKING_UPSTAIRS
  if(y_bind[jj,1] == 2) {
    y_bind[jj,1] <- as.character(act_names[2,1])
  }
  ## rename as WALKING_DOWNSTAIRS
  if(y_bind[jj,1] == 3) {
    y_bind[jj,1] <- as.character(act_names[3,1])
  }
  ## rename as SITTING
  if(y_bind[jj,1] == 4) {
    y_bind[jj,1] <- as.character(act_names[4,1])
  }
  ## rename as STANDING
  if(y_bind[jj,1] == 5) {
    y_bind[jj,1] <- as.character(act_names[5,1])
  }
  ## rename as LAYING
  if(y_bind[jj,1] == 6) {
    y_bind[jj,1] <- as.character(act_names[6,1])
  }
}

## Extracts only the measurements on the mean and standard deviation 
## for each measurement. 
name_pattern <- c("mean","std")
cols_to_keep <- grepl(name_pattern, X_bind)

## Column bind to get -a merged dataset
merged_dataset <- bind_cols(subject_bind, y_bind, X_bind)

## Subset of merged dataset with only mean and std. deviation measurements
merged_sub_dataset <- 


## ----------------------------------------------------------------------------
## Garbage collection - Save memory
## ----------------------------------------------------------------------------
## remove table df's that are no longer needed
rm(X_test_tbl_df, y_test_tbl_df, subject_test_tbl_df, X_train_tbl_df, 
   y_train_tbl_df, subject_train_tbl_df)
## remove tables to save some memory
rm(X_test, y_test, subject_test, X_train, y_train, subject_train)
## remove the test+table bind df's
rm(subject_bind,y_bind, X_bind)
## remove act and feat names
rm(act_names, feat_names)
## remove other variables
rm(ii,jj)
## ----------------------------------------------------------------------------