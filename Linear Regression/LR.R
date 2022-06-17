library(AER)
data(CASchools)
View(CASchools)
attach(CASchools)

CASchools$STR <- CASchools$students/CASchools$teachers 
CASchools$score <- (CASchools$read + CASchools$math)/2    

avg_STR <- mean(CASchools$STR) 
avg_score <- mean(CASchools$score)

sd_STR <- sd(CASchools$STR) 
sd_score <- sd(CASchools$score)

quantiles <- c(0.10, 0.25, 0.4, 0.5, 0.6, 0.75, 0.9)
quant_STR <- quantile(CASchools$STR, quantiles)
quant_score <- quantile(CASchools$score, quantiles)

print(paste('Quantile Scores:', quant_score))
DistributionSummary <- data.frame(Average = c(avg_STR, avg_score), 
                                  StandardDeviation = c(sd_STR, sd_score), 
                                  quantile = rbind(quant_STR, quant_score))

print('Distribution Summary:')
DistributionSummary

beta_1 <- sum((CASchools$STR - mean(CASchools$STR)) * (CASchools$score - mean(CASchools$score))) / sum((CASchools$STR - mean(CASchools$STR))^2)
beta_2 <- mean(CASchools$score) - beta_1 * mean(CASchools$STR)

print(paste('Beta 1 and Beta 2 values:', beta_1, beta_2))

linear_model <- lm(score ~ STR, data = CASchools)
print('Summary of Linear Model:')
summary(linear_model)

jpeg('Scatterplot of TestScore and STR.jpeg', width = 1280, height = 720)
plot(score ~ STR, 
     data = CASchools,
     main = "Scatterplot of TestScore and STR", 
     xlab = "STR (X)",
     ylab = "Test Score (Y)",
     xlim = c(10, 30),
     ylim = c(600, 720))
abline(linear_model, col = 'red') 
dev.off()
