Getting and Cleaning Data: Course Project
=========================================

This repository hosts the files required for the submission of the "Course Project" for the "Getting and Cleaning Data" course available on Coursera.

Description run_analysis.R
--------------------------

The goal of this script is to prepare tidy data that can be used for later analysis. It performs the following actions:

- The script assumes that all data is contained in a folder named "UCI HAR Dataset" containing two folders named "train" and "test".
- The script reads in all raw data and merges similar data contained in the training and test folders using the rbind() function.
- Unnecessary columns, as specified in the requirements, are dropped. Correct, comprehensable column names are added. 
- The labels for the activities performed while gathering the measurements are added in integer format as well as string format. 
- The IDs for the subjects performing the measurements are added.
- After the full dataset is created as specified in the requirements, we reshape the data using the melt() and dcast() functions to display the average for each variable for each activity and each subject. 
- This tidy data is writen out to "tidy_data.txt".

Annotations for what the functions do can be found in the script, to make reading the code easier.


Files
-----

- **README.md**: the readme file for this repo.
- **CodeBook.md**: codebook containing the description for the variables used in the script.
- **run_analysis.R**: script for the creation of tidy_data.txt.
- **tidy_data.txt**: output of run_analysis.R.