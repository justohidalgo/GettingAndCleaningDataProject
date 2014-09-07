Coursera's Getting and Cleaning Data Final Project CodeBook
===========

Raw Data
-----------
The dataset comes from Human Activity Recognition Using Smartphones Data Set, and can be accessed at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The README.txt file explains where the data comes from, so I will not replicate it here except for a brief summary:

- Data description: http://archive.ics.uci.edu/ml/datasets/Human+Activity
+Recognition+Using+Smartphones

- Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
- Explanation:
    - 30 volunteers, 19-48yo
    - Six possible activities: 
        - WALKING,
        - WALKING_UPSTAIRS,
        - WALKING_DOWNSTAIRS,
        - SITTING,
        - STANDING,
        - LAYING
    - How: 3-axial linear acceleration, 3-axial angular velocity at a constant rate of 50Hz
    - Dataset randomly partitioned so 70% is for training, 30% for test
    - Attribute info:
        - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
        - Triaxial Angular velocity from the gyroscope. 
        - A 561-feature vector with time and frequency domain variables. 
        - Its activity label. 
        - An identifier of the subject who carried out the experiment.

Pre-processed dataset
-----------
A pre-processed dataset (steps 1-4 of the project requirements) is obtained by merging the training and test sets and filtering out the expected features (measurements on mean and standard deviation). 

After processing, the final dataset has 10,299 observations and 88 columns (86 + activity and subject per observation).

As per naming conventions for variable names, the following have been observed:
- All lower case when possible
- Descriptive when possible
- Not duplicated
- Not to have underscores or dots or whitespaces

Tidy dataset
-----------
The tidy dataset is an aggregation of the pre-processed dataset by processing the average (mean) on the activity and subject for each of the parameters of the dataset.

This aggregation generates 180 rows and 88 columns. 


