best <- function(state, outcome) {
        #Clean data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        corOutcomes <- list(c("heart attack", "heart failure", 
                 "pneumonia"), c(11, 17, 23))
        
        if (!(outcome %in% corOutcomes[[1]])) {
                stop("invalid outcome")
        }
        
        data$State <- as.factor(data$State)
        allStates <- levels(data$State)
        
        if (!(state %in% allStates)) {
                stop("invalid state")
        }
        
        colNum <- match(outcome, corOutcomes[[1]])
        colOutcomeNum <- corOutcomes[[2]][colNum]
        
        stateData <- data[data$State == state, ]
        stateData[colOutcomeNum] <- suppressWarnings(as.numeric(unlist(stateData[colOutcomeNum])))
        stateDataClean <- stateData[!is.na(stateData[colOutcomeNum]), ]
        
        #Get hospital
        hospitalsNum <- which(stateDataClean[colOutcomeNum] == min(stateDataClean[colOutcomeNum]))
        
        bestHospitals <- as.character(stateDataClean$Hospital.Name[hospitalsNum])
        bestHospitals <- sort(bestHospitals)
        bestHospitals[1]
}

rankhospital <- function(state, outcome, num = "best") {
        #Clean data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        corOutcomes <- list(c("heart attack", "heart failure", 
                              "pneumonia"), c(11, 17, 23))
        
        if (!(outcome %in% corOutcomes[[1]])) {
                stop("invalid outcome")
        }
        
        data$State <- as.factor(data$State)
        allStates <- levels(data$State)
        
        if (!(state %in% allStates)) {
                stop("invalid state")
        }
        
        colNum <- match(outcome, corOutcomes[[1]])
        colOutcomeNum <- corOutcomes[[2]][colNum]
        
        stateData <- data[data$State == state, ]
        stateData[colOutcomeNum] <- suppressWarnings(as.numeric(unlist(stateData[colOutcomeNum])))
        stateDataClean <- stateData[!is.na(stateData[colOutcomeNum]), ] 
        
        #Get Rate
        hospRate <- 
                stateDataClean[order(stateDataClean[colOutcomeNum], stateDataClean$Hospital.Name), ]
        
        rateVec <- hospRate$Hospital.Name
        
        if (num == "best") {
                num = 1
        }
        else if(num == "worst") {
                num = length(rateVec)
        }
        
        rateVec[num]
}

rankall <- function(outcome, num = "best") {
        #Clean data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        corOutcomes <- list(c("heart attack", "heart failure", 
                              "pneumonia"), c(11, 17, 23))
        
        if (!(outcome %in% corOutcomes[[1]])) {
                stop("invalid outcome")
        }
        
        colNum <- match(outcome, corOutcomes[[1]])
        colOutcomeNum <- corOutcomes[[2]][colNum]
        
        data$State <- as.factor(data$State)
        allStates <- levels(data$State)
        allStates <- sort(allStates)
        hospitals <- character(length = length(allStates))
        i <- 1
        
        for(state in allStates) {
                stateData <- data[data$State == state, ]
                stateData[colOutcomeNum] <- suppressWarnings(as.numeric(unlist(stateData[colOutcomeNum])))
                stateDataClean <- stateData[!is.na(stateData[colOutcomeNum]), ] 
                
                #Get Rate
                hospRate <- 
                        stateDataClean[order(stateDataClean[colOutcomeNum], stateDataClean$Hospital.Name), ]
                
                rateVec <- hospRate$Hospital.Name
                
                n = num
                
                if (num == "best") {
                        n = 1
                }
                else if(num == "worst") {
                        n = length(rateVec)
                }
                
                hospitals[i] <- rateVec[n]
                i <- i + 1
        }
        
        res <- data.frame(hospitals, allStates)
        colnames(res) <- c("hospital", "state")
        res
}
