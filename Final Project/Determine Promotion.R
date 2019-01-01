library(readr)
library(plyr)

Order_csv <- read_csv("D:/NTU_DataScience (R)_Final_Report_Dataset/NTU_Datasets/NTU_Datasets/Orders.csv")
PromotionOrders_csv <- read_csv("D:/NTU_DataScience (R)_Final_Report_Dataset/NTU_Datasets/NTU_Datasets/PromotionOrders.csv")

#Data preprocessing of order.csv
Order_csv <- Order_csv[, c(1,7,8)]
nona <- na.omit(Order_csv)

#Add 0 to new column & name it
nona[1:nrow(nona), 4] <- 0
colnames(nona)[4] <- "If_Promotion"

View(nona)

#Data preprocessing of PromotionOrders.csv
PromotionOrders_csv <- PromotionOrders_csv[, c(1)]
nona_pro <- na.omit(PromotionOrders_csv)

for (no_SalesOrderSlaveId in c(1:nrow(nona))){
  if_exist = which(nona[no_SalesOrderSlaveId,2] == nona_pro[1:nrow(nona_pro),1])
  
}


#Try------------------------------------------
a = c(1,2,1,3,4,1,1)
b = which(a == 1)
c = which(a == 5)
d = which(a == 4)

if (length(d) < 1){
  cat("YU")
} else{
  cat("Liang")
}
