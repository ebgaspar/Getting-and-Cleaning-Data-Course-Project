This file describes how run_analysis.R script works.

1. First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to create the directory `./UCI HAR Dataset`.

2. Set the current working directory to the folder where the `run_analysis.R` is located.

###### Note: It's necessary to edit the script to alter the path to the datasets, since the script originates from a diferent workstation, it will probably be wrong.

3. Open the `run_analysis.R` in RStudio and click on the source button t load and run the script. Or, just type source("run_analysis.R") command in RStudio's console.

4. After the previous step it will be created the two output files, `DS1_merged_data.txt` and `DS2_data_with_means.txt`.
  - DS1_merged_data.txt: A file that contains the edit dataset, descriptive activity names and descriptive variable names.
  - DS2_data_with_means.txt: A file that contains independent tidy data set with the average of each variable for each activity and each subject.

###### Note: It's necessary to edit the script to alter the destiantion path to the result files, since the script originates from a diferent workstation, it will probably be wrong.

