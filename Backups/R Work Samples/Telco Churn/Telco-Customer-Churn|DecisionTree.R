##Taylor Lucero 
#Telco -Churn Rate : Predicting Customer Churn
#Decision Tree
library(readr)
urlfile="https://raw.githubusercontent.com/Telucero/Portfolio/master/R%20Work%20Samples/Telco%20Churn/Telco-Customer-Churn.csv"
Data<-read_csv(url(urlfile))
View(Data)


##Learning about the data 
# There are 7043 instances with 21 variables | We are focusing on the Churn variable 
str(Data)

#Test to see if there are any missing values 
which(is.na(Data))
sum(is.na(Data))
Data$TotalCharges[is.na(Data$TotalCharges)] 
Data$TotalCharges[is.na(Data$TotalCharges)] <-mean(na.omit(Data$TotalCharges))


Data$gender <- as.numeric(Data$gender)
# 1 = Female, 2 = Male 
Data$Partner <- as.numeric(Data$Partner)
# 1 = No, 2 = Yes 
Data$Dependents <- as.numeric(Data$Dependents)
# 1 = No, 2 = Yes 
Data$PhoneService <- as.numeric(Data$PhoneService)
# 1 = No, 2 = Yes 
Data$MultipleLines <-as.numeric(Data$MultipleLines)
# 1 = No, 2 = No Phone Service, 3 = Yes 
Data$InternetService <- as.numeric(Data$InternetService)
# 1= DSL,2 = FiberOptics, 3= No
Data$OnlineSecurity <- as.numeric(Data$OnlineSecurity)
# 1 = No, 2 = No Internet Service,  3 = Yes 
Data$OnlineBackup <- as.numeric(Data$OnlineBackup)
# 1 = No, 2 = No internet Service,  3 = Yes 
Data$DeviceProtection <- as.numeric(Data$DeviceProtection)
# 1 = No, 2 = No internet Service,  3 = Yes 
Data$TechSupport <- as.numeric(Data$TechSupport)
# 1 = No, 2 = No internet Service,  3 = Yes 
Data$StreamingTV <- as.numeric(Data$StreamingTV)
# 1 = No, 2 = No internet Service,  3 = Yes 
Data$StreamingMovies<- as.numeric(Data$StreamingMovies)
# 1 = No, 2 = No internet Service,  3 = Yes 
Data$Contract<-as.numeric(Data$Contract)
# 1 = Month to Month, 2 = One month , 3 = Two months
Data$PaperlessBilling<-as.numeric(Data$PaperlessBilling)
# 1 = No, 2 = Yes 
Data$PaymentMethod <-as.numeric(Data$PaymentMethod)
#1 = banktransfer, 2 = creditcard, 3 = echeck, 4 =mailed check
Data$MonthlyCharges <- as.numeric(Data$MonthlyCharges)
Data$TotalCharges <-as.numeric(Data$TotalCharges)

## Look at the beta coefficients & t-values to determine variables 
#that are not statistically significant

library("lm.beta")
Churn.lm= lm (Churn ~., data = Data)
summary(Churn.lm)
lm.churn.beta <- lm.beta(Churn.lm)
summary(lm.churn.beta)
coef(lm.churn.beta)

# 4 variables are not significant in relation to Churn
#remove unneeded variables
#gender
#movies and Shows
#payment method
Data<-Data[,c(-2,-14,-15,-18)]


#Step 3: Create train/test set.
shuffle_index <- sample(1:nrow(Data))
head(shuffle_index)
Data <- Data[shuffle_index, ]

create_train_test <- function(data, size = 0.8, train = TRUE) {
  n_row = nrow(data)
  total_row = size * n_row
  train_sample<- 1: total_row
  if (train == TRUE) {
    return (data[train_sample, ])
  } else {
    return (data[-train_sample, ])
  }
}
data_train <-create_train_test(Data, size =.8, train = TRUE)
data_test <- create_train_test(Data, size =.8, train = FALSE)

# Verify if the randomization process is correct 
prop.table(table(data_train$Churn))
prop.table(table(data_test$Churn))
data_train<-data_train[-1]

#DT
library("rpart")
library("rpart.plot")
#Play around with parameters to find the best tree
tree<- rpart(Churn~., 
            data = data_train, 
            method='class',
            minsplit = 3,
            cp = -1)

tree$variable.importance
printcp(tree)

#xerror .78084 + .020103 =.80 , the smallest tree with nsplit=5  cp .0111
# prune the tree with the a cp slightly greater than cp =.0111
tree <- prune(tree, cp = .012)
rpart.plot(tree, extra = 106)
rpart.rules(tree)

#Test 
library('e1071')
library('yardstick')
predict<- predict(tree, data_test, type='class')
Tablepred<- table(data_test$Churn, predict)
Tablepred

