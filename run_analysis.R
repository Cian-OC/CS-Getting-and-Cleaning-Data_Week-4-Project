



library(dplyr)

library(pacman)

pacman::p_load(data.table, reshape2, gsubfn)

## Get the data

W4Data<- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dat.wearable.zip")

unzip(zipfile="dat.wearable.zip", exdir = "C:/Users/ciano/OneDrive/Documents/Coursera_DS_Course/DS_Getting-and-Cleaning-Data/GandC-Data_Week-4/GandC-Data-Week-4")

list.files("C:/Users/ciano/OneDrive/Documents/Coursera_DS_Course/DS_Getting-and-Cleaning-Data/GandC-Data_Week-4/GandC-Data-Week-4")

path2data = file.path("C:/Users/ciano/OneDrive/Documents/Coursera_DS_Course/DS_Getting-and-Cleaning-Data/GandC-Data_Week-4/GandC-Data-Week-4", "UCI HAR Dataset")

files = list.files(path2data, recursive = TRUE)

## Read the data

trainSubs<- read.table(file.path(path2data, "train", "subject_train.txt"))

colnames(trainSubs) <- "TrainingSubject"

trainVals <- read.table(file.path(path2data, "train", "X_train.txt"))
trainAct <- read.table(file.path(path2data, "train", "y_train.txt"))

testSubs <- read.table(file.path(path2data, "test", "subject_test.txt"))

colnames(testSubs) <- "TrainingSubject"

testVals <- read.table(file.path(path2data, "test", "X_test.txt"))
testAct <- read.table(file.path(path2data, "test", "y_test.txt"))

features <- read.table(file.path(path2data, "features.txt" ))

activities <- read.table(file.path(path2data, "activity_labels.txt"))

## get all values in 1 dataset, and rename

allVals<-rbind(trainVals,testVals)

colnames(allVals) <- features[,2]

## get all subjects and rename

allSubs <- rbind(trainSubs, testSubs)

colnames(allSubs) <- "SubjectID"

## get all activities and rename

allAct <- rbind(trainAct, testAct)

colnames(allAct) <- "ActivityID"

allAct$ActivityID <- factor(allAct$ActivityID, 
                            levels = activities[,1], 
                            labels = activities[,2])

## cbind all together

allData2 <- cbind(allSubs, allAct, allVals)

## get all the mean and standard deviation columns

keepColumns <- grepl("TrainingSubject|ActivityID|mean|std", colnames(allData2))

allData3 <- allData2[,keepColumns]

## Tidy up the variable names

allColNames <- colnames(allData3)

allColNames2 <- gsubfn("^t|^f|Acc|Gyro|Mag|BodyBody|\\(\\)|mean|std",
                       list(
                         "t" = "Time",
                         "f" = "Frequency",
                         "Acc" = "Accelerometer",
                         "Gyro" = "Gyroscope",
                         "Mag" = "Magnitude",
                         "BodyBOdy" = "Body",
                         "()" = "",
                         "mean" = "Mean",
                         "std" = "StandardDeviation"
                       ),
                       allColNames
)

colnames(allData3) <- allColNames2

## Write new dataset for average of each variable for each activity and subject

## use setDT() to set it as a data table called allData4

allData4 <- setDT(allData3)

allData4 <- melt.data.table(allData3, id=c("TrainingSubject", "ActivityID"))

allData5 <- dcast(allData4, TrainingSubject + ActivityID ~ variable, mean)

fwrite(allData5, file="tidydata.txt")

write.table(allData5, "tidydata.txt", row.names = FALSE)