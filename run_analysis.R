##Getting and Cleaning Data
##Week 3 Course Project 

setwd("C://Users//aloha//Desktop//R_working_directory//courera_getting_cleaning_data//UCI_HAR_Dataset")

#############################################################################
#############################################################################
#1.Merges the training and the test sets to create one data set.
#load x_train data and x_test data, assign column names to each data set, and then merge these two data sets into one data set named x_train_test
x_train <- read.table("train//X_train.txt")
x_test <- read.table("test//X_test.txt")

colnames(x_train)        <- features[,2];
colnames(x_test)        <- features[,2];

x_train_test <- rbind(x_train, x_test)

#load y_train data and y_test data, assign column names to each data set, and then merge these two data sets into one data set named y_train_test
y_train <- read.table("train//y_train.txt")
y_test <- read.table("test//y_test.txt")

colnames(y_test)        <- "activity_id";
colnames(y_train)        <- "activity_id";

y_train_test <- rbind(y_train, y_test)

#load subject_train data and subject_test data, assign column names to each data set, and then merge these two data sets into one data set named subject_train_test
subject_train <- read.table("train//subject_train.txt")
subject_test <- read.table("test//subject_test.txt")

colnames(subject_train)  <- "subject_id";
colnames(subject_test)  <- "subject_id";

subject_train_test <- rbind(subject_train, subject_test)

#load features data and activity lables data which will be use for later tasks
features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")

colnames(activity)  <- c('activity_id','activity_label');


#merge the training and the test data sets into one data set named train_test_data
train_test_data <- cbind(x_train_test, y_train_test, subject_train_test)

colNames  <- colnames(train_test_data); 

#############################################################################
#############################################################################
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
head(features)
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_train_test  <- x_train_test [, mean_and_std_features]

#############################################################################
#############################################################################
#3.Uses descriptive activity names to name the activities in the data set
train_test_data <- merge(train_test_data, activity, by = "activity_id")
colNames  = colnames(train_test_data); 

#############################################################################
#############################################################################
#4.Appropriately labels the data set with descriptive variable names.  
names(x_data) <- features[mean_and_std_features, 2]
names(y_data) <- "activity"
names(subject_data) <- "subject"
final_data <- cbind(x_data, y_data, subject_data)

#############################################################################
#############################################################################
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
final_data  = train_test_data[,names(train_test_data) != 'activity'];
write.table(final_data, file = "tidy_data.txt")

