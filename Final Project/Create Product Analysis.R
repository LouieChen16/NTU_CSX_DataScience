library(readr)
library(plyr)

Order_csv <- read_csv("D:/NTU_DataScience (R)_Final_Report_Dataset/NTU_Datasets/NTU_Datasets/Orders.csv")

## Changing format to right one
count_Sale_Page <- count(Order_csv, vars = "SalePageId")
df <- data.frame(count_Sale_Page)
#Create new columns in 0
for (empt_col in c(3:1221)){
  df[1:17081, empt_col] <- 0
}

write.csv(df, "D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/Product Analysis.csv")
Prod_Ana <- read.csv("D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/Product Analysis.csv")
Prod_Ana <- Prod_Ana[, -c(1)]
#Prod_Ana[1,2]
#head(Prod_Ana)

## add date to another
array_date <- c("SalePageId", "Freq")
for (day_dif in c(1:1219)){
  Date <- as.Date("2015-04-30") + day_dif
  #Convert type to string
  to_str <- toString(Date)
  array_date[day_dif + 2] <- to_str
}
colnames(Prod_Ana) <- array_date

##Start to Calculate

for (no_of_SalePageId in c(1:17081)){
  count_no <- which(Order_csv$SalePageId == Prod_Ana$SalePageId[no_of_SalePageId])
  cat("Start row:", no_of_SalePageId,"\n", sep='')
  #count_no
  #length(count_no)
  for (j in c(1:length(count_no))){
    Purch_date <- Order_csv$DateId[count_no[j]]
    #Convert from integer to string
    Purch_date <- toString(Purch_date)
    #Convert from string to date
    Purch_date <- as.Date(Purch_date, '%Y%m%d')
    #Convert back to string
    Purch_date <- toString(Purch_date)
    
    for (col_in_Prod_Ana in c(3:ncol(Prod_Ana))){
      if (Purch_date == colnames(Prod_Ana)[col_in_Prod_Ana]){
        Prod_Ana[no_of_SalePageId, col_in_Prod_Ana] <- Prod_Ana[no_of_SalePageId, col_in_Prod_Ana] + 1
        break
      }
    }
  }
}

print("OK")
write.csv(Prod_Ana, "D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/Product Analysis(to 17081).csv")
#write.csv(Prod_Ana, "D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/Product Analysis2.csv")







