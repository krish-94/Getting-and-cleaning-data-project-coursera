### To get the column names of the data set to be built

features <- as.list(read.table("C:/Users/KRISHNAKUMAR/Documents/UCI HAR Dataset/features.txt"))
column_names <- c("activity", "subject", as.character(features$V2))

### To build the training data set

labl_train <- read.table("C:/Users/KRISHNAKUMAR/Documents/UCI HAR Dataset/train/y_train.txt")
subj_train <- read.table("C:/Users/KRISHNAKUMAR/Documents/UCI HAR Dataset/train/subject_train.txt")
data_train <- read.table("C:/Users/KRISHNAKUMAR/Documents/UCI HAR Dataset/train/X_train.txt")
train_data <- cbind(labl_train, subj_train, data_train)
colnames(train_data) <- column_names

### To build the test data set

labl_test <- read.table("C:/Users/KRISHNAKUMAR/Documents/UCI HAR Dataset/test/y_test.txt")
subj_test <- read.table("C:/Users/KRISHNAKUMAR/Documents/UCI HAR Dataset/test/subject_test.txt")
data_test <- read.table("C:/Users/KRISHNAKUMAR/Documents/UCI HAR Dataset/test/X_test.txt")
test_data <- cbind(labl_test, subj_test, data_test)
colnames(test_data) <- column_names

### 1) Merge test and training data as one data set

merged_data <- rbind(train_data, test_data)

### 2) Extracts only the measurements on the mean and standard deviation for each measurement

req_char <- merged_data[,grep("Mean|mean|std",colnames(merged_data))]

### 3) Uses descriptive activity names to name the activities in the data set

activity_lables <- read.table("C:/Users/KRISHNAKUMAR/Documents/UCI HAR Dataset/activity_labels.txt")
merged_data$activity <- factor(merged_data$activity, labels = as.character(activity_lables$V2))

### 4) Appropriately labels the data set with descriptive variable names

### The column names are already added while building the individual data set (in previous steps)

### 5) From the data set in step 4, creates a second, independent tidy data set with the average
###    of each variable for each activity and each subject.

merged_data <- merged_data[,grep("Mean|mean|std|activity|subject",colnames(merged_data))]
second_data <- merged_data %>% group_by(activity,subject) %>% summarise_all(funs(mean))
write.table(second_data, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)

### i have used the grep for mean and std again in this step because if i have all the original variables
### (variables not having mean and std) i get error for non-unique column names for summarise_all function









