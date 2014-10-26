# GETTING AND CLEANING DATA COURSERA COURSE PROJECT
# OCTOBER 26, 2014

# read the activity labels and convert them to character vectors
labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
labels_c <- as.character(labels$V2)
# read the features names and convert them to character vectors
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
features_c <- as.character(features$V2)
# append the subject and activity as a "feature" for future processing
features_c <- append("activity", features_c)
all_features <- append("subject", features_c)


# measurements from the test group
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
# measurements from the training group
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
# corresponding activities of the test group
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
# corresponding activities of the training group
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
# test group subjects
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
# training group subjects
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# associate the subjects with the activities and the test data
test <- cbind(subject_test, y_test, x_test)
# associate the subjects with the activities and the training data
train <- cbind(subject_train,y_train, x_train)
# merge the training and test data
train_test_merged <- rbind(train,test)

# replace column names with the read features
colnames(train_test_merged) <- all_features

# select only the columns of mean and standard deviation data
train_test_merged_filtered <- train_test_merged[, grepl("mean|std|activity|subject", all_features)]

# replace the activity labels with comprehensive names
# not the best practice, but no time left for optimization
train_test_merged_filtered$activity[train_test_merged_filtered$activity == "1"] <- labels_c[1]
train_test_merged_filtered$activity[train_test_merged_filtered$activity == "2"] <- labels_c[2]
train_test_merged_filtered$activity[train_test_merged_filtered$activity == "3"] <- labels_c[3]
train_test_merged_filtered$activity[train_test_merged_filtered$activity == "4"] <- labels_c[4]
train_test_merged_filtered$activity[train_test_merged_filtered$activity == "5"] <- labels_c[5]
train_test_merged_filtered$activity[train_test_merged_filtered$activity == "6"] <- labels_c[6]

# grab the subjects numbers
subjects <- unique(train_test_merged_filtered[,1])

# create empty dataset to store the tidy data
train_test_merged_filtered_averaged <- train_test_merged_filtered[0,]

library(dplyr)

coltitles <- names(train_test_merged_filtered)

for (s in subjects) {
  for (a in labels_c) {
    subject_activity_data <- filter(train_test_merged_filtered, subject == s, activity == a)
    averages <- colMeans(select(subject_activity_data, -(subject:activity)))
    new_row <- data.frame(matrix(averages, nrow=1))
    c1 <- c(s)
    c2 <- c(a)
    s_a <- data.frame(c1, c2)
    new_row_df <- cbind(s_a, new_row)
    colnames(new_row_df) <- coltitles
    train_test_merged_filtered_averaged <- rbind(train_test_merged_filtered_averaged, new_row_df)
  }
}

#sort on the subject name and then on the activity
train_test_merged_filtered_averaged <- arrange(train_test_merged_filtered_averaged, subject, desc(activity))

# write the tidy data set to a file
write.table(train_test_merged_filtered_averaged, "tidy_data_set.txt", row.name = FALSE)

# clean the environment
rm("test")
rm("x_test")
rm("y_test")
rm("subject_test")
rm("train")
rm("x_train")
rm("y_train")
rm("subject_train")
rm("features")
rm("all_features")
rm("features_c")
rm("labels")
rm("labels_c")
rm("s")
rm("a")
rm("subjects")
rm("train_test_merged")
rm("train_test_merged_filtered")
rm("subject_activity_data")
rm("new_row")
rm("new_row_df")
rm("s_a")
rm("c1")
rm("c2")
rm("coltitles")
rm("averages")
