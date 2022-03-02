library(dplyr)
trainingsetdata<-read.table("C:/Users/Dattu/Documents/R-Stuff/Course Info & Work/Course 3/Course 3 - Week 4/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",header=F,colClasses =rep("numeric",561))
testsetdata<-read.table("C:/Users/Dattu/Documents/R-Stuff/Course Info & Work/Course 3/Course 3 - Week 4/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",header=F,colClasses =rep("numeric",561))
traininglabeldata<-read.table("C:/Users/Dattu/Documents/R-Stuff/Course Info & Work/Course 3/Course 3 - Week 4/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt",header=F)
testlabeldata<-read.table("C:/Users/Dattu/Documents/R-Stuff/Course Info & Work/Course 3/Course 3 - Week 4/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",header=F)
subjecttraindata<-read.table("C:/Users/Dattu/Documents/R-Stuff/Course Info & Work/Course 3/Course 3 - Week 4/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",header=F)
subjecttestdata<-read.table("C:/Users/Dattu/Documents/R-Stuff/Course Info & Work/Course 3/Course 3 - Week 4/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",header=F)
totaltraindata<-cbind(subjecttraindata,traininglabeldata,trainingsetdata)
totaltestdata<-cbind(subjecttestdata,testlabeldata,testsetdata)
featuresdata<-read.table("C:/Users/Dattu/Documents/R-Stuff/Course Info & Work/Course 3/Course 3 - Week 4/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt",header=F)
#step1-Below command merge test and training data sets
totaldata<-rbind(totaltraindata,totaltestdata)
names(totaldata)<-c("subjectid","activityid",featuresdata$V2)
mean_std_features<-grep("[mM]ean\\(\\)|[Ss]td\\(\\)",names(totaldata))
#Step2-Below command Extracts the mean and std measures
extractdataset<-totaldata[,c(1,2,mean_std_features)]#Step2
activitydata<-read.table("C:/Users/Dattu/Documents/R-Stuff/Course Info & Work/Course 3/Course 3 - Week 4/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",header=F)
extractjoindataset<-merge(extractdataset,activitydata,by.x="activityid",by.y="V1")
finaldataset<-extractjoindataset[,2:ncol(extractjoindataset)]
#Step3 - Having activity description in data
finaldataset<-finaldataset[,c(1,ncol(finaldataset),2:(ncol(finaldataset)-1))]
#Step4 - Having descriptive variable names in data
names(finaldataset)[2]="activity"
names(finaldataset)=gsub("\\(\\)","",names(finaldataset))
names(finaldataset)=gsub("\\-","",names(finaldataset))
#step5-create tidydataset
grpfinaldataset<-group_by(finaldataset,activity,subjectid)
tidydataset<-summarise(grpfinaldataset,across(everything(),mean))
write.table(tidydataset,"C:/Users/Dattu/Documents/R-Stuff/Course Info & Work/Course 3/Course 3 - Week 4/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/tidydataset.txt",row.names=FALSE)
#

