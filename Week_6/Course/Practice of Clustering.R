#http://www.rpubs.com/skydome20/R-Note9-Clustering

#1. 階層式分群(Hierarchical Clustering)
head(iris)
data <- iris[,-5]
head(data)

E.dist <- dist(data, method="euclidean") # 歐式距離
M.dist <- dist(data, method="manhattan") # 曼哈頓距離

par(mfrow=c(1,2)) # 讓圖片以1x2的方式呈現，詳情請見(4)繪圖-資料視覺化

# 使用歐式距離進行分群
h.E.cluster <- hclust(E.dist)
plot(h.E.cluster, xlab="歐式距離")

# 使用曼哈頓距離進行分群
h.M.cluster <- hclust(M.dist) 
plot(h.M.cluster, xlab="曼哈頓距離")

#hclust(E.dist, method="single")   # 最近法
#hclust(E.dist, method="complete") # 最遠法
#hclust(E.dist, method="average")  # 平均法
#hclust(E.dist, method="centroid") # 中心法
#hclust(E.dist, method="ward.D2")  # 華德法

# Try Ward this time.
h.cluster <- hclust(E.dist, method="ward.D2")

# 視覺化
plot(h.cluster)
abline(h=9, col="red")

# 觀察出最佳分群數是三群
cut.h.cluster <- cutree(h.cluster, k=3)  # 分成三群
cut.h.cluster                            # 分群結果
table(cut.h.cluster, iris$Species)       # 分群結果和實際結果比較

#2. 切割式分群(Partitional Clustering)
# 分成三群
kmeans.cluster <- kmeans(data, centers=3) 

# 群內的變異數
kmeans.cluster$withinss

# 分群結果和實際結果比較
table(kmeans.cluster$cluster, iris$Species) 

# 視覺化 k-means 分群結果(基於ggplot2的語法)
require(factoextra)
fviz_cluster(kmeans.cluster,           # 分群結果
             data = data,              # 資料
             geom = c("point","text"), # 點和標籤(point & label)
             frame.type = "norm")      # 框架型態


