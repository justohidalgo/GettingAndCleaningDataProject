Coursera's Getting and Cleaning Data Final Project
===========
The following are the instructions to execute the project.

There is a run_analysis.R script that performs the following actions as requested in the instructions:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### How to execute the script
Just source run_analysis.R. The output should be similar to the following:


    Attaching package: 'dplyr'
    The following objects are masked from 'package:stats':

    filter, lag

    The following objects are masked from 'package:base':
    intersect, setdiff, setequal, union
    Loading required package: gsubfn
    Loading required package: proto
    Loading required package: RSQLite
    Loading required package: DBI
    Loading required package: RSQLite.extfuns
    Loading required package: tcltk
    There were 50 or more warnings (use warnings() to see the first 50)

### How it was done

1. Merges the training and the test sets to create one data set. 

I firstly followed the recommendations given at Coursera's forum thread, "David's project FAQ", https://class.coursera.org/getdata-007/forum/thread?thread_id=49 

Merging the test and training files requires three steps:

* Merging the three files in each "training" and "test" folders. The main one ("X_train" and "X_test" respectively) define the sets, each with 561 columns (the 561-feature vector described in the README file). 
* Then the "Y_ train/test" files describe the specific activity from which each observation was measured (walking, walking upstairs, etc.). I've added it as the 562nd column. 
* Finally, the "subject_test/train" files describe the subject who performed each observation. It's added as the 563rd column. 
     
To create the new columns, and as the X_train/test files had no headers, I used the [, <column_index] option that data frames provide to add new columns. 

Finally, I used rbind to generate a single dataset.

Though I didn't do it initially, then I realized I needed to create another data frame comprising the activity labels obtained from the activity_labels.txt file.



2. Extracts only the measurements on the mean and standard deviation for each measurement. 

As I saw it, this means getting the list of features at features.txt and obtaining only the columns (measurement) related to means and standard deviations. 

In order to do this, I used the sqldf library to execute like functions against the V2 column, keeping whichever cells numbers had a value with "mean" or "std" there as a vector (obtained from the factor retrieved previously). Then I "filter", keeping only the column numbers of this vector, plus the columns #562 and #563 that I added before, as I want to keep the activity and subject per observation.



3. Uses descriptive activity names to name the activities in the data set

I understand this is basically a join operation to transform the "activity codes" into full activity names: WALKING, WALKING_UP, etc.

That's why in step #1 I created a dataframe with the activity codes and labels from activity.txt.

For this I used the merge function that easily allowed me to show the activity description, as shown in the code book script. I then remove the activity code.

4. Appropriately labels the data set with descriptive variable names.

It was obvious after step #3 that step #4 was going to be required. All names are quite ugly! 
I needed to remember how to add column names to data frames, but once I found out it was by using the colnames function, it was easy, using the feature_metadata_filter data frame to obtain the vector of names plus the activity and subject headers.

I used the Naming conventions of variable names as explained in the course.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The clue here to me was that we needed to create a tidy data set. Based on what was shown at the swirl courses, this meant that aggregate was the function to use, where the "average" (or mean) the action to execute. 

I only realized after reading the coursera forum that I needed to get rid of the latest two columns, subject and activity, as the mean of those make no sense.

Based on the paper from Hadley Wickham, this is a tidy data because:

* Each variable forms a column (the average for each of the variables per activity and subject)
* Each observation forms a row. 
* Each type of observational unit forms a table.

I checked that the five most typical mistakes have not happened:

- Mistake 1. Column headers are values, not variable names
- Mistake 2. Multiple variables are stored in one column
- Mistake 3. Variables are stored in both rows and columns
- Mistake 4. Multiple types of observational units are stored in the same table
- Mistake 5. A single observational unit is stored in multiple tables


In order to upload the tidy table, I used the write.table as requested. I checked the importing this file generated the same table. 

