# README - Peer-graded Assignment: Getting and Cleaning Data Course Project

 
## Contents
- This repo contains the data for the UCI_HAR_Dataset
- It has one script run_analysis.R that contains the code for the project



## Script Details - run_analysis.R
1. Read the data from the test and training data into dataframes tables - X_test, Y_test, subject_test, X_train, Y_train, subject_train
2. Read in features name and activity names into dataframe tables - feat_names, act_names
3. Create a data frame table for the test and training data. These can be found in the script. They use the same variable names as found in (1) with the suffix _tbl_df
4. Merges the data from the test and training dataframes tables by using row binding
5. When the feature data is merged we use the feature names (feat_names) to label the columns of the merged feature data table
6. We then provide meaningful column label for the subject and activity columns
7. Next we parse through the activity dataframe and replace the activity id numbers with meaningful actvity names by matching the id with the activity name found in the act_names database
8. We then give the feature dataframe unique column names and subset out the mean and std information into a new dataframe
9. Finally we flatten the database by calculating the means of the features grouped by the subject id and activity  



## Notes
1. The script assumes the data is available in the same folder
   e.g. - X_test <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
   If you have it located else where you will need to update this
2. The script does some garbage cleaning and removes intermediate and temp 
   varibles at the end of the script
