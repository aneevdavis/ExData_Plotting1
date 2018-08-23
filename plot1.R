# Notes:
# - Please install the package data.table if you don't already have it!
# - This script assumes that the file 'household_power_consumption.txt' is in the working directory

loadLibraries <- function() {
  library(data.table)
}

#Prepares the data, changing the requisite 
prepareData <- function() {
  hpc <- fread('household_power_consumption.txt', sep=';')
  hpc[, Date := as.Date(Date, format = '%d/%m/%Y')]
  hpc <- hpc[Date == '2007-02-01' | Date == '2007-02-02']
  hpc[, Global_active_power := as.numeric(Global_active_power)]
  hpc
}

plot1 <- function(hpc) {
  png("plot1.png", width = 480, height = 480, units = "px")
  with(hpc, hist(
    Global_active_power,
    col = 'red',
    xlab = 'Global Active Power (kilowatts)',
    ylab = 'Frequency',
    main = 'Global Active Power'
  ))
  dev.off()
}

suppressWarnings({
  loadLibraries()
  hpc <- prepareData()
  plot1(hpc)
})