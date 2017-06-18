---
title: "CodeBook.md"
author: "Christopher Yarnell"
date: '2017-06-17'
output: html_document
---

CodeBook for Final Project of Getting and Cleaning Data Course

1. Merge the test and training data.
        1a. Download the data. This involves downloading and then unzipping the data.
        1b. Load the test and training data. Requires loading in three files each for           test and training data (6 total data frames). 
        1c. Merge datasets. Requires binding each triplet of test and training files by         column and then binding test and training data by row.

I interpret the specification that this program runs "as long as the Samsung data is in the working directory" to mean that the working directory is at the level of the downloaded zipped file which is then unzipped by my program.

2. Extract only the measurements on the mean and standard deviation for each measurement.

        For this we need to select all the measurements that end in "- mean()" and "- std()"; we will ignore measurements that incorporate "mean" elsewhere in the name. To do so we use grep() with literal regular expressions.
        Then we use those vectors as column indices to isolate the needed columns.

        We will also reorder the dataset at this point to place subjects as the first column and activity as the second column.

3. Relabel the dataset with descriptive activity names as follows: walking, walking_upstairs, walking_downstairs, sitting, standing, laying. We will use 1 = walking, 2 = walking_upstairs, 3 = walking_downstairs, 4 = sitting, 5 = standing, 6 = laying.

4. Relabel the dataset with appropriate variable names. All short forms have been expanded into entire words, and the data is time-varying unless specified as frequency-varying by the modifier "frequency". Underscores serve as spaces. The legend is below:

      original_names                new_names                                                 
 [1,] "Subject"                     "Subject"                                                 
 [2,] "Activity"                    "Activity"                                                
 [3,] "tBodyAcc-mean()-X"           "acceleration_mean-X"                                     
 [4,] "tBodyAcc-mean()-Y"           "acceleration_mean-Y"                                     
 [5,] "tBodyAcc-mean()-Z"           "acceleration_mean-Z"                                     
 [6,] "tGravityAcc-mean()-X"        "Gravityacceleration_mean-X"                              
 [7,] "tGravityAcc-mean()-Y"        "Gravityacceleration_mean-Y"                              
 [8,] "tGravityAcc-mean()-Z"        "Gravityacceleration_mean-Z"                              
 [9,] "tBodyAccJerk-mean()-X"       "acceleration_jerk_mean-X"                                
