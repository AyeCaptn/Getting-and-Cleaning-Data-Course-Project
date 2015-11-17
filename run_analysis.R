# Install and load the necessary packages
if (!require("reshape2")) { install.packages("reshape2") }
if (!require("dplyr")) { install.packages("dplyr") }
library("reshape2")
library("dplyr")

# Read in the training and test set raw data files.
X_train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
X_test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")

# Read in the features data
features <- read.table("UCI\ HAR\ Dataset/features.txt")[,2]

# Merge data from X_train with the data from X_test
X_full <- rbind(X_train, X_test)

# Set the appropriate column names on our merged set
names(X_full) <- features

# Extract all columns containing mean and std
X_full <- X_full[, grep('mean|std', colnames(X_full))]
# Drop all columns containing meanFreq
X_full <- X_full[, - grep('meanFreq', colnames(X_full))]

# Read in the labels for the training and test sets
y_train <- read.table("UCI\ HAR\ Dataset/train/y_train.txt", col.names = c("ActivityID"))
y_test <- read.table("UCI\ HAR\ Dataset/test/y_test.txt", col.names = c("ActivityID"))

# Combine the data from y_train with the data from y_test in one dataframe
y_full <- rbind(y_train, y_test)

# Read in the activity labels data and replace them with the integer values
act_labels <- read.table("UCI\ HAR\ Dataset/activity_labels.txt", col.names = c("ActivityID", "ActivityLabel"))
y_full <- left_join(y_full, act_labels, by = "ActivityID")

# Combine the labels with the features
X_y_full <- cbind(X_full, y_full)

# Read the subjects file and combine the two data
subject_train <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt" , col.names = c("SubjectID"))
subject_test <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt" , col.names = c("SubjectID"))
subject_full <- rbind(subject_train, subject_test)

# Add the subject column to X_y_full
X_y_full$SubjectID <- subject_full$SubjectID

# Melt the X_y_full dataframe
allIDs <- c('SubjectID', 'ActivityID', 'ActivityLabel')
allVariables <- setdiff(colnames(X_y_full), allIDs)
X_y_fullMelt <-melt(X_y_full, id = allIDs, measure.vars = allVariables)

# Create a separate data set with the average of each variable for each activity and each subject.
tidy_data = dcast(X_y_fullMelt, SubjectID + ActivityLabel ~ variable, mean)

# Edit the column names to reflect that they hold the means
names(tidy_data) <- c('SubjectID', 'ActivityLabel', paste("Avg", setdiff(colnames(tidy_data), c('SubjectID', 'ActivityLabel')), sep = ""))

 # Write out the tidy dataset in txt format, not using column names
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)