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

- We then moved the training and testing data in to dataframe tables in order to use the dply package  
```
X_test_tbl_df <- tbl_df(X_test)
y_test_tbl_df <- tbl_df(y_test)
subject_test_tbl_df <- tbl_df(subject_test)

X_train_tbl_df <- tbl_df(X_train)
y_train_tbl_df <- tbl_df(y_train)
subject_train_tbl_df <- tbl_df(subject_train)
```
