# Taylor Lucero 
# Final Project IST 387
# Flight Information Analysis
#Phase 1 


#set the directory where the data is stored
getwd()
setwd("/Users/TaylorLucero/Desktop")

# read Lucero.csv file by using read_csv from the readr package
library(readr)
Flight_Data<- read_csv("Lucero.csv")
View(Flight_Data)

# Test for missing values with in the table with is.na
#ex. air$Ozone[is.na(air$Ozone)]
#The next two lines of code show the location of the NAs in the Table 
#while aslso giving the total number of missing values.
which(is.na(Flight_Data))
sum(is.na(Flight_Data))
#137 total missing values in flight time, departure delay in min, arrival delay in min

### Just to be sure these are the individual check for the columns
Flight_Data$Departure.Delay.in.Minutes[is.na(Flight_Data$Departure.Delay.in.Minutes)]
Flight_Data$Arrival.Delay.in.Minutes[is.na(Flight_Data$Arrival.Delay.in.Minutes)]
Flight_Data$Flight.time.in.minutes[is.na(Flight_Data$Flight.time.in.minutes)]


#once the location of the missing Data is found use the mean 
#imputation method to substitute the mean value for them, First you need to omit the NAs
## example from Pe06

Flight_Data$Departure.Delay.in.Minutes[is.na(Flight_Data$Departure.Delay.in.Minutes)] <- mean(na.omit(Flight_Data$Departure.Delay.in.Minutes))
View(Flight_Data) ## this omits the NAs

mean(Flight_Data$Departure.Delay.in.Minutes)
#this is just to check the mean after the omissions 

is.na_replace_mean_Departure.Delay<-Flight_Data$Departure.Delay.in.Minutes
Departure_Delay_Mean <- mean(is.na_replace_mean_Departure.Delay, na.rm = FALSE)
is.na_replace_mean_Departure.Delay[is.na(is.na_replace_mean_Departure.Delay)]<-Departure_Delay_Mean
View(Flight_Data)
#thise replace the values with the mean

## now with arrival delay ommission
Flight_Data$Arrival.Delay.in.Minutes[is.na(Flight_Data$Arrival.Delay.in.Minutes)] <- mean(na.omit(Flight_Data$Arrival.Delay.in.Minutes))

mean(Flight_Data$Arrival.Delay.in.Minutes)
#checking the mean values

is.na_replace_mean_Arrival.Delay.in.Minutes <- Flight_Data$Arrival.Delay.in.Minutes
Arrival_Delay_Mean <- mean(is.na_replace_mean_Arrival.Delay.in.Minutes, na.rm = FALSE)
is.na_replace_mean_Arrival.Delay.in.Minutes[is.na(is.na_replace_mean_Arrival.Delay.in.Minutes)] <- Arrival_Delay_Mean
View(Flight_Data)

##Now with Flight time in minutes omit
Flight_Data$Flight.time.in.minutes[is.na(Flight_Data$Flight.time.in.minutes)] <- mean(na.omit(Flight_Data$Flight.time.in.minutes))

#this is just to check
mean(Flight_Data$Flight.time.in.minutes)

is.na_replace_mean_Flight_time<- Flight_Data$Flight.time.in.minutes
Flight_time_Mean <- mean(is.na_replace_mean_Flight_time, na.rm = FALSE)
is.na_replace_mean_Flight_time[is.na(is.na_replace_mean_Flight_time)]<- Flight_time_Mean
View(Flight_Data)


#Phase 2
str(Flight_Data)
## this gives information on the Data Frame showing you the type of variables


### create a histgram plotly
#Add a comment that describes the shape of the histogram as symmetric, 
#positively skewed (long right tail), or negatively skewed (long left tail).

library(ggplot2)
#Satisfaction Histogram
ggplot(Flight_Data, aes(x=Flight_Data$Satisfaction)) +
  geom_histogram(bins=100 ,binwidth =1) +
  ggtitle("Customer Satisfaction") +
  labs(y= "Count", x = "Customer Satisfaction")
