complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  nobs = vector()
  for(file in id)
  {
    #cat("Running through file:", file, "\n")
    ogID = file
    if(file < 10)
    {
      file = paste("00", file, sep = "")
    } else if(file <100) {
      file = paste("0", file, sep = "")
    }
    
    path = paste(directory, "\\", file, ".csv", sep = "")
    data <- read.csv(path)
    ok <- complete.cases(data)
    rowNumber = sum(ok)
    #cat("rowNumber: ", rowNumber, "\n")
    nobs = c(nobs, rowNumber)
    #cat("Nobs: ", nobs, "\n")
  }
  
  dataFrame = data.frame(id=id, nobs=nobs)
  dataFrame
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
}