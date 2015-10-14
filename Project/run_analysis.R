# This script contains the R code necessary to complete the course project
# for Getting and Cleaning Data


# load activity table
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header=F,
                             stringsAsFactors=F)
colnames(activityLabels) <- c("code","label")


# load subject and variable names
features <- read.table("UCI HAR Dataset/features.txt", header=F, stringsAsFactors=F)[[2]]
features <- gsub("\\(|\\)", "", features)


# function for loading test/train data into data frame
loadDataFile <- function(setType, features, activityLabels) {
    # load data file and add column names
    dataFile <- sprintf("UCI HAR Dataset/%s/X_%s.txt", setType, setType)
    data <- read.table(dataFile, header=F, stringsAsFactors=F)
    feature.idx <- grep("mean|std", features, ignore.case=T)
    data <- data[, feature.idx]
    colnames(data) <- features[feature.idx]
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


# load training/test sets and merge
trainingSet <- loadDataFile("train", features, activityLabels)
testSet <- loadDataFile("test", features, activityLabels)
mergedData <- rbind(trainingSet, testSet)