# this is negtively skewed with a long left tail

# Create a Histogram for Age
ggplot(Flight_Data, aes(x=Flight_Data$Age)) +
  geom_histogram(bins=100 ,binwidth =1) +
  ggtitle("Customer Age") +
  labs(y= "Count", x = "Age")
# This is positively skewed with  a mildly right tail

# Create a Histogram for Price sensitivity
ggplot(Flight_Data, aes(x=Flight_Data$Price.Sensitivity)) +
  geom_histogram(bins=100 ,binwidth = 1) +
  ggtitle("Price Sensitivity") +
  labs(y= "Count", x = "Price Sensitivity")
# This is negatively skewed with a left tail

# Create a Histogram for Year of First Flight
ggplot(Flight_Data, aes(x=Flight_Data$Year.of.First.Flight)) +
  geom_histogram(bins=100,binwidth =1) +
  ggtitle("Year of First Flight") +
  labs(y= "Count", x = "Year of First Flight")
#this has a fairly normal distribution


# Create a Histogram for No.of.Flights.p.a.
ggplot(Flight_Data, aes(x=Flight_Data$No.of.Flights.p.a.)) +
  geom_histogram(bins=100 ,binwidth =1) +
  ggtitle("Number of Flights") +
  labs(y= "Count", x = "Number of Flights")
#This is positively Skewed with a long right tail

# Create a Histogram for X..of.Flight.with.other.Airlines
ggplot(Flight_Data, aes(x=Flight_Data$X..of.Flight.with.other.Airlines)) +
  geom_histogram(bins=100 ,binwidth =1) +
  ggtitle("Flights wiht other Airlines") +
  labs(y= "Count", x = "# Flights with other Airlines")
#this is positively skewed with a long right tail

# Create a Histogram for No..of.other.Loyalty.Cards
ggplot(Flight_Data, aes(x=Flight_Data$No..of.other.Loyalty.Cards)) +
  geom_histogram(bins=100 ,binwidth =1) +
  ggtitle("Loyalty Card") +
  labs(y= "Count", x = "Number Loyalty Cards")
#This is positively skewed with a short right tail


# Create a Histogram for Shopping.Amount.at.Airport
ggplot(Flight_Data, aes(x=Flight_Data$Shopping.Amount.at.Airport)) +
  geom_histogram(bins=100 ,binwidth =30) +
  ggtitle("Shopping Amount") +
  labs(y= "Count", x = "Shopping amount at Airport")
#This has a skewed right tail


# Create a Histogram for Eating.and.Drinking.at.Airport
ggplot(Flight_Data, aes(x=Flight_Data$Eating.and.Drinking.at.Airport)) +
  geom_histogram(bins=100 ,binwidth =30) +
  ggtitle("Eating & Drinking at Airport") +
  labs(y= "Count", x = "Amount of Food Consumed")
#This is positively skewed with a long right tail

# Create a Histogram for Day.of.Month 
ggplot(Flight_Data, aes(x=Flight_Data$Day.of.Month)) +
  geom_histogram(bins=100 ,binwidth =1) +
  ggtitle("Day of the Month") +
  labs(y= "Count", x = "Days of the Month")
#This has a pretty normal distribution

# Create a Histogram for Scheduled.Departure.Hour
ggplot(Flight_Data, aes(x=Flight_Data$Scheduled.Departure.Hour)) +
  geom_histogram(bins=100 ,binwidth =1) +
  ggtitle("Scheduled Departure Hour") +
  labs(y= "Count", x = "Hour")
#this has a fairly normal distribution 
 
# Create a Histogram for Departure.Delay.in.Minutes
ggplot(Flight_Data, aes(x=Flight_Data$Departure.Delay.in.Minutes)) +
  geom_histogram(bins=100 ,binwidth =45) +
  ggtitle("Departure Delay") +
  labs(y= "Count", x = "Minutes")
