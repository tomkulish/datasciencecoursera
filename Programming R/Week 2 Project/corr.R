corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  completedMatrix <- complete(directory)

  id=completedMatrix[completedMatrix$nobs>threshold,]
  id <- id[["id"]]
  #cat("print ids: ", id, "\n")
  vec = vector()
  for(file in id)
  {
    #cat("Running through file:", file, "\n")
    if(file < 10)
    {
      file = paste("00", file, sep = "")
    } else if(file < 100) {
      file = paste("0", file, sep = "")
    }

    path = paste(directory, "\\", file, ".csv", sep = "")
   # cat("Path:", path, "\n")
    data <- read.csv(path)
    completeData <- data[complete.cases(data),]
    #cat("completedData: ", completeData, "\n")
    completedCor <- cor(completeData[["sulfate"]], completeData[["nitrate"]])
    #cat("compeletedCor: ", completedCor, "\n")
    vec = c(vec,completedCor)
    #cat("vector:", vec)
  }
  vec
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
}