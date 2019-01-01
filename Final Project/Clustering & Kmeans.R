dat <- read.csv("D:/NTU_DataScience (R)/NTU_CSX_DataScience/Final Project/Product Analysis(to 17081).csv")

#Exclude data we don't want
dat <- dat[, -c(1,3)]

dat_without_salepageid <- dat[, -c(1)]

nona <- na.omit(dat_without_salepageid)

#PCA
#REF: https://sites.google.com/site/rlearningsite/factor/pca
pcs <- prcomp(nona, center = F, scale = F)

#Plot Slop Chart
library(factoextra)
fviz_eig(pcs)

prinComp <- cbind(dat, pcs$rotation)

#ggplot(prinComp, aes(x = PC1, y = PC2)) + geom_point()

ind.coord <- pcs$x
head(ind.coord[, 1:4])

dat.ind <- as.data.frame(ind.coord)
ggplot(dat.ind, aes(x = PC1, y = PC2)) + geom_point() + scale_y_continuous(
  limits = c(-200, 1000)) + scale_x_continuous(limits = c(-700, 10))


# 3D plot
#x <- ind.coord[, 1]
#y <- ind.coord[, 2]
#z <- ind.coord[, 3]

#library(scatterplot3d)
#scatterplot3d(x,y,z)


#Clustering
sdat <- t(scale(t(dat)))

pr.dis <- dist(t(sdat), method = "euclidean")

pr.hc.s <- hclust(pr.dis, method = "single")
pr.hc.c <- hclust(pr.dis, method = "complete")
pr.hc.a <- hclust(pr.dis, method = "average")
pr.hc.w <- hclust(pr.dis, method = "ward")

# plot them
op <- par(mar = c(0, 4, 4, 2), mfrow = c(2, 2))

plot(pr.hc.s, labels = FALSE, main = "Single", xlab = "")
plot(pr.hc.c, labels = FALSE, main = "Complete", xlab = "")
plot(pr.hc.a, labels = FALSE, main = "Average", xlab = "")
plot(pr.hc.w, labels = FALSE, main = "Ward", xlab = "")


#Kmeans
library(cluster)
kmeans.cluster <- kmeans(dat, centers=4)
head(kmeans.cluster)

require(factoextra)
fviz_cluster(kmeans.cluster,           # 分群結果
             data = dat,              # 資料
             geom = c("point","text"), # 點和標籤(point & label)
             frame.type = "norm")      # 框架型態


