# CodeBook - Peer-graded Assignment: Getting and Cleaning Data Course Project


## GitHub Documents
This code book describes the variables, the data, and any transformations that were performed to clean up the data  
 - The training, test, feature, and activity data was read into individual data frames over which transformations could be run on

```
X_test <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
y_test <- read.table("./UCI_HAR_Dataset/test/y_test.txt")
subject_test <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")

X_train <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
y_train <- read.table("./UCI_HAR_Dataset/train/y_train.txt")
subject_train <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")

# Read in features name and activity names
feat_names <- read.table("./UCI_HAR_Dataset/features.txt", colClasses = c("NULL",NA))
act_names <- read.table("./UCI_HAR_Dataset/activity_labels.txt", colClasses = c("NULL",NA))
```

- The training and testing data was moved in to dataframe tables in order to use the dply package  
```
X_test_tbl_df <- tbl_df(X_test)
y_test_tbl_df <- tbl_df(y_test)
subject_test_tbl_df <- tbl_df(subject_test)

X_train_tbl_df <- tbl_df(X_train)
y_train_tbl_df <- tbl_df(y_train)
subject_train_tbl_df <- tbl_df(subject_train)
```
- The test and training data was then merged using bind_rows from the dplyr package  
```
X_bind <- bind_rows(X_test_tbl_df, X_train_tbl_df)
y_bind <- bind_rows(y_test_tbl_df, y_train_tbl_df)
subject_bind <- bind_rows(subject_test_tbl_df, subject_train_tbl_df)
```
- Meaningful column names were then given to the feature data. We did this by getting the information from the feature names found in features.txt. The features were read in to a dataframe named feat_name.  
```
for(ii in 1:ncol(X_bind)){
  colnames(X_bind)[ii] <- as.character(feat_names[ii,1])
}
```
- Meaningful column names were given to the activity and subject data   
```
colnames(y_bind) <- "Activity"
colnames(subject_bind) <- "Subject_ID"
```
- The activity data is represent in id form. This is a bit meaningless unless you memorize what id stands for what activity. The ids were replaced the name of the activity. This was accomplished by looping through row by row and doing a replacement.  
```
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
```
- After cleaning up any duplicated column names in the feature data we merged the data to form a data set with the subject ids, activities and recorded feature data  
```
merged_dataset <- bind_cols(subject_bind, y_bind, X_bind_pruned)
```
- The assignment called for a flatten of the data based on subject id and activity. It also asked for the means to be calculated for the various features. This was accomplished by grouping the data on activity and subject id and calculating the means over the rest of the columns
```
final_dataset <-merged_dataset %>% group_by(Subject_ID, Activity) %>% summarise_all(funs(mean))
```
