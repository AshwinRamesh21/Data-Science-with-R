library(factoextra)
library(cluster)
df <- USArrests
df <- na.omit(df)
df <- scale(df)
head(df)
m <- c( "average", "single", "complete", "ward")
names(m) <- c( "average", "single", "complete", "ward")
ac <- function(x) {
  agnes(df, method = x)$ac
}
sapply(m, ac)
clust <- agnes(df, method = "ward")
pltree(clust, cex = 0.6, hang = -1, main = "Dendrogram") 

gap_stat <- clusGap(df, FUN = hcut, nstart = 25, K.max = 10, B = 50)
fviz_gap_stat(gap_stat)

d <- dist(df, method = "euclidean")
final_clust <- hclust(d, method = "ward.D2")
groups <- cutree(final_clust, k=4)
table(groups)

final_data <- cbind(USArrests, cluster = groups)
head(final_data)

aggregate(final_data, by=list(cluster=final_data$cluster), mean)
