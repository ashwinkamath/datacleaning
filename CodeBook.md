Cleaning Dataset : Human Activity Recognition Using Smartphones Dataset
==================================================================

Author: Ashwin Kamath
Purpose : Assignment submitted for Coursera- Cleaning data, Assignment #2


###**** Input Data files **** 

1. 'features.txt': List of all features.
2. 'activity_labels.txt': Links the class labels with their activity name.
3. 'train/X_train.txt': Training set.
4. 'train/y_train.txt': Training labels.
5. 'test/X_test.txt': Test set.
6. 'test/y_test.txt': Test labels.



###**** Output file **** 

1. tidy_data.csv


###**** R file **** 

1. run_analysis.R


### Steps

In Summary, the R file performs the following steps -

1. Read Train & Test data readings.
    data frames : train.set and test.set

2. Make the features more description using those specified in features.txt 
    data frame : cols

3. For each of those sets, read the activity & subject data and merge with the respective data sets
    data frames: train.activity, test.activity, train.subjects, test.subjects

4. Merge test & train data to create all.set
    data frame : all.set

5. Select only those features containing "mean" and "std" (standard deviation) as measurements
    data frame: work.set

6. Add activity labels to the data set - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
    data frame: work.set

7. Create mean aggregate of all measurements for every subject and activity
    data frame: final.data

8. Write the output data frame to tidy_data.csv
    cdv file : tidy_data
