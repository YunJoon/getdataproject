##run_analysis.R

###############Step 0 : Reading tables from data##############################
##  Test Folder
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="Subject_ID", header=FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="Activity", header=FALSE)

##  Train Folder
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="Subject_ID", header=FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="Activity", header=FALSE)

##  Labels
Activity_Label <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
Features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)[,2]

###############Step 1 : Merging All Data into FullSet##############################
#Bind columns in the order of "Subject_ID", "Activity", Actual Data
TestSet = cbind(subject_test, y_test, X_test)
TrainSet = cbind(subject_train, y_train, X_train)

#Bind rows the two data sets
FullSet = rbind(TestSet, TrainSet)

#Remove no longer needed data from global environment to avoid confusion
remove(subject_test); remove(y_test); remove(X_test); remove(TestSet)
remove(subject_train); remove(y_train); remove(X_train); remove(TrainSet)

###############Step 2 : Extracts only the measurements on the mean&stv##############################
#Get the column index where the data description includes the word "mean" or "std"
Index <- grep("mean|std", Features)

#Using the index we got, retrieve the data from full set.
#Index 1 is Subject_ID
#Index 2 is Activity
#Index+2 because the actual data starts from 3rd column and Index was assumed that 1st column is where the actual data started.
TempSet <- FullSet[,c(1,2,Index+2)]

###############Step 3 : Replacing numbered activity with descriptive character.
#Create a map that connects the numbered activity with descriptive string.
map <- setNames(Activity_Label$V2, Activity_Label$V1)

#Remove no longer needed data from global environment to avoid confusion
remove(Activity_Label)

#For every value in "Activity" column,
#(3-1) change the atomic type of the column into character
#(3-2) change the numbered value into charactered, descriptive value.

#e.g.

#     |Subject_ID  Activity  ...
#==================================
#   1 |         2         5
# ... |       ...       ...  ...

#is converted into

#     |Subject_ID  Activity  ...
#==================================
#   1 |         2  STANDING
# ... |       ...       ...  ...
TempSet$Activity <- sapply(TempSet$Activity, as.character)
for(i in seq(TempSet$Activity))
    TempSet[i,"Activity"] <- as.character(map[TempSet[i, "Activity"]])

#Remove no longer needed data from global environment to avoid confusion
remove(map)

###############Step 4 : Adding Column Names
#Change the type of "Features" into character vector
Features <- sapply(Features, as.character)

#Using colnames() function, add column names for more descriptive data.
#Remember first two columns are added manually(i.e. "TestSet = cbind(subject_test, y_test, X_test)")
colnames(TempSet) <- c("Subject_ID", "Activity", Features[Index])

###############Step 5 : Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#####Tidy data gathered using "Activity"
#Create an empty data.frame of dimension (6,80) with "Activity" as row names
ByActivity = data.frame(matrix(nrow=6, ncol=80), row.names=names(table(TempSet$Activity)))

#Add the column name
colnames(ByActivity) <- c("Activity", Features[Index])

#For each row(i.e. activity), 
for(i in 1:6)
    #Fill up the data by "Activity Name" and mean of each feature that corresponds to each activity.
    ByActivity[i,] <- c(names(table(TempSet$Activity))[i], colMeans(TempSet[TempSet$Activity==names(table(TempSet$Activity))[i], 3:length(TempSet)]))

#Remove no longer needed data from global environment to avoid confusion
remove(i)

#Write it out in a .txt file
write.table(ByActivity, file="./ByActivity.txt", row.names=FALSE)

#####Tidy data gathered using "Subject_ID"
#Create an empty data.frame of dimension (6,80)
BySubject = data.frame(matrix(nrow=30, ncol=80))

#Add the column name
colnames(BySubject) <- c("Subject_ID", Features[Index])

#For each row(i.e. subject), 
for(i in 1:30)
    #Fill up the data by "Subject Number" and mean of each feature that corresponds to each subject.
    BySubject[i,] <- c(i, colMeans(TempSet[TempSet$Subject_ID==i, 3:length(TempSet)]))

#Write it out in a .txt file
write.table(BySubject, file="./BySubject.txt", row.names=FALSE)

##########END