# CodeBook

## Original Data Set Information: 
(from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

> ###Data Set Information:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

> Check the README.txt file for further details about this dataset.


> ###Attribute Information:

> For each record in the dataset it is provided: 
> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
> - Triaxial Angular velocity from the gyroscope. 
> - A 561-feature vector with time and frequency domain variables. 
> - Its activity label. 
> - An identifier of the subject who carried out the experiment.

Original Project Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## New Data Set Information:

### Variables
The original features names were used as column headers for the resulting data set. Their order was kept.

Two new variables were added, "subject" and "activity":
- Subjects are identified by their name
- Activities are identified by a comprehensive name

### Data
The resulting data is made available in the form of a txt file ("tidy_data_set.txt" where each line is a record, excluding the first, which has the variables as header names.

Each record contains the number of the subject, the activity it was carrying out when the measurement was made and the average of the different measurements mean and standard deviation.

It can be directly imported to R via the read.table function as a data.frame, ready for analysis.

### Transformation
The first tranformation was the merging of the training and test sets, as well as the association of the subject and activity to each record.

The resulting data was obtained by filtering the existing values in order to only keep the records regarding mean and standard deviation calculations.

Resulting Data: https://github.com/ct7ahx/GCD/blob/master/tidy_data_set.txt
