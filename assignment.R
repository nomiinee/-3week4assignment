# This script does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.
#Loading needed files 
setwd("C:/Users/Jirawech/Documents/#3assignment/test")
read_xtest<-read.csv("X_test.txt")
read_ytest<-read.csv("y_test.txt")
subjectTest<-read.csv("subject_test.txt")
setwd("C:/Users/Jirawech/Documents/#3assignment/train")
read_xtrain<-read.csv("X_train.txt")
read_ytrain<-read.csv("y_train.txt")
subjectTrain<-read.csv("subject_train.txt")
setwd("C:/Users/Jirawech/Documents/#3assignment")
read_varNames<-read.csv("features.txt", sep=" ", header=FALSE)
label<-read.csv("activity_labels.txt", sep=" ", header=FALSE)
varNames<-character()
#Parsing the variabale names from features
for (i in 1: nrow(read_varNames))
  
{
  temp<-gsub("[0-9]*[\\,]+[0-9]*$","", read_varNames[i,2])
  temp<-gsub("[\\-]|[0-9]$","", temp)
  varNames<-c(varNames,  temp)
}
varNames<-sub("t","Time",varNames)
varNames<-sub("f","Freq",varNames)

startTest<-matrix(nrow = 1, ncol = 561)
startTrain<-matrix(nrow = 1, ncol = 561)
#Getting the X_test dataset from "X_test.txt"
for (i in 1:length(read_ytest[[1]]))
{
  
  a<-unlist(strsplit(as.character(read_xtest[i,]), split=" "))
  a<-a[a!=""]
  a<-as.numeric(a)
  startTest<-rbind(a,startTest)

}
#Getting the X_train dataset from "X_train.txt"
for (i in 1:length(read_ytrain[[1]]))
{
  
  
  b<-unlist(strsplit(as.character(read_xtrain[i,]), split=" "))
  b<-b[b!=""]
  b<-as.numeric(b)
  startTrain<-rbind(b,startTrain)
}
#Label train and test dataset with variable names
startTest<-startTest[2:2947,]
rownames(startTest)<-c(1:2946)
xtest<-data.frame(startTest)
colnames(xtest)<-varNames
startTrain<-startTrain[2:7352,]
rownames(startTrain)<-c(1:7351)
xtrain<-data.frame(startTrain)
colnames(xtrain)<-varNames
#Assign activity_labels to y_test 
for (i in 1:length(read_ytest[[1]]))
{
  readY<-read_ytest[[1]][i]
  if (readY==1){
    read_ytest[[1]][i]=as.character(label[1,2])
  }else if (readY==2){
    read_ytest[[1]][i]=as.character(label[2,2])
  }else if (readY==3){
    read_ytest[[1]][i]=as.character(label[3,2])
  }else if (readY==4){
    read_ytest[[1]][i]=as.character(label[4,2])
  }else if (readY==5){
    read_ytest[[1]][i]=as.character(label[5,2])
  }else if (readY==6){
    read_ytest[[1]][i]=as.character(label[6,2])
  }
} 
#Assign activity_labels to  y_trai dataset
for (i in 1:length(read_ytrain[[1]]))
{
  
  readyt<-read_ytrain[[1]][i]
  if (readyt==1){
    read_ytrain[[1]][i]=as.character(label[1,2])
  }else if (readyt==2){
    read_ytrain[[1]][i]=as.character(label[2,2])
  }else if (readyt==3){
    read_ytrain[[1]][i]=as.character(label[3,2])
  }else if (readyt==4){
    read_ytrain[[1]][i]=as.character(label[4,2])
  }else if (readyt==5){
    read_ytrain[[1]][i]=as.character(label[5,2])
  }else if (readyt==6){
    read_ytrain[[1]][i]=as.character(label[6,2])
  }
} 
#Rearrange column names and combine two datasets, train and test
xfinal<-cbind( read_ytest, xtest )
colnames(xfinal)[1]="activity_label"
xfinal<-cbind( subjectTest, xfinal )
colnames(xfinal)[1]="subject"
xfinalTrain<-cbind( read_ytrain, xtrain )
colnames(xfinalTrain)[1]="activity_label"
xfinalTrain<-cbind( subjectTrain, xfinalTrain )
colnames(xfinalTrain)[1]="subject"
last<-rbind(xfinal,xfinalTrain)
last<-last[order(last$subject),]
f<-grep("activity|sub|[Mm]ean|[sS]td",colnames(last), value=TRUE)
finalTable<-last[f]
#function summarizing  tidy data set with the average of each... 
#variable for each activity and each subject.
summarize_mean <- function(subject, labe, input)
{
  a<-input[input$subject == subject,]
  a<-a[a$activity_labe == labe,]
  result<-lapply(a[-c(2)], mean )
  result<-data.frame(result)
  #class(result)
  result<-cbind(labe, result)
  colnames(result)[1]="activity_label"
  result
  
}
#Apply summarize_mean to tidy data set with the average of each... 
#variable for each activity and each subject.
table<-matrix(nrow = 1, ncol = 75)
for (i in 1:30){
  for (j in 1:6){
    keep<-summarize_mean(i, labe= label[j,2], finalTable )
    keep<-as.matrix(keep)
    class(keep)
    table<-rbind(table, keep)
  }
  
}
#Write result 
table<-table[2:nrow(table),]
write.table(table, file= "Assignment", row.names = FALSE)


