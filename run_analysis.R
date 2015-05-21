#Peer Assessments /Getting and Cleaning Data Course Project 

# Step1. Merges the training and the test sets to create one data set.
setwd( "C:/Users/Eduardo/Documents/UCI HAR Dataset" )

#Load Train Data
trainData <- read.table("./train/X_train.txt")
trainLabel <- read.table("./train/y_train.txt")
trainSubject <- read.table("./train/subject_train.txt")

#Load Test Data
testData <- read.table("./test/X_test.txt")
testLabel <- read.table("./test/y_test.txt") 
testSubject <- read.table("./test/subject_test.txt")

#Join tables
joinData <- rbind( trainData, testData )
joinLabel <- rbind( trainLabel, testLabel )
joinSubject <- rbind( trainSubject, testSubject )


# Step2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table( "./features.txt" )
meanStdIndex <- grep( "mean\\(\\)|std\\(\\)", features[, 2 ] )
joinData <- joinData[, meanStdIndex ]

# remove "()"
names( joinData ) <- gsub( "\\(\\)", "", features[ meanStdIndex, 2 ] )
# toUpper M
names( joinData ) <- gsub( "mean", "Mean", names( joinData) )
# toUpper S
names( joinData ) <- gsub( "std", "Std", names( joinData) )
# remove "-" in column names 
names( joinData ) <- gsub( "-", "", names( joinData) )

# Step3. Uses descriptive activity names to name the activities in the data set

activity <- read.table( "./activity_labels.txt" )

activity[, 2 ] <- tolower( gsub("_", "", activity[ , 2 ] ) )

substr( activity[ 2, 2 ], 8, 8 ) <- toupper( substr( activity[ 2, 2 ], 8, 8 ) )

substr( activity[ 3, 2 ], 8, 8 ) <- toupper( substr( activity[ 3, 2 ], 8, 8 ) )

activityLabel <- activity[ joinLabel[ , 1 ], 2 ]

joinLabel[, 1 ] <- activityLabel

names( joinLabel ) <- "activity"

# Step4. Appropriately labels the data set with descriptive activity names.

names( joinSubject ) <- "subject"

cleanedData <- cbind( joinSubject, joinLabel, joinData )

setwd( "C:/Users/Eduardo/Documents/GitHub/Getting-and-Cleaning-Data-Course-Project" )

# write dataset number 1
write.table( cleanedData, "DS1_merged_data.txt" )

# Step5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

subjectLen <- length( table( joinSubject ) )

activityLen <- dim( activity )[ 1 ]

columnLen <- dim( cleanedData )[ 2 ]

result <- matrix( NA, nrow = subjectLen * activityLen, ncol = columnLen ) 

result <- as.data.frame( result )

colnames( result ) <- colnames( cleanedData )

row <- 1
for( i in 1:subjectLen )
{
    for( j in 1:activityLen )
    {
        
        result[ row, 1 ] <- sort( unique( joinSubject )[ , 1 ] )[ i ]
        
        result[ row, 2 ] <- activity[ j, 2 ]
        
        bool1 <- i == cleanedData$subject
        
        bool2 <- activity[ j, 2 ] == cleanedData$activity
        
        result[ row, 3:columnLen ] <- colMeans( cleanedData[ bool1 & bool2, 3:columnLen ] )
        
        row <- row + 1

    }
    
}

# write dataset number 2
write.table( result, "DS2_data_with_means.txt" )