[10,] "tBodyAccJerk-mean()-Y"       "acceleration_jerk_mean-Y"                                
[11,] "tBodyAccJerk-mean()-Z"       "acceleration_jerk_mean-Z"                                
[12,] "tBodyGyro-mean()-X"          "rotational_mean-X"                                       
[13,] "tBodyGyro-mean()-Y"          "rotational_mean-Y"                                       
[14,] "tBodyGyro-mean()-Z"          "rotational_mean-Z"                                       
[15,] "tBodyGyroJerk-mean()-X"      "rotational_jerk_mean-X"                                  
[16,] "tBodyGyroJerk-mean()-Y"      "rotational_jerk_mean-Y"                                  
[17,] "tBodyGyroJerk-mean()-Z"      "rotational_jerk_mean-Z"                                  
[18,] "tBodyAccMag-mean()"          "acceleration_magnitude_mean"                             
[19,] "tGravityAccMag-mean()"       "Gravityacceleration_magnitude_mean"                      
[20,] "tBodyAccJerkMag-mean()"      "acceleration_jerk_magnitude_mean"                        
[21,] "tBodyGyroMag-mean()"         "rotational_magnitude_mean"                               
[22,] "tBodyGyroJerkMag-mean()"     "rotational_jerk_magnitude_mean"                          
[23,] "fBodyAcc-mean()-X"           "frequency_acceleration_mean-X"                           
[24,] "fBodyAcc-mean()-Y"           "frequency_acceleration_mean-Y"                           
[25,] "fBodyAcc-mean()-Z"           "frequency_acceleration_mean-Z"                           
[26,] "fBodyAccJerk-mean()-X"       "frequency_acceleration_jerk_mean-X"                      
[27,] "fBodyAccJerk-mean()-Y"       "frequency_acceleration_jerk_mean-Y"                      
[28,] "fBodyAccJerk-mean()-Z"       "frequency_acceleration_jerk_mean-Z"                      
[29,] "fBodyGyro-mean()-X"          "frequency_rotational_mean-X"                             
[30,] "fBodyGyro-mean()-Y"          "frequency_rotational_mean-Y"                             
[31,] "fBodyGyro-mean()-Z"          "frequency_rotational_mean-Z"                             
[32,] "fBodyAccMag-mean()"          "frequency_acceleration_magnitude_mean"                   
[33,] "fBodyBodyAccJerkMag-mean()"  "frequency_acceleration_jerk_magnitude_mean"              
[34,] "fBodyBodyGyroMag-mean()"     "frequency_rotational_magnitude_mean"                     
[35,] "fBodyBodyGyroJerkMag-mean()" "frequency_rotational_jerk_magnitude_mean"                
[36,] "tBodyAcc-std()-X"            "acceleration_standard_deviation-X"                       
[37,] "tBodyAcc-std()-Y"            "acceleration_standard_deviation-Y"                       
[38,] "tBodyAcc-std()-Z"            "acceleration_standard_deviation-Z"                       
[39,] "tGravityAcc-std()-X"         "Gravityacceleration_standard_deviation-X"                
[40,] "tGravityAcc-std()-Y"         "Gravityacceleration_standard_deviation-Y"                
[41,] "tGravityAcc-std()-Z"         "Gravityacceleration_standard_deviation-Z"                
[42,] "tBodyAccJerk-std()-X"        "acceleration_jerk_standard_deviation-X"                  
[43,] "tBodyAccJerk-std()-Y"        "acceleration_jerk_standard_deviation-Y"                  
[44,] "tBodyAccJerk-std()-Z"        "acceleration_jerk_standard_deviation-Z"                  
[45,] "tBodyGyro-std()-X"           "rotational_standard_deviation-X"                         
[46,] "tBodyGyro-std()-Y"           "rotational_standard_deviation-Y"                         
[47,] "tBodyGyro-std()-Z"           "rotational_standard_deviation-Z"                         
[48,] "tBodyGyroJerk-std()-X"       "rotational_jerk_standard_deviation-X"                    
[49,] "tBodyGyroJerk-std()-Y"       "rotational_jerk_standard_deviation-Y"                    
[50,] "tBodyGyroJerk-std()-Z"       "rotational_jerk_standard_deviation-Z"                    
[51,] "tBodyAccMag-std()"           "acceleration_magnitude_standard_deviation"               
[52,] "tGravityAccMag-std()"        "Gravityacceleration_magnitude_standard_deviation"        
[53,] "tBodyAccJerkMag-std()"       "acceleration_jerk_magnitude_standard_deviation"          
[54,] "tBodyGyroMag-std()"          "rotational_magnitude_standard_deviation"                 
[55,] "tBodyGyroJerkMag-std()"      "rotational_jerk_magnitude_standard_deviation"            
[56,] "fBodyAcc-std()-X"            "frequency_acceleration_standard_deviation-X"             
[57,] "fBodyAcc-std()-Y"            "frequency_acceleration_standard_deviation-Y"             
[58,] "fBodyAcc-std()-Z"            "frequency_acceleration_standard_deviation-Z"             
[59,] "fBodyAccJerk-std()-X"        "frequency_acceleration_jerk_standard_deviation-X"        
[60,] "fBodyAccJerk-std()-Y"        "frequency_acceleration_jerk_standard_deviation-Y"        
[61,] "fBodyAccJerk-std()-Z"        "frequency_acceleration_jerk_standard_deviation-Z"        
[62,] "fBodyGyro-std()-X"           "frequency_rotational_standard_deviation-X"               
[63,] "fBodyGyro-std()-Y"           "frequency_rotational_standard_deviation-Y"               
[64,] "fBodyGyro-std()-Z"           "frequency_rotational_standard_deviation-Z"               
[65,] "fBodyAccMag-std()"           "frequency_acceleration_magnitude_standard_deviation"     
[66,] "fBodyBodyAccJerkMag-std()"   "frequency_acceleration_jerk_magnitude_standard_deviation"
[67,] "fBodyBodyGyroMag-std()"      "frequency_rotational_magnitude_standard_deviation"       
[68,] "fBodyBodyGyroJerkMag-std()"  "frequency_rotational_jerk_magnitude_standard_deviation" 

5. Create a second tidy dataset with the average of each variable for each variable and each subject.

To do this, I used the group_by function grouping by activity then subject. I then used summarise_each to run the mean function on all columns (variables). The output is a 180 by 68 size data frame with each row as an observation of an activity done by a subject (6 activities x 30 subjects = 180) and each column is a variable, starting with Activity and Subject. 

To read in the data, use: data <- read.table("UCI HAR Dataset Averages-by-Subject.txt", header = TRUE)