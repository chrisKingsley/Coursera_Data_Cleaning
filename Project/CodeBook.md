#Data Codebook

##Data from UCI HAR Dataset
A series of variables measured from cellphone accelerometers were curated in the original UCI HAR dataset.  These variables are described in the file "UCI HAR Dataset/features_info.txt" in the original data folder (available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), and will not be further described here.

The means/sd's of the following variables were selected for analysis:
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

##Analysis Results
The follwing variables were generated in the tidy data set in the file groupedMeanVals.txt produced by the R script run_analysis.R:
* subjectId - The identification number of the subject whose movements were measured
* activity - The type of activity the individual was engaged in while being measured (possible values: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)
* variable - The variable that was measured (from the list above)
* meanValue - The mean of the values of the variable type, for the specified subject engaged in the specified activity in that row.

