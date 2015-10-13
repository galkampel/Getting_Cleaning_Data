
features <- read.table("getting_cleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")


activity_label <-read.table("getting_cleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt") 

train <- read.table("getting_cleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
names(train) <- features$V2

test <- read.table("getting_cleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
names(test) <- features$V2

y_train <- read.table("getting_cleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
names(y_train) <- "Activity"


y_train <- transform(y_train,Activity=factor(Activity,labels = activity_label$V2))
table(y_train)


y_test <- read.table("getting_cleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
names(y_test) <- "Activity"

y_test <- transform(y_test,Activity=factor(Activity,labels = activity_label$V2))


subject_train <- read.table("getting_cleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- "Subject"

subject_test <-read.table("getting_cleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "Subject"

train <- cbind(train,subject_train,y_train)
test <- cbind(test,subject_test,y_test)


all_data <- rbind(train,test)

rel_col <- (c(grep(".*[Mm]ean|std",names(all_data)),length(names(all_data))-1,length(names(all_data))))
rel_col

rel_data <- all_data[,rel_col]

# ddply(rel_data,)
# ?ddply
# write.csv(rel_data,file="getting_cleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/rel_data.csv")
tail(names(rel_data),n=2)

answer <- aggregate(.~Activity+Subject, data=rel_data, mean)

rm(list=ls())







dd<-data.frame(matrix(rnorm(216),72,3),c(rep("A",24),rep("B",24),rep("C",24)),c(rep("J",36),rep("K",36)))
colnames(dd) <- c("v1", "v2", "v3", "dim1", "dim2")

#ddply is the plyr function
ddply(dd, c("dim1","dim2"), function(df)mean(df$v1))
aggregate(.~dim1+dim2, data=dd, mean)
write.csv(dd,"dd.csv")
