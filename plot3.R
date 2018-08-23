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
  hpc[, Sub_metering_1 := as.numeric(Sub_metering_1)]
  hpc[, Sub_metering_2 := as.numeric(Sub_metering_2)]
  hpc[, Sub_metering_3 := as.numeric(Sub_metering_3)]
  hpc
}

plot3 <- function(hpc) {
  png("plot3.png", width = 480, height = 480, units = "px")
  with(hpc, {
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
           col=c('black', 'red', 'blue')
           )
  })
  dev.off()
}

suppressWarnings({
  loadLibraries()
  hpc <- prepareData()
  plot3(hpc)
})