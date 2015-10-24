#Coursera Data Cleaning Class Project

##Synopsis
This analysis was performed on data collected from accelerometers from a Samsung Galaxy S smartphone.  The data was filtered for mean/sd's of measured values in invididuals undergoing
different activities.  A summary table was produced that examined the mean of the mean/sd values over each combination of individual and activity type.

##Data Processing
The R script run_analysis.R was used for all the steps in the analysis.  The data for the analysis was from the "UCI HAR Dataset" directory (not included in this repository) downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The training and test sets were both loaded from their respective sub-directories, and the variables (columns) were selected for those variables that represented means/sds of measured values.  I did not include variables obtained by averaging the signals in a signal window sample (e.g. gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, & tBodyGyroJerkMean).  Variables that were selected are described in the codebook in this repository.

The samples (rows) were annotated with sample ID numbers from the 'subject_XXX.txt' files of the training and test directories.

The activity codes were replaced by the names of the activites from the activity_labels.txt file.

The training/test sets were merged, and dplyr was used to provide means of the measured values (means and sd's) for each individual and activity type.  This table (in tidy format) was saved in the file groupedMeanVals.txt and uploaded to the Coursera site (though not included in this repository).
