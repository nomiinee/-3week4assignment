# Codeblock

Codebook explains the different variables used in script and data cleaning
also the function being used in the script
  - Flow
  - Important variables 
  - filename
  - functions
### Flow
This script does the following.
1. Merges the training and the test sets to create one data set.
2. Appropriately labels the data set with descriptive variable names.
3. Uses descriptive activity names to name the activities in the data set
4. Extracts only the measurements on the mean and standard deviation for each measurement.
5. From the data set in step 4, creates a second, independent tidy data set with  the average of each variable for each activity and each subject.

### Filename
X_train : training data
X_test : test data
y_train : activity number of train data related to activity_labels
y_test : activity number of test data related to activity_labels
subject_train : subject numbers of train observations
subject_test : subject numbers of test observations
activity_labels : file contaning activity labels in text corresponding to y_test and y_train
features : file containing features name
For example,
```sh
> read_xtest<-read.csv("X_test.txt")
> read_ytest<-read.csv("y_test.txt")
> subjectTest<-read.csv("subject_test.txt")
```
### Improtant variables
Describe the variables storing each given dataset 
xtest : Store test dataset read from "X_test" file
xtrain : Store test dataset read from "X_train" file 
read_ytest : Store activity number of test data read from "y_test" file
read_ytrain : Store activity number of train data read from "y_train" file
subjectTrain : Store train subject dataset read from "subject_train" file
subjectTest : Store test subject dataset read from "subject_test" file
read_varNames Store variable names read from from "feature" file
For example,
```sh
> read_xtest<-read.csv("X_test.txt")
> read_ytest<-read.csv("y_test.txt")
> subjectTest<-read.csv("subject_test.txt")
> read_xtrain<-read.csv("X_train.txt")
> read_ytrain<-read.csv("y_train.txt")
> subjectTrain<-read.csv("subject_train.txt")
```


### Function
Function summarizing  tidy data set with the average of each variable for each activity and each subject
```
> summarize_mean <- function(subject, labe, input)
{
  a<-input[input$subject == subject,]
  a<-a[a$activity_labe == labe,]
  result<-lapply(a[-c(2)], mean )
  result<-data.frame(result)
  result<-cbind(labe, result)
  colnames(result)[1]="activity_label"
  result
}
```





