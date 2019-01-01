library(readr)
library(plyr)

Order_csv <- read_csv("D:/NTU_DataScience (R)_Final_Report_Dataset/NTU_Datasets/NTU_Datasets/Orders.csv")

#Count Purchase total quantity
count_Sale_Page <- count(Order_csv, vars = "MemberId")
df <- data.frame(count_Sale_Page)

#View(df)

#Create new columns in 0
for (empt_col in c(3:43)){
  df[1:563457, empt_col] <- 0
}

write.csv(df, "D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/MemberId vs Price.csv")

## add date to another
array_date <- c("MemberId", "Quantity", "Sum_Cost")

#Get Last Day of Every Month
mon_seq <- ""
mon_seq <- seq(as.Date("2015-06-1"),by="month",length.out=40)-1

#Get only Year/Month
mon_seq <- format(mon_seq, "%Y/%m")
mon_seq

array_date <- append(array_date, mon_seq)

colnames(df) <- array_date
#View(head(df))

##Calculate Sum Cost of Each Member
for (no_of_MemberId in c(1:563457)){
  count_no <- which(Order_csv$MemberId == df$MemberId[no_of_MemberId])
  sum = 0
  for (j in c(1:length(count_no))){
    Price <- Order_csv$Quantity[j] * Order_csv$UnitPrice[j]
    sum <- sum + Price
  }
  df$Sum_Cost[no_of_MemberId] <- sum
  cat("Start Row:", no_of_MemberId,"\n", sep='')
}
df2 <- df[1:3]
write.csv(df2, "D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/MemberId vs Price_Final2.csv")

#Calculate Cost of Each Member in Each Month
for (no_of_MemberId in c(1:563457)){
  count_no <-  which(Order_csv$MemberId == df$MemberId[no_of_MemberId])
  cat("Start row:", no_of_MemberId,"\n", sep='')
  
  for (j in c(1:length(count_no))){
    Purch_date <- Order_csv$DateId[count_no[j]]
    #Convert from integer to string
    Purch_date <- toString(Purch_date)
    #Convert from string to date
    Purch_date <- as.Date(Purch_date, '%Y%m%d')
    #Convert format to %T%m 
    Purch_date <- format(Purch_date, "%Y/%m")
    #Convert back to string
    Purch_date <- toString(Purch_date)
    
    for (col_in_df in c(3:ncol(df))){
      if (Purch_date == colnames(df)[col_in_df]){
        df[no_of_MemberId, col_in_df] <- Order_csv$Quantity[j] * Order_csv$UnitPrice[j]
        break
      }
    }
  }
}

write.csv(df, "D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/MemberId vs Price_Final3.csv")
