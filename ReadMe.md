# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info
3. Load both the training and test datasets and their respective activity and subject data 
4. Merges the two datasets
5. Filter the columns which reflect a mean or standard deviation
6. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `tidy.txt`.