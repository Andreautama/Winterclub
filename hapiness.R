#load dataset
hp <- read.csv("2019.csv")
head(hp) 

#check any missing value 
print(colSums(is.na(hp)))
summary(hp)


#check before processing dataset
summary(hp)
print(any(duplicated(hp)))
print(sapply(hp,class))


head(hp,4)
tail(hp,4)

hp_to <- hp[,c('Score','GDP.per.capita','Social.support','Healthy.life.expectancy',
               'Freedom.to.make.life.choices','Perceptions.of.corruption','Generosity')]
hp_to <- scale(hp_to) 

#data analysis 
install.packages("ggplot2")
library(ggplot2) 
install.packages("reshape2")
library(reshape2)

hp2 <- hp_to[,c('Generosity','GDP.per.capita','Social.support','Healthy.life.expectancy',
                'Freedom.to.make.life.choices','Perceptions.of.corruption','Score')]


corr_mat <- round(cor(hp2),2)
melted_corr_mat <- melt(corr_mat)

ggplot(data = melted_corr_mat, aes(x=Var1, y=Var2, fill=value)) +
  geom_tile() +
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 4)

level_corr <- melted_corr_mat[melted_corr_mat$Var1 == 'Score', ]
sorted_popularity_corr <- level_corr[order(level_corr$value, decreasing=TRUE),]
sorted_popularity_corr

library(rafalib)

hp2 <- as.data.frame(hp2)
mypar(3,2)
ggplot(hp2, aes(GDP.per.capita,Score))+ geom_point()+ geom_smooth(method=lm)
ggplot(hp2, aes(Social.support,Score))+ geom_point()+ geom_smooth(method=lm)
ggplot(hp2, aes(Healthy.life.expectancy,Score))+ geom_point()+ geom_smooth(method=lm)
ggplot(hp2, aes(Freedom.to.make.life.choices,Score))+ geom_point()+ geom_smooth(method=lm)
ggplot(hp2, aes(Perceptions.of.corruption,Score))+ geom_point()+ geom_smooth(method=lm)
ggplot(hp2, aes(Generosity,Score))+ geom_point()+ geom_smooth(method=lm)


#Check all columns name
sort(colnames(hp2))

#Renaming columns
colnames(hp2) <- c('Freedom.to.make.life.choices','GDP.per.capita','Generosity',
                   'Healthy.life.expectancy',
                   'Perceptions.of.corruption','Score','Social.support')
sort(colnames(hp2))

# create train and test
#make this example reproducible
set.seed(1)

#use 70% of dataset as training set and 30% as test set
sample <- sample(c(TRUE, FALSE), nrow(hp2), replace=TRUE, prob=c(0.7,0.3))
train  <- hp2[sample, ]
test   <- hp2[!sample, ]

#get dependent variable
y_train <- train[c("Score")]
y_test <- test[c("Score")]

# get independent variables
x_train <- train[c('Freedom.to.make.life.choices','GDP.per.capita','Generosity',
                   'Healthy.life.expectancy',
                   'Perceptions.of.corruption','Score','Social.support')]
x_test <- test[c('Freedom.to.make.life.choices','GDP.per.capita','Generosity',
                 'Healthy.life.expectancy',
                 'Perceptions.of.corruption','Score','Social.support')]


# validasi hasil split
cat("\njumlah baris x train:", nrow(x_train))
cat("\njumlah baris x test:", nrow(x_test))

cat("\njumlah kolom x: ", ncol(x_train))
cat("\njumlah kolom y: ", ncol(y_train))

model1 <- lm(Score ~ Freedom.to.make.life.choices + GDP.per.capita + Generosity
             + Healthy.life.expectancy + Perceptions.of.corruption + Social.support,
             data = train)
summary(model1)

install.packages('Metrics')
library(Metrics)

test$pred_Score1 <- predict(model1, newdata=x_test)
cat('\nMAE: ', mae(y_test$Score, test$pred_Score1))
cat('\nMSE: ', mse(y_test$Score, test$pred_Score1))
cat('\nRMSE: ',rmse(y_test$Score, test$pred_Score1))

model2 <- lm(Score ~  GDP.per.capita  + Healthy.life.expectancy 
             + Social.support, data = train)
test$pred_Score2 <- predict(model2, newdata=x_test)
cat('\nMAE: ', mae(y_test$Score, test$pred_Score2))
cat('\nMSE: ', mse(y_test$Score, test$pred_Score2))
cat('\nRMSE: ',rmse(y_test$Score, test$pred_Score2))

model3 <- lm(Score ~ Freedom.to.make.life.choices + GDP.per.capita + Generosity
             + Healthy.life.expectancy, data = train)
test$pred_Score2 <- predict(model2, newdata=x_test)
cat('\nMAE: ', mae(y_test$Score, test$pred_Score2))
cat('\nMSE: ', mse(y_test$Score, test$pred_Score2))
cat('\nRMSE: ',rmse(y_test$Score, test$pred_Score2))

ggplot(test,aes(Score,pred_Score1)) +
  geom_point(color="darkblue") +
  geom_smooth(method="lm",color="blue",size=1) +
  ggtitle("Predicted Score vs actual Score") + theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Actual Score") +
  ylab("Predicted Score")

ggplot(test,aes(Score,pred_Score2)) +
  geom_point(color="darkblue") +
  geom_smooth(method="lm",color="blue",size=1) +
  ggtitle("Predicted Score vs actual Score") + theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Actual Score") +
  ylab("Predicted Score")
