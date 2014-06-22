#####################################################################
# 1) Merges the training and the test sets to create one data set.  #
#####################################################################
# 1.01 Reading training set
train.set <- read.table("UCI HAR Dataset/train/X_train.txt", 
               sep="", 
               fill=FALSE, 
               strip.white=TRUE)

# 1.02 Reading feature names
cols <- read.table("UCI HAR Dataset/features.txt", 
                        sep="", 
                        fill=FALSE, 
                        strip.white=TRUE)

# 1.03 Renaming columns as specified in 2nd column of features.txt
colnames(train.set) <- cols$V2

# 1.04 Reading subjects for training set
train.subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                                 sep="", 
                                 fill=FALSE, 
                                 strip.white=TRUE)

# 1.05 Reading activities for training set
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt", 
                             sep="", 
                             fill=FALSE, 
                             strip.white=TRUE)

# 1.06 Merging subjects & activities into train.set
train.set <- cbind(train.set,train.subjects)
names(train.set)[562] <- "subject"

train.set <- cbind(train.set,train.activity)
names(train.set)[563] <- "activity"

# 1.07 Inspecting training set
nrow(train.set)
colnames(train.set)
any(is.na(train.set)) 

# 1.08 Reading test data set
test.set = read.table("UCI HAR Dataset/test/X_test.txt", 
                       sep="", 
                       fill=FALSE, 
                       strip.white=TRUE)

# 1.09 Renaming columns as specified in 2nd column of features.txt
colnames(test.set) <- cols$V2

# 1.10 Reading subjects for test set
test.subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                                 sep="", 
                                 fill=FALSE, 
                                 strip.white=TRUE)

# 1.11 Reading activities for test set
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt", 
                             sep="", 
                             fill=FALSE, 
                             strip.white=TRUE)

# 1.12 Merging subjects & activities into test.set
test.set <- cbind(test.set,test.subjects)
names(test.set)[562] <- "subject"

test.set <- cbind(test.set,test.activity)
names(test.set)[563] <- "activity"

# 1.13 Inspecting test set
nrow(test.set)
colnames(test.set)
any(is.na(test.set)) 

# 1.14 Merge train.set & test.set into all.set

if (ncol(train.set) == ncol(test.set))
{
all.set <- rbind(train.set,test.set)
}


################################################################################################
# 2) Extracts only the measurements on the mean and standard deviation for each measurement..  #
################################################################################################

# 2.01 Vector with all column indices containing "mean"
  mean.cols <- grep("mean",colnames(all.set))

# 2.02 Vector with all column indices containing "std"
std.cols <- grep("std",colnames(all.set))

# 2.03 Vector with all mean and std columm indices
  measure.cols <- union(mean.cols, std.cols) ## means & std. dev

# 2.04 Vector with dimension column incides - subject & activity
  dim.cols <- which(colnames(all.set)=="subject"|colnames(all.set)=="activity")

# 2.05 Dataframe with all columns of interest - measures & dimensions
  work.set <- all.set[,union(measure.cols,dim.cols)]

################################################################################################
# 3) Uses descriptive activity names to name the activities in the data set                    #
################################################################################################
  
# 3.01 Reading activity labels
 activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                                   sep="", 
                                   fill=FALSE, 
                                   strip.white=TRUE)

# 3.02 Renaming columns of dataframe
  colnames(activity.labels) <- c("activity","activity.label")

# 3.03 Lookup activity name and merge with working data set
  work.set <- merge(work.set,activity.labels,by="activity")

# 3.04 Inspect work set
  head(work.set)

################################################################################################
# 4) Appropriately labels the data set with descriptive variable names.                        #
################################################################################################
colnames(work.set)
# the column names have been derived from feature.txt to make them descriptive

########################################################################################################################
# 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject  #                        #
########################################################################################################################
 
# 5.01 Take mean of all measure columns by subject & activity
    final.data <- aggregate(work.set[,2:80], by = work.set[c("subject","activity.label","activity")], FUN=mean,na.rm =T)
    head(final.data)
    
    write.csv(final.data, file="tidy_data.csv")
