pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  vec <- vector()
  for(file in id)
  {
    #cat("Running through file:", file, "\n")
    
    if(file < 10)
    {
      file = paste("00", file, sep = "")
    } else if(file <100) {
      file = paste("0", file, sep = "")
    }
    
    path = paste(directory, "\\", file, ".csv", sep = "")
    data <- read.csv(path)
    
    values = data[,pollutant]
    values <- values[!is.na(values)]
    vec = c(values, vec)
  }

  mean(vec)
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
}