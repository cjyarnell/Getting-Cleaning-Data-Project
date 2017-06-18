### Getting and Cleaning Data Final Project
### Christopher Yarnell

### load required dependencies
library(dplyr)

### 1. Merge training and test datasets.

### 1a. Download the data

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
unzip(zipfile = "getdata%2Fprojectfiles%2FUCI HAR Dataset.zip")
### data is now in folder in working drive called UCI HAR Dataset

### 1b. Load test and training data
test_data     = data.frame(read.table("UCI HAR Dataset/test/X_test.txt"))
test_labels   = data.frame(read.table("UCI HAR Dataset/test/Y_test.txt"))
test_subjects = data.frame(read.table("UCI HAR Dataset/test/subject_test.txt"))

train_data     = data.frame(read.table("UCI HAR Dataset/train/X_train.txt"))
train_labels   = data.frame(read.table("UCI HAR Dataset/train/Y_train.txt"))
train_subjects = data.frame(read.table("UCI HAR Dataset/train/subject_train.txt"))

### 1c. Merge datasets

### bind columns
test  <- cbind.data.frame(test_data, test_labels, test_subjects)
train <- cbind.data.frame(train_data, train_labels, train_subjects)

### bind rows
data <- rbind.data.frame(test, train)

### 2. Extract only the measurements on the mean and standard deviation 
###    for each measurement.

### read in the features.txt document to get the names for the data frame.
data_names <- read.table("UCI HAR Dataset/features.txt")
data_names <- as.character(data_names[,2]) ### convert to strings
names(data) <- data_names ### label dataframe
names(data)[562:563] <- c("Activity","Subject") ### add missing names

### Identify column indices for measurements of mean
mean_columns <- grep("-mean()", fixed = TRUE, names(data))
### Identify column indices for measurements of std
std_columns <- grep("-std()", fixed = TRUE, names(data))

### isolate the columns needed
data <- data[,c(mean_columns, std_columns, 562:563)]
### reorder to put subject first then activity then the rest of the columns
data <- select(data, Subject, Activity, everything())

### 3. Relabel the dataset with descriptive activity names as follows:
###    walking, walking_upstairs, walking_downstairs, sitting, standing, laying

activity_names <- c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
data <- mutate(data, Activity = activity_names[data$Activity])

### 4. Relabel the dataset with appropriate variable names

### store original names
original_names <- names(data)

### process new names
new_names <- gsub("Body", "", original_names)
new_names <- sub("f", "frequency_", new_names)
new_names <- sub("Gyro", "rotational_", new_names)
new_names <- sub("Mag", "magnitude_", new_names)
new_names <- sub("Jerk", "jerk_", new_names)
new_names <- sub("Acc", "acceleration_", new_names)
new_names <- sub("^t", "", new_names)
new_names <- sub("Gravity", "gravity_", new_names)
new_names <- sub("-std\\(\\)", "standard_deviation", new_names)
new_names <- sub("-mean\\(\\)", "mean", new_names)
new_names <- sub("-", "_", new_names)

names(data) <- new_names

### 5. Create a second tidy dataset with the average of each variable for
###    each variable and each subject.

grouped <- group_by(data, Activity, Subject)
tidy <- summarise_each(grouped, "mean", acceleration_mean_X:frequency_rotational_jerk_magnitude_standard_deviation)
write.table(tidy, file = "UCI HAR Dataset Averages-by-Subject.txt", row.names = FALSE)

