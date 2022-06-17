# correlation using corrplot and correlogram
library(corrplot)
head(mtcars)
M<-cor(mtcars)
head(round(M,2))
jpeg(file='circleplot.jpeg', width = 1280, height = 720)
corrplot(M, method="number")
dev.off()
#pie, number, color, circle -> change the type of corrplot

#correlation using correlation matrix
library("PerformanceAnalytics")

#replace M instead of my data to get another correlation matrix
jpeg(file='corr_matrix.jpeg', width = 1280, height = 720)
chart.Correlation(M, histogram=TRUE, pch=19)
dev.off()

#correlation using correlation test and ggpubr
library("ggpubr")
my_data <- mtcars
head(my_data)
jpeg(file='spearman.jpeg', width = 1280, height = 720)
ggscatter(my_data, x = "mpg", y = "wt", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Miles/(US) gallon", ylab = "Weight (1000 lbs)")
dev.off()
#replace the cor.method pearson, kendall and spearman