#This has a positive skew wiht a short right tail


# Create a Histogram for Arrival.Delay.in.Minutes
ggplot(Flight_Data, aes(x=Flight_Data$Arrival.Delay.in.Minutes)) +
  geom_histogram(bins=100 ,binwidth =45) +
  ggtitle("Arrival Delay") +
  labs(y= "Count", x = "Minutes")
# This has a positive skew with a short right tail

# Create a Histogram Flight.time.in.minutes 
ggplot(Flight_Data, aes(x=Flight_Data$Flight.time.in.minutes)) +
  geom_histogram(bins=100 ,binwidth =35) +
  ggtitle("Flight time") +
  labs(y= "Count", x = "Minutes")
#This has a positive skew with a long right tail

# Create a Histogram  Flight.Distance
ggplot(Flight_Data, aes(x=Flight_Data$Flight.Distance)) +
  geom_histogram(bins=100 ,binwidth =55) +
  ggtitle("Flight Distance") +
  labs(y= "Count", x = "Miles")
# This has a positive skew with a long right tail 

# Table command to see how many observations are in each category
#For each factor variable (e.g., Gender), 
#use the table() command to summarize how many observations are in each category. 

# 	Destination City 
table(Flight_Data$Destination.City)
#There are 153 possible City Destinations for a flight/ with the most flying to Atlanta Ga (191)

#
# 	Origin City 
table(Flight_Data$Orgin.City)
#There is 152 possible origin cities for a flight/ with the most flying from Chicago, Il(192)

# 	Airline Status 
table(Flight_Data$Airline.Status)
# there are 4 categories for the airline status and they are Blue, Gold, Platinum, and Silver/ Blue(1697), Gold(211), Platinum(90), Silver(502)
# 	Gender
table(Flight_Data$Gender)
#there are two genders Male and Female/There are 1463 Females and 1037 Males

# 	Types of Travel 
table(Flight_Data$Type.of.Travel)
#There are three catigories for the type of travle and they are Business travel, Mileage Travel, Personal Travel
# With BT(1515), MT(189), PT(796)

# 	Class 
table(Flight_Data$Class)
#There are three different classes they are Business, Eco, and Eco Plus. Business(170), Eco(2041), Eco Plus(289)

# 	Airline Code 
table(Flight_Data$Airline.Code)
# There are 14 possible Ariline codes and they are
#AA  AS  B6  DL  EV  F9  FL  HA  MQ  OO  OU  US  VX  WN 
#141  76 103 395 296  43  51   1 100 299 208 225  34 528 

# 	Airline Name
table(Flight_Data$Airline.Name)
# There are 14 possible Airline Names With the most flights being Cheapseats Airlines Inc and the Least being from West Airways inc.

# Origin State
table(Flight_Data$Origin.State)
# there are 48 possible states to be from with the most being from California(292)

#
# 	Destination State 
table(Flight_Data$Destination.State)
#there are 49 possible destination states with the most being from 199

# 	Flight Cancelled 
table(Flight_Data$Flight.cancelled)
#there are to possible categories for flight cancellations and its yes and no, yes(43) and no(2457)



#phase 3
#predict satisfaction from other variable
# change character dat into numeric to allow lm to interpret the information

# Interpret the adjusted R-square first, then interpret any predictors whose 
#“Estimates” are statistically significant
#(indicated by one or more “*” at the end of the line). 
#From the standpoint of communicating with the client, 
#it can also be useful to run a second “trimmed” 
#lm() model that only includes those predictors that were significant
#in the initial model.
##Age 2e-16, Arrival delay in min 3.11e-07

## In order to get the text values converted to numbers, first convert it to a factor, then a numeric vector.
str(Flight_Data)
Flight_Data_F <-Flight_Data

#Factoring Below

#Destination City 
Flight_data.Destination.City <- factor(Flight_Data$Destination.City)
Flight_Data_F$Destination.City <- as.numeric(Flight_data.Destination.City)

