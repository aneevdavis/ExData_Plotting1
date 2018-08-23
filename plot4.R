# Notes:
# - Please install the package data.table if you don't already have it!
# - This script assumes that the file 'household_power_consumption.txt' is in the working directory

loadLibraries <- function() {
  library(data.table)
}

prepareData <- function() {
  hpc <- fread('household_power_consumption.txt', sep=';')
  
  hpc[, Date := as.Date(Date, format = '%d/%m/%Y')]
  hpc <- hpc[Date == '2007-02-01' | Date == '2007-02-02']
  hpc[, datetime := strptime(paste(Date, Time), format='%Y-%m-%d %H:%M:%S')]
  hpc[, Global_active_power := as.numeric(Global_active_power)]
  hpc[, Global_reactive_power := as.numeric(Global_reactive_power)]
  hpc[, Sub_metering_1 := as.numeric(Sub_metering_1)]
  hpc[, Sub_metering_2 := as.numeric(Sub_metering_2)]
  hpc[, Sub_metering_3 := as.numeric(Sub_metering_3)]
  hpc[, Voltage := as.numeric(Voltage)]
  hpc
}

plot4 <- function(hpc) {
  png("plot4.png", width = 480, height = 480, units = "px")
  par(mfrow = c(2,2), mar=c(4,4,4,2))
  
  #Plot 1
  with(hpc, {
    plot(
      datetime,
      Global_active_power,
      type = 'n',
      xlab = '',
      ylab = 'Global Active Power'
    )
    
    lines(datetime, Global_active_power)
    
    #Plot 2
    plot(
      datetime,
      Voltage,
      type = 'n'
    )
    
    lines(datetime, Voltage)
    
    #Plot 3
    plot(
      datetime,
      Sub_metering_1,
      type = 'n',
      xlab = '',
      ylab = 'Energy sub metering'
    )
    
    lines(datetime, Sub_metering_1, col='black')
    lines(datetime, Sub_metering_2, col='red')
    lines(datetime, Sub_metering_3, col='blue')
    legend('topright', 
           legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
           lwd = 1,
           bty = 'n',
           col=c('black', 'red', 'blue')
    )
    
    #Plot 4
    plot(
      datetime,
      Global_reactive_power,
      type = 'n'
    )
    
    lines(datetime, Global_reactive_power)
    
  })
  dev.off()
}

suppressWarnings({
  loadLibraries()
  hpc <- prepareData()
  plot4(hpc)
})