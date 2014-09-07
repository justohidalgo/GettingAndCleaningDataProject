library(dplyr)
library(sqldf)

#
# Steps required for the project
#
# 1. Merges the training and the test sets to create one data set.
#
X_test <- read.csv("./UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
# Adding activity measurements
X_test[,562] <- read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
# Adding subject info
X_test[,563] <- read.csv("./UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
X_training <- read.csv("./UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
X_training[,562] <- read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
X_training[,563] <- read.csv("./UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
labels <- read.csv("./UCI HAR Dataset/activity_labels.txt", sep=" ", header=FALSE)
# Obtaining merged dataset
wholeset <- rbind(X_training, X_test)

#
# Extracts only the measurements on the mean and standard deviation for each measurement. 
#
feature_metadata <- read.csv("./UCI HAR Dataset/features.txt", sep="", header=FALSE)
feature_metadata_filter <- sqldf("select V1, V2 from feature_metadata where V2 like '%mean%' or V2 like '%std%'")
# Obtaining vector indexes
metadata_vector <- feature_metadata_filter$V1
metadata_vector <- as.vector(metadata_vector)
# Filtering the original dataset keeping only the required columns + subject + activity
filteredwholeset <- wholeset[, c(metadata_vector, 562, 563)]

#
# Uses descriptive activity names to name the activities in the data set
#
#Join between filtered dataset and activity labels
filteredwholesetactivitydesc <- merge(filteredwholeset, labels, by.x="V1.1", by.y="V1")
#Getting rid of the activity index column
filteredwholesetactivitydesc <- subset(filteredwholesetactivitydesc, select = -c(1))

#
# 4. Appropriately labels the data set with descriptive variable names.
#
# Naming conventions of variable names as explained in the course
feature_metadata_filter$V2 <- gsub("-", "", tolower(feature_metadata_filter$V2))
colnames(filteredwholesetactivitydesc) <- c(as.vector(feature_metadata_filter$V2), "subject", "activity")
#
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
aggregate_result <- aggregate(filteredwholesetactivitydesc, list(activity=filteredwholesetactivitydesc$activity, subject=filteredwholesetactivitydesc$subject), mean)
# Getting rid of the activity and subject columns as it doesn't make sense to obtain averages from them.
aggregate_result_tidy <- subset(aggregate_result, select = -c(89, 90))
# Write tidy table to file.
write.table(aggregate_result_tidy, "./tidy_table.txt", sep="\t", row.name=FALSE)