#Orgin City
Flight_data.Orgin.City <- factor(Flight_Data$Orgin.City)
Flight_Data_F$Orgin.City<- as.numeric(Flight_data.Orgin.City)


#Airline Status
Flight_data.Airline.Status <- factor(Flight_Data$Airline.Status)
Flight_Data$Airline.Status<- as.numeric(Flight_data.Airline.Status)

#Gender Factor
Flight_data.Gender_factor <- factor(Flight_Data$Gender)
Flight_Data_F$Gender<- as.numeric(Flight_data.Gender_factor)

#Type of Travel
Flight_data.Type.of.Travel <- factor(Flight_Data$Type.of.Travel)
Flight_Data_F$Type.of.Travel<- as.numeric(Flight_data.Type.of.Travel)

#Class
Flight_data.Class_factor <- factor(Flight_Data$Class)
Flight_Data_F$Class<- as.numeric(Flight_data.Class_factor)

#FLight Date
Flight_data.Flight.date <- factor(Flight_Data$Flight.date)
Flight_Data_F$Flight.date <- as.numeric(Flight_data.Flight.date)

#Airline Code
Flight_data.Airline.Code <- factor(Flight_Data$Airline.Code)
Flight_Data_F$Airline.Code <- as.numeric(Flight_data.Airline.Code)

#Airline Name
Flight_data.Airline.Name <- factor(Flight_Data$Airline.Name)
Flight_Data_F$Airline.Name <- as.numeric(Flight_data.Airline.Name)

#Origin State
Flight_data.Origin.State <- factor(Flight_Data$Origin.State)
Flight_Data_F$Origin.State <- as.numeric(Flight_data.Origin.State)

#Destination State
Flight_data.Destination.State <- factor(Flight_Data$Destination.State)
Flight_Data_F$Destination.State <- as.numeric(Flight_data.Destination.State)

#Flight Cancelled
Flight_data.Flight.cancelled <- factor(Flight_Data$Flight.cancelled)
Flight_Data_F$Flight.cancelled <- as.numeric(Flight_data.Flight.cancelled)

#Arrival Delay greater than 5
Flight_data.Arrival.Delay.greater.5.Mins <- factor(Flight_Data$Arrival.Delay.greater.5.Mins)
Flight_Data_F$Arrival.Delay.greater.5.Mins <- as.numeric(Flight_data.Arrival.Delay.greater.5.Mins)

# Linear Regression Modeling to find Independant Variables that are significant to the Dependant Variable Satisfaction

modelSatisfaction<- lm(formula = Satisfaction ~ `Destination.City` + `Orgin.City` + `Airline.Status` + `Age` + `Gender` + `Price.Sensitivity` + `Year.of.First.Flight` + `No.of.Flights.p.a.` + `X..of.Flight.with.other.Airlines` + `Type.of.Travel` + `No..of.other.Loyalty.Cards` + `Shopping.Amount.at.Airport` + `Eating.and.Drinking.at.Airport` + `Class`	+ `Day.of.Month` + `Flight.date` + `Airline.Code` + `Airline.Name` + `Origin.State` + `Destination.State` +	`Scheduled.Departure.Hour` + `Departure.Delay.in.Minutes` + `Arrival.Delay.in.Minutes` + `Flight.cancelled` + `Flight.time.in.minutes` + `Flight.Distance` + `Arrival.Delay.greater.5.Mins` +	`olong` +	`olat` + `dlong` + `dlat`, data = Flight_Data_F)
summary(modelSatisfaction)

#From the linear modelling we see that 8 Variables are Significant to the dependant variable Satisfaction
#This means the p-values score is considered to be in the range of p < .05, within this range the variable is considered to be significant.
# The Following are significant variables: Airline Status, Age, Year of First Flight,No.of.Flights.p.a.,Type.of.Travel, Origin state, Scheduled departure Hour,Arrival Delay Greater than 5 minutes.
# the lowest p-value scores are Airline status, Type of Travel, Arrival Delay greater than 5 minutes all at 2e-16.

