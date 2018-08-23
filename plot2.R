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
  hpc
}

plot2 <- function(hpc) {
  png("plot2.png", width = 480, height = 480, units = "px")
  with(hpc, {
    plot(
      datetime,
      Global_active_power,
      type = 'n',
      xlab = '',
      ylab = 'Global Active Power (kilowatts)'
    )
    
    lines(datetime, Global_active_power)
  })
  dev.off()
}

suppressWarnings({
  loadLibraries()
  hpc <- prepareData()
  plot2(hpc)
})