# Week 3 Notes
# Hierarchical Clustering, K-means Clustering

set.seed(1234)
par(mar = c(0,0,0,0))
x <- rnorm(12, mean = rep(1:3, each=4), sd=0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each=4), sd = 0.2)
plot(x, y, col="blue", pch=19, cex=2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# Calculates the distance between all
# defaults to Eludian Dist
dataFrame <- data.frame(x=x, y=y)
dist(dataFrame) 

# Create a single point, then create another point.
# eventually create a Dendrogram
distxy <- dist(dataFrame)
hCluster <- hclust(distxy)
plot(hCluster)

#Average Linkage (centers)
#Complete Linkage (fatherst points)

#heatmap()
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
heatmap(dataMatrix)

##########################################
# K-means Clustering
##########################################
kmeansObj <- kmeans(dataFrame, centers=3)
names(kmeansObj)

kmeansObj$cluster

par(mar=rep(0.2,4))
plot(x,y, col=kmeansObj$cluster, pch=19, cex=2)
points(kmeansObj$centers, col = 1:3, pch=3, cex=3, lwd= 3)

# heatmap over kmeans
kmeansObj2 <- kmeans(dataMatrix, centers=3)
par(mfrow = c(1,2), mar = c(2,4,0.1,0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt="n")
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n")

##### Dimension reduction
# No interesting pattern
set.seed(12345)
par(mar = rep(0.2), 4)
dataMatrix <- matrix(rnorm(400), nrow=40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])

heatmap(dataMatrix)

# add pattern
set.seed(678910)
for (i in 1:4) {
  #flip a coin
  coinFlip <- rbinom(1, size=1, prob=0.5)
  # if coin is heads add a common pattern to that row
  if(coinFlip) {
    dataMatrix[i,] <- dataMatrix[i, ] + rep(c(0,3), each=5)
  }
}

image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
heatmap(dataMatrix)

################# Cluster
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, ,xlab= "Row Mean", ylab = "Row", pch=19)
plot(colMeans(dataMatrixOrdered), xlab="Column", ylab="Column Mean", pch=19)


# First goal is statistical and the second goal is data compression
# Singular Value Decomposition SVD "Matrix Decomposition"
# Into 3 seperate U, V, D

# PCA, Princple Component Analysis
# Take the original data matrix and subtract the mean and divide by the std. Then run SVD.
# The data would be equal to the V matrix
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
plot(svd1$u[,1], 40:1, ,xlab= "Row", ylab = "First left singular vector", pch=19)
plot(svd1$v[,1], xlab="Column", ylab="First right singular vector", pch=19)

par(mfrow = c(1,2))
plot(svd1$d, xlab = "Column", ylab="Singular Value", pch=19)
plot(svd1$d^2/sum(svd1$d^2), xlab="Column", ylab = "Prop. of variance explained", pch=19)

pca1 <- prcomp(dataMatrixOrdered, scale=TRUE)
plot(pca1$rotation[,1],svd1$v[,1], pch=19, xlab="Principal Component 1", ylab="Right Singular Vector 1")
abline(c(0,1))

# Only one dimension
constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]){constantMatrix[i,] <- rep(c(0,1), each=5)}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d, xlab = "Column", ylab="Singular Value", pch=19)
plot(svd1$d^2/sum(svd1$d^2), xlab="Column", ylab = "Prop. of variance explained", pch=19)

############ Adding in a second pattern
# add pattern
set.seed(678910)
for (i in 1:4) {
  #flip a coin
  coinFlip1 <- rbinom(1, size=1, prob=0.5)
  coinFlip2 <- rbinom(1, size=1, prob=0.5)
  # if coin is heads add a common pattern to that row
  if(coinFlip1) {
    dataMatrix[i,] <- dataMatrix[i, ] + rep(c(0,5), each=5)
  }
  if(coinFlip2) {
    dataMatrix[i,] <- dataMatrix[i, ] + rep(c(0,5))
  }
}

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rep(c(0,1), each=5), ,xlab= "Column", ylab = "Pattern 1", pch=19)
plot(rep(c(0,1), 5), xlab="Column", ylab="Pattern 2", pch=19)

# Can the algo see the patterns of variance
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd2$v[,1], pch=19, xlab="Column", ylab="First right singular vector")
plot(svd2$v[,2], pch=19, xlab="Column", ylab="Second right singular vector")

svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,2))
plot(svd1$d, xlab = "Column", ylab="Singular Value", pch=19)
plot(svd1$d^2/sum(svd1$d^2), xlab="Column", ylab = "Prop. of variance explained", pch=19)

# Missing Values are always hard to deal with it.
# Use the Library impute
library(impute)
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100, size=40, replace=FALSE)]
dataMatrix2 <- impute.knn(dataMatrix2)$data 

# Face Example