#The standard error is a statistical term that measures the accuracy with which a sample represents a population, with the variables that
#that are Significant with the three highest 
#Airline status has a SE of 1.258e-02 
#Type of Travel has a SE of 1.816e-02
# Arrival Delay Greater then 5 min has a SE of 3.900e-02

#followed by P- values of

#Age - .000367
#Year of First Flight - 0.045098
#No.of.Flights.p.a. - 0.007986
#Origin state -0.413760 
#Scheduled departure Hour - 0.001886


#R-squared (R2) is a statistical measure that represents the proportion of the variance for a dependent variable that's explained by an independent variable or variables in a regression model
# the variance for satisfaction caused by the Total Independant Variables is an adjusted value of .403. This means that based on all the indepedant variables this is the change of data to 
#the dependant variable that gets changed due to the influence of the independant variables.


#Trimmed Lm model of only significant predictors
TrimmedmodelSatisfaction <- lm(form = Satisfaction ~ Airline.Status + Age + Type.of.Travel + Scheduled.Departure.Hour + Arrival.Delay.greater.5.Mins, data = Flight_Data_F)
summary(TrimmedmodelSatisfaction)

# For the trimmed linear model with the five most significant independant variables that influence the Satisfactory level are ( followed by their Standard error and p- value score)
#Airline Status- SE = .0765894 / P- value = 2e-16
#Age - SE = .0123883 / P-value = 2e-16
#Type of travel - SE = .0172501 / P - Value = 2e-16
#Scheduled Departure hour - .0031774 / P - value = .00125
#arrival Delay greater than 5 minutes - SE = .0315087 / P - Value = 2e-16
# the adjust R squared value is .4005 

#Phase 4 Map Low Satisfaction Routes
#subset the data to help show only the trips with a small satisfaction rating
# use ggplot and the latitude and longitude of each origin and destination to help place route curves on map of the US
#The geom_curve() geometry supports this kind of plotting

#Subsetting the Data
#Significant Variables are : Airline.Status, Age, Type.of.Travel, Scheduled.Departure.Hour, Arrival.Delay.greater.5.Mins

## subsets so that only rows with satisfaction 1 & 2 are outputted.
Lowsatisfaction<- subset(Flight_Data_F, Satisfaction == 1 | Satisfaction ==2)
View(Lowsatisfaction)
## this gives 522 instances of low scores of both 1 & 2

#trimmed LM model of signigicant predictors of only satisfaction levels 1 and 2
TMSatisfaction1and2<-lm(form = Satisfaction ~ Airline.Status + Age + Type.of.Travel + Scheduled.Departure.Hour + Arrival.Delay.greater.5.Mins, data = Lowsatisfaction)
summary(TMSatisfaction1and2)
## this linear regression model shows shows the most significant indepandent variable with satisfactory levels one and two is type of Travel


## use ggplot to make a map with the route
worldMap <- borders("world", colour="grey", fill="white")
library(ggplot2)
ggplot() + worldMap +
  geom_curve(data = Lowsatisfaction, aes(x = Lowsatisfaction$olong, y = Lowsatisfaction$olat,  xend = Lowsatisfaction$dlong, yend = Lowsatisfaction$dlat ), col = 'black', size = .25 , curvature = .1 ) +
  geom_point(data = Lowsatisfaction, aes(x = Lowsatisfaction$olong, y = Lowsatisfaction$olat), col = 'green', size = 1.5) + #Flight Start
  geom_point(data = Lowsatisfaction, aes(x = Lowsatisfaction$dlong, y = Lowsatisfaction$dlat), col = 'red', size = 1.5) + # Flight End 
      theme(plot.title=element_text(hjust=0.5, size=12))+
  coord_cartesian(ylim=c(0, 65.5), xlim=c(-45, -160)) +
  ggtitle("Flight Map For Customers with Low Satisfaction")


