#Assignment for Getting and Cleaning Data Coursera Course
#Frank Goeddeke, Jr.  
#April 2014

## BE SURE TO PUT ALL THE FILES INTO YOUR WORKING DIRECTORY!

##Merges the training and the test sets to create one data set.

#load activity_labels and features, then strip off column names
activity_labels <- read.table("activity_labels.txt", quote="\"")
activity_names <- activity_labels[,"V2"]
features <- read.table("features.txt", quote="\"")
columnNames <- features[1:561, "V2"]

#load x_test, y_test, subject_test
# put column name on subject_test
# put column names in x_test
x_test <- read.table("X_test.txt", quote="\"")
y_test <- read.table("y_test.txt", quote="\"")
subject_test <- read.table("subject_test.txt", quote="\"")
colnames(subject_test) <- "subject"
colnames(x_test) <- columnNames

#add ID numbers to all three objects
ID <- seq(1:2947)
subject_test2 <- cbind(ID, subject_test)
y_test2 <- cbind(ID, y_test)
x_test2 <- cbind(ID, x_test)

#MERGE subject_test, activities, x_test
test <- merge(subject_test2, y_test2, by="ID")
test2 <- merge(test, x_test2, by="ID")

#load x_train, y_train, subject_train, and merge files
x_train <- read.table("X_train.txt", quote="\"")
y_train <- read.table("y_train.txt", quote="\"")
subject_train <- read.table("subject_train.txt", quote="\"")
colnames(subject_train) <- "subject"
colnames(x_train) <- columnNames

#add ID numbers to all three objects
ID <- seq(2948:10299)
subject_train2 <- cbind(ID, subject_train)
y_train2 <- cbind(ID, y_train)
x_train2 <- cbind(ID, x_train)

#MERGE subject_test, activities, x_test
test3 <- merge(subject_train2, y_train2, by="ID")
test4 <- merge(test3, x_train2, by="ID")

#append the test and training data
test5 <- rbind(test2, test4)

##Extracts only the measurements on the mean and standard deviation for each measurement. 


# finds the numbers of column labels with mean() or std() using grep
x <- columnNames
selectedFeatures <- grep("mean()", x, fixed=TRUE)
selectedFeatures2 <- grep("std()", x, fixed=TRUE)

#combine both vectors
selected <- c(selectedFeatures, selectedFeatures2)

#ADDS 3 (ID, SUBJECT, ACTIVITY)
selected3 <- selected+3

#sort the selected and add 1-3 to it
selected4 <- sort(selected3)
a <- (1:3)
selected5 <- c(a, selected4)

# new dataset with only those columns
selected6 <- subset(test5, select=selected5)

##Uses descriptive activity names to name the activities in the data set
actints <- data.frame(selected6$V1)
selected6$V1[actints$selected6.V1 == 1] <- "walking"
selected6$V1[actints$selected6.V1 == 2] <- "walking upstairs"
selected6$V1[actints$selected6.V1 == 3] <- "walking downstairs"
selected6$V1[actints$selected6.V1 == 4] <- "sitting"
selected6$V1[actints$selected6.V1 == 5] <- "standing"
selected6$V1[actints$selected6.V1 == 6] <- "laying"

#change variable name V1 to "activity"
colnames(selected6)[3] <-  "activity"

##Appropriately labels the data set with descriptive activity names. 

write.table(selected6, "tidydata1.txt")

##Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
install.packages("reshape2")
library(reshape2)
filename = melt(selected6, id=c("subject", "activity"))
filename2 <- dcast(filename, formula = subject + activity ~ variable, mean)

write.table(filename2, "tidydata2.txt")
