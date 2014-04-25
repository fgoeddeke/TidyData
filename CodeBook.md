# CodeBook.md for run_analysis.R project

Original data is from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Explanation of original dataset is from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The attached run_analysis.R file tidies up the data:

1)  Merges the training and the test datasets into "test5" dataframe

2)  Extracts only the measurements on the mean and standard deviation for each measurement into "selected6" dataframe

3)  Uses descriptive activity names instead of numbers for data in the acitivty variable, in the "selected6" dataframe

4)  Outputs the "selected6" dataframe as a text file "tidydata1"

5)  Cleans up the variable names

6)  Takes the mean of each participant * activity combination and outputs "tidydata2.txt" file (180 rows * 69 columns)