#Map Graphing based on satisfaction level

Lowsatisfaction1<- subset(Flight_Data, Satisfaction == 1)
Lowsatisfaction2<- subset(Flight_Data, Satisfaction == 2)

# this map visualizes the differences between satisfaction level 1 and 2
ggplot() + worldMap +
  geom_curve(data = Lowsatisfaction2, aes(x = Lowsatisfaction2$olong, y = Lowsatisfaction2$olat, xend = Lowsatisfaction2$dlong, yend = Lowsatisfaction2$dlat), col = "yellow", size =.5 , curvature = .1 ) +
  geom_curve(data = Lowsatisfaction1, aes(x = Lowsatisfaction1$olong, y = Lowsatisfaction1$olat,  xend = Lowsatisfaction1$dlong, yend = Lowsatisfaction1$dlat ), col = 'black', size = .25, curvature = .1 ) +
  geom_point(data = Lowsatisfaction1, aes(x = Lowsatisfaction1$olong, y = Lowsatisfaction1$olat), col = 'green', size = 1.5) + #Flight Start
  geom_point(data = Lowsatisfaction1, aes(x = Lowsatisfaction1$dlong, y = Lowsatisfaction1$dlat), col = 'red', size = 1.5) + # Flight End 
  theme(plot.title=element_text(hjust=0.5, size=12))+
  coord_cartesian(ylim=c(0, 65.5), xlim=c(-45, -160)) +
  ggtitle("Routes of Satisfaction Levels 1 & 2")


#Route based off of type of travel

type.of.TravelMileage<- subset(Lowsatisfaction1, Type.of.Travel == "Mileage tickets" )
type.of.TravelPersonal<- subset(Lowsatisfaction1, Type.of.Travel == "Personal Travel" )

##this visualizes the significant independant variable type of travel, by seperating all satisfactory level 1 by mileage or personal.

ggplot() + worldMap +
  geom_curve(data = type.of.TravelMileage, aes(x = type.of.TravelMileage$olong, y = type.of.TravelMileage$olat, xend = type.of.TravelMileage$dlong, yend = type.of.TravelMileage$dlat), col = "Orange", size =.5 , curvature = .1 ) +
  geom_curve(data = type.of.TravelPersonal,aes(x = type.of.TravelPersonal$olong, y = type.of.TravelPersonal$olat, xend= type.of.TravelPersonal$dlong, yend = type.of.TravelPersonal$dlat ), col = 'Blue', size = .25, curvature = .1 ) +
  geom_point(data = type.of.TravelMileage, aes(x = type.of.TravelMileage$olong, y = type.of.TravelMileage$olat), col = 'green', size = 1.5) + #Flight Start
  geom_point(data = type.of.TravelMileage, aes(x = type.of.TravelMileage$dlong, y = type.of.TravelMileage$dlat), col = 'red', size = 1.5) + # Flight End 
  geom_point(data = type.of.TravelPersonal, aes(x = type.of.TravelPersonal$olong, y = type.of.TravelPersonal$olat), col = 'green', size = 1.5) + #Flight Start
  geom_point(data = type.of.TravelPersonal, aes(x = type.of.TravelPersonal$dlong, y = type.of.TravelPersonal$dlat), col = 'red', size = 1.5) + # Flight End 
  theme(plot.title=element_text(hjust=0.5, size=12))+
  coord_cartesian(ylim=c(0, 65.5), xlim=c(-45, -160)) +
  ggtitle("Low Satisfcation Routes based off of Type of Travel")


Arrival.Delay.greater.5.MinsY<- subset(Lowsatisfaction, Arrival.Delay.greater.5.Mins == "2" )
Arrival.Delay.greater.5.MinsN<- subset(Lowsatisfaction, Arrival.Delay.greater.5.Mins == "1" )
View(Arrival.Delay.greater.5.MinsY)
#269 entries with low satisfaction where the flight was delayed more than 5












