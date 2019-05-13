#Exploratory Data Analysis Peer Review Project 1 plot 1

rm(list=ls())
getwd()

setwd("C:/Users/Daniel Slyngstad/Documents/R Working Directory/RMOOC2")

#reading in data
?read.table
df <- read.table('household_power_consumption.txt', sep = ';', header = TRUE)
head(df)
View(df)
dim(df)

?strptime

#subsetting for desired dates
df_sub <- subset(df, Date == '1/2/2007' | Date == '2/2/2007')

#____________________________________________________________________________________________

#plot 1

df_sub$Global_active_power <- as.numeric(as.character(df_sub$Global_active_power))

#plot1
hist(df_sub$Global_active_power, col = 'red', main = 'Global Active Power', xlab = "Global Active Power (kilowatts)")
plot1 <- hist(df_sub$Global_active_power, col = 'red', main = 'Global Active Power', xlab = "Global Active Power (kilowatts)")
dev.copy(png,'plot1.png')
dev.off()


#____________________________________________________________________________________________
