rm(list=ls())
getwd()

setwd("C:/Users/Daniel Slyngstad/Documents/R Working Directory/RMOOC2")
library(tidyverse)
library(lubridate)

#reading in and extracting features/variable names
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","measure"))
table(features$measure)
cols <- features$measure

#reading in other datasets
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("cat", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = cols)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "cat")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = cols)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "cat")

#doing checks on dimensions and data, etc.
head(features)
head(activity_labels)
head(subject_test)

head(x_test)
dim(x_test)

head(y_test)
dim(y_test)

head(subject_train)
unique(subject_train)

head(x_train)
dim(x_train)

head(y_train)
dim(x_train)

#appending x train and test sets to make full set of x rows
x_full <- rbind(x_train, x_test)
head(x_full)
dim(x_full)

#appending y train and test sets to make full set of y rows
y_full <- rbind(y_train, y_test)
head(y_full)
dim(y_full)

#same for subjects data
subject_full <- rbind(subject_train, subject_test)
dim(subject_full)

#making the merged dataset
merged_df <- cbind(subject_full, x_full, y_full)

dim(merged_df)
head(merged_df)

#converting to a tibble to be able to select variables to include in df w text processing of names
mergedTib <- as.tibble(merged_df)
mergedTib

#making the tibble with correct variables
tidytib <- mergedTib %>% 
           select(subject, cat, contains('mean'), contains('std'))
tidytib

names(tidytib)

tidytib$cat

#recoding cat by assigning activity labels to it
tidytib$cat <- recode_factor(tidytib$cat, '1' = "Walking", '2' = "WalkingUpstairs", 
                              '3' = "WalkingDownstairs", '4' = "Sitting", '5' = 'Standing', '6' = 'Laying')


?grep

#renaming variables to be more intuitive
names(tidytib)[2] = "activity_type"
names(tidytib)<-gsub("^t", "time", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("\.t", "time", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("^f", "frequency", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("-freq()", "frequency", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("-mean()", "mean", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("-std()", "std", names(tidytib), ignore.case = TRUE)

names(tidytib)

names(tidytib)<-gsub("Body", "body", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("Mag", "magnitude", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("Acc", "accelerometer", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("Gyro", "gyroscope", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("angle", "angle", names(tidytib), ignore.case = TRUE)
names(tidytib)<-gsub("gravity", "gravity", names(tidytib), ignore.case = TRUE)

names(tidytib)

?summarize
#making a new tibble grouped by subject and activity
group_tibble <- tidytib %>%
  group_by(subject, activity_type) %>%
  summarize_all(list(mean))

group_tibble
names(group_tibble)

#outputting a dataset
write.csv(group_tibble, "means_tibble.csv", row.names=TRUE)
write.table(group_tibble, 'means_tibble_text', row.names = FALSE)

#double check
means_tibble <- read.table("means_tibble_text")
View(means_tibble)
