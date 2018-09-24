# 1. 查看內建資料集: 鳶尾花(iris)資料集

## Method 1

library(datasets)
data(iris)
print(iris)

## Method 2

iris

# 使用dim(), 回傳iris的列數與欄數
dim(iris)

# 使用head() 回傳iris的前六列
head(iris, n=6)

# 使用tail() 回傳iris的後六列
tail(iris, n=6)

# 使用str() 
str(iris)

# 使用summary() 查看iris敘述性統計、類別型資料概述。
summary(iris)
