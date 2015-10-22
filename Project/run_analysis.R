# This script contains the R code necessary to complete the course project
# for Getting and Cleaning Data

library(dplyr)
library(tidyr)

# load activity table
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header=F,
                             stringsAsFactors=F)
colnames(activityLabels) <- c("code","label")


# load subject and variable names
features <- read.table("UCI HAR Dataset/features.txt", header=F, stringsAsFactors=F)[[2]]
feature.idx <- grep("mean\\(\\)|std\\(\\)", features)
features <- gsub("\\(|\\)", "", features[feature.idx])


# function for loading train or test data into data frame
loadDataFile <- function(setType, features, feature.idx, activityLabels) {
    # load data file and add column names
    dataFile <- sprintf("UCI HAR Dataset/%s/X_%s.txt", setType, setType)
    data <- read.table(dataFile, header=F, stringsAsFactors=F)[, feature.idx]
    colnames(data) <- features
    data$setLabel <- setType
    
    # add activity names
    activityFile <- sprintf("UCI HAR Dataset/%s/y_%s.txt", setType, setType)
    activityCodes <- read.table(activityFile, header=F, stringsAsFactors=F)[[1]]
    activities <- activityLabels$label[match(activityCodes, activityLabels$code)]
    data$activity <- activities
    
    # add subject IDs
    subjectFile <- sprintf("UCI HAR Dataset/%s/subject_%s.txt", setType, setType)
    subjectIds <- read.table(subjectFile, header=F, stringsAsFactors=F)[[1]]
    data$subjectId <- subjectIds
    
    data
}


# load training/test sets
trainingSet <- loadDataFile("train", features, feature.idx, activityLabels)
testSet <- loadDataFile("test", features, feature.idx, activityLabels)


# combine the two sets, convert to tidy table, group by subject/activity/variable
# and calculate mean value of the variable per group
groupedMeanVals <- rbind(trainingSet, testSet) %>%
    gather(key=variable, value=value, -c(setLabel,subjectId,activity)) %>%
    group_by(subjectId, activity, variable) %>%
    summarize(meanValue = mean(value, na.rm=T))

write.table(groupedMeanVals, "groupedMeanVals.txt", row.names=F, quote=F, sep="\t")
