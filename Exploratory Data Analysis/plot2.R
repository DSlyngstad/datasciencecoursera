#Exploratory Data Analysis Peer Review Project 1 plot 2

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

#plot2

head(df_sub)
df_sub$DateREC <- as.Date(df_sub$Date)
head(df_sub)
?strptime

df_sub$datetime <- strptime(paste(df_sub$Date, df_sub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
str(df_sub)
head(df_sub)

#testing plot
plot(x = df_sub$datetime, y = df_sub$Global_active_power, type = 'l', xlab="", ylab="Global Active Power (kilowatts)")
plot2 <- plot(x = df_sub$datetime, y = df_sub$Global_active_power, type = 'l', xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png,'plot2.png')
dev.off()

#______________________________________________________________________________________________
