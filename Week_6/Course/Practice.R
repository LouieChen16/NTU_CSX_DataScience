#Online Resoursce for factoextra: https://www.r-bloggers.com/factoextra-r-package-easy-multivariate-data-analyses-and-elegant-visualization/

#Set Language as traditional Chinese
Sys.setlocale(category = "LC_ALL", locale = "cht")

#setwd("D:/NTU_DataScience (R)/NTU_CSX_DataScience/Week_6/Course")

dat <- read.csv("show.csv")
#dataframe <- str(dat)
#View(dat)

library(RColorBrewer)
library(cluster)
library(pvclust)
library(xtable)
#library(limma)
library(plyr)
library(ggplot2)
library(car)
library(lattice)
library(factoextra)

#Transpose dataframe
# first remember the names
##n <- dat$name
# transpose all but the first column (name)
##dat <- as.data.frame(t(dat[,-1]))
##colnames(dat) <- n
##dat$myfactor <- factor(row.names(dat))

#tdat <- as.data.frame(t(dat))
#str(tdat) # Check the column types
#View(tdat)


library(data.table)
# transpose
#tdat2 <- transpose(dat)

#colnames(tdat2) <- tdat2[1,]
#tdat2 <- tdat2[-c(1), ]
#rownames(tdat2) <- c("BBC", "Epochtimes", "Inside", "Techorange")
#View(tdat2)


rownames(dat) <- dat[,1]
dat <- dat[, -c(1)]
colnames(dat) <- c("BBC", "Epochtimes", "Inside", "Techorange")

#mydata<- scale(tdat2)
#dat[is.na(dat)] <- 0

nona <- na.omit(dat)

pcs <- prcomp(nona, center = F, scale = F)
#plot(pcs)
fviz_eig(pcs)

fviz_pca_var(pcs,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

ind.coord <- pcs$x
head(ind.coord[, 1:4])


dat.ind <- as.data.frame(ind.coord)
ggplot(dat.ind, aes(x = PC1, y = PC2)) + geom_point()

pcs.ind <- prcomp(ind.coord, center = F, scale = F)

#Can't Run
'fviz_pca_biplot(pcs, repel = TRUE,
                col.var = "#2E9FDF", # Variables color
                col.ind = "#696969"  # Individuals color
)'

# 分成四群
kmeans.cluster <- kmeans(dat, centers=4) 

# If want to download classification data
#dataf <- as.data.frame(kmeans.cluster[1])
#write.csv(dataf, "cluster_data.csv")

# 群內的變異數
kmeans.cluster$withinss

# 視覺化 k-means 分群結果(基於ggplot2的語法)
require(factoextra)
fviz_cluster(kmeans.cluster,           # 分群結果
             data = dat,              # 資料
             geom = c("point","text"), # 點和標籤(point & label)
             frame.type = "norm")      # 框架型態

fviz_cluster(kmeans.cluster,           # 分群結果
             data = dat,              # 資料
             geom = c("point"), # 點和標籤(point & label)
             frame.type = "norm")      # 框架型態

fviz_cluster(kmeans.cluster,           
             data = dat,              
             geom = c("point","text") + scale_y_continuous(),
             palette = c("#bacc22","#2E9FDF", "#8f2edf", "#FC4E07"),
             frame.type = "norm")

#Emphasize class 1
#fviz_cluster(kmeans.cluster,           
#             data = dat,              
#             geom = c("point","text") + scale_y_continuous(),
#             palette = c("#bacc22","#000000", "#000000", "#000000"),
#             frame.type = "norm")

#Emphasize class 2
#fviz_cluster(kmeans.cluster,           
#             data = dat,              
#             geom = c("point","text") + scale_y_continuous(),
#             palette = c("#000000","#2E9FDF", "#000000", "#000000"),
#             frame.type = "norm")

#Emphasize class 3
#fviz_cluster(kmeans.cluster,           
#             data = dat,              
#             geom = c("point","text") + scale_y_continuous(),
#             palette = c("#000000","#000000", "#8f2edf", "#000000"),
#             frame.type = "norm")

#Emphasize class 4
#fviz_cluster(kmeans.cluster,           
#             data = dat,              
#             geom = c("point","text") + scale_y_continuous(),
#             palette = c("#000000","#000000", "#000000", "#FC4E07"),
#             frame.type = "norm")


#table(kmeans.cluster$cluster, colnames(dat)) 
#kmeans.cluster$cluster
#iris$Species
#as.list(kmeans.cluster$cluster)

dat.type <- dat
dat.type["Type"] <- 0

#將每個關鍵字所屬的媒體都列出來
for (no.row in c(1:nrow(dat.type))) {
  typ <- which.max(dat.type[no.row,])
  if (typ == 1){
    med <- "BBC"
  } else if (typ == 2){
    med <- "Epochtimes"
  } else if (typ == 3){
    med <- "Inside"
  } else if (typ == 4){
    med <- "Techorange"
  }
  dat.type[no.row,5] <- med
}
#View(dat.type)

table(kmeans.cluster$cluster, dat.type$Type)
#write.csv(dat.type, "data_type3.csv")

