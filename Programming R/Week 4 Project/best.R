best <- function(state, outcome) {
  ## Read outcome data
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  states <- outcome$states
  validOutcome <- c("heart attack", "heart failure", "pneumonia")
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
}

# outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
#outcome[, 11] <- as.numeric(outcome[, 11])
#hist(outcome[, 11])
