# Download and unzip File 

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile="./Data.zip")
unzip("Data.zip", list= FALSE)

#Read test data and train data
subjectTrain <- read.csv("subject_train.txt", sep="", header= FALSE)
Xtrain<- read.csv("X_train.txt", sep="", header= FALSE)
Ytrain<- read.csv("y_train.txt", sep="", header= FALSE)

subjectTest <- read.csv("subject_test.txt", sep="", header= FALSE)
Xtest<- read.csv("X_test.txt", sep="", header=FALSE)
Ytest<- read.csv("y_test.txt", sep="", header=FALSE)

#Read the column names in X_train & X_test datasets
col_x <- read.csv("features.txt", header= FALSE, sep="" )
colnames(Xtrain) <- col_x[,2]
colnames(Xtest) <- col_x[,2]

library(sqldf)
reqcol <- sqldf("select * from col_x where V2 like '%mean()%' or V2 like '%std()%'")

#Extract the columns that measure mean & std in the X_train & X_test datasets
i <- reqcol[ , 1]

Xtrain_mnst <- Xtrain[, i ]
Xtest_mnst <- Xtest[, i]

#Renaming the column names in the subject and Y datasets
colnames(subjectTrain) <- c("subject")
colnames(Ytrain) <- c("activity")

colnames(subjectTest) <- c("subject")
colnames(Ytest) <- c("activity")

#Column binding the subject, X & Y datasets
Train_set <- data.frame(cbind(subjectTrain, Xtrain_mnst, Ytrain ))
Test_set <- data.frame(cbind(subjectTest, Xtest_mnst, Ytest ))

#Merging the train and test datasets
merged_dataset <- rbind(Train_set, Test_set)

#Naming the activities using descriptive activity names
merged_dataset$activity <- as.factor(merged_dataset$activity)
levels(merged_dataset$activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

#Descriptive column names for merged_dataset
names(merged_dataset) <- gsub("\\.", "", names(merged_dataset))
names(merged_dataset) <- gsub("std", "standarddeviation", names(merged_dataset))
names(merged_dataset) <- gsub("Acc", "acceleration", names(merged_dataset))

# Tidy dataset is the merged_dataset

#New dataset with mean of all columns by each activity & each subject
new_dataset <-  aggregate(.~activity+subject, data=merged_dataset, FUN=mean)
new_dataset$activity <- as.factor(new_dataset$activity)
levels(new_dataset$activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

#Write the tidy dataset to a csv file
write.csv(merged_dataset, file="tidyDataset.txt")
#write.csv(new_dataset, file="newDataset.txt")
