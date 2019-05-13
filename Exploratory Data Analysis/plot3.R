#Exploratory Data Analysis Peer Review Project 1 plot 3

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

#______________________________________________________________________________________________
#plot3

head(df_sub)
?plot
?legend

df_sub$Sub_metering1 <- as.numeric(as.character(df_sub$Sub_metering_1))
df_sub$Sub_metering2 <- as.numeric(as.character(df_sub$Sub_metering_2))
df_sub$Sub_metering3 <- as.numeric(as.character(df_sub$Sub_metering_3))

str(df_sub)
head(df_sub)

plot(df_sub$datetime, df_sub$Sub_metering1, type="l", ylab="Energy Submetering", xlab="")
lines(df_sub$datetime, df_sub$Sub_metering2, type="l", col="red")
lines(df_sub$datetime, df_sub$Sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

?png
png("plot3.png", width=480, height=480)
plot(df_sub$datetime, df_sub$Sub_metering1, type="l", ylab="Energy Submetering", xlab="")
lines(df_sub$datetime, df_sub$Sub_metering2, type="l", col="red")
lines(df_sub$datetime, df_sub$Sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
