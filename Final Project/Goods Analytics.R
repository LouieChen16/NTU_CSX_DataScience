library(readr)
Order_csv <- read_csv("D:/NTU_DataScience (R)_Final_Report_Dataset/NTU_Datasets/NTU_Datasets/Orders.csv")

#summary(Order_csv)

##Data Preprocessing

#Calculate standard deviation after omiting 0

for (i in c(1:nrow(Prod_Ana))){
  mydatarange<-Prod_Ana[i,4:1222]
  
  nzsd <- function(x) {
    if (all(x==0)) 0 else sd(x[x!=0])
  }
  Prod_Ana[i,1223] <- apply(mydatarange,1,nzsd)
  cat("Row:", i, "\n", sep='')
}
colnames(Prod_Ana)[1223] <- "SD_Without_Zeros"
View(Prod_Ana[1223])

#Calculate mean after omiting 0
Prod_Ana <- read.csv("D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/Product Analysis(to 17081).csv")

for (i in c(1:nrow(Prod_Ana))){
  mydatarange<-Prod_Ana[i,4:1222]

  nzmean <- function(x) {
    if (all(x==0)) 0 else mean(x[x!=0])
  }
  Prod_Ana[i,1224] <- apply(mydatarange,1,nzmean)
  cat("Row:", i, "\n", sep='')
}
colnames(Prod_Ana)[1224] <- "Mean_Without_Zeros"
View(Prod_Ana[1224])

write.csv(Prod_Ana, "D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/Product Analysis(Calculate mn & sd).csv")


##Visualization
library(ggplot2)

ggplot(data = Prod_Ana, mapping = aes(x = Mean_Without_Zeros, y = SD_Without_Zeros)) +
  geom_point(alpha = 0.05, color = "blue") + scale_y_continuous(
    limits = c(0, 9)) + scale_x_continuous(limits = c(0.3, 9)) + 
  labs(title="Product Character Analysis Chart", 
       subtitle="Scatter Chart", caption="Source: 91APP")

#Search Certain Area
ggplot(data = Prod_Ana, mapping = aes(x = Mean_Without_Zeros, y = SD_Without_Zeros, label = SalePageId)) +
  geom_point(alpha = 0.05, color = "blue") + scale_y_continuous(
    limits = c(0, 2.5)) + scale_x_continuous(limits = c(8, 21)) + geom_text() + 
  labs(title="Product Character Analysis Chart", 
       subtitle="Scatter Chart", caption="Source: 91APP")


#Count days of non zero sales for each products
Prod_Ana_m_sd <- read.csv("D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/Product Analysis(Calculate mn & sd).csv")

for (i in c(1:17081)){
  Prod_Ana_m_sd[i, 1226] <- rowSums(Prod_Ana_m_sd[i,5:1223] != 0)
  cat("Row:", i, "\n", sep = '')
}
colnames(Prod_Ana_m_sd)[1226] <- "Days_not_zero"
View(Prod_Ana_m_sd[1226])

# Draw scatter plot of non zero day and sum
ggplot(data = Prod_Ana_m_sd, mapping = aes(x = Freq, y = Days_not_zero, label = SalePageId)) +
  geom_point(alpha = 0.05, color = "blue") +  
  labs(title="Product Character Analysis Chart", 
       subtitle="Scatter Chart", caption="Source: 91APP")




# Draw top 30 popular products chart
library(ggplot2)
library(plyr)
sort_by_freq <- count(Order_csv, vars = "SalePageId")

sort_by_freq <- sort_by_freq[order(sort_by_freq$freq), ]
sort_by_freq <- na.omit(sort_by_freq)

sort_by_freq$SalePageId <- factor(sort_by_freq$SalePageId, levels = sort_by_freq$SalePageId)

#Only select top 30
sort_by_freq <- tail(sort_by_freq, 30)

ggplot(data = sort_by_freq, aes(x = SalePageId, y = freq)) +
  geom_bar(stat="identity", width = 0.5, fill = "red", colour = "tomato2") + 
  labs(title="Top 30 Hot Products Ranking", 
       subtitle="Bar Chart (Sorted)", 
       caption="Source: 91APP") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))


#Trying---------------------------------------------------

#Draw scatter plot for all products
Prod_Ana <- read.csv("D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/Product Analysis(to 17081).csv")
#First <- Prod_Ana[1,4:ncol(Prod_Ana)]
#sec <- Prod_Ana[2,4:ncol(Prod_Ana)]

#comb <- cbind(First, sec)

comb <- Prod_Ana[,4:ncol(Prod_Ana)]
trans <- t(comb)

trans <- as.data.frame(trans)


as.array(groupname)
groupname <- ""
groupname[1:1219] <- 1
groupname[1220:2*1219] <- 2
groupname <- na.omit(groupname)

trans$group <- groupname

trans$day <- append(1:1219, 1:1219)

colnames(trans)[1] <- "Quantity"

ggplot(data = trans, aes(x = day, y = Quantity, color = group)) + geom_point() + 
  theme(axis.text.x = element_text(angle=65, vjust=0.1)) #+ scale_x_continuous(limits = c(0, 100))


#trans_final <- rownames(trans)
#Use Day sequence rather than exact date
trans_final <- -2:1219

trans_final <- as.data.frame(trans_final)
trans_final <- cbind(trans_final, trans)

colnames(trans_final) <- c("date", "First_one", "Sec_one")
trans_final <- trans_final[-c(1:3),]
Part1_trans_final <- trans_final[1:100, ]

#trans_final[2,2]
ggplot(data = Part1_trans_final, aes(x = date, y = First_one)) + geom_point(color="blue") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))

ggplot(data = Part1_trans_final, aes(x = date, y = Sec_one)) + geom_point(color="blue") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))





##Dealing with date and plot
date <- c("20181212", "20181213","20181214")
sale <- c("121","1414","344")
dat <- data.frame(date, sale)
#dat

dat$date <- as.Date( dat$date, '%Y%m%d')
#dat
#dat$sale<- factor(dat$sale)
#dat
require(ggplot2)
ggplot( data = dat, aes(x = date,y = sale)) + geom_line() + geom_point()
