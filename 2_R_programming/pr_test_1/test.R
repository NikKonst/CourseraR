pollutantmean <- function(directory, pollutant, id = 1:332) {
        vec <- numeric()
        
        files <- list.files(path = directory)
        
        for(i in id) {
                data <- read.csv(paste(directory, files[i], sep = "/"))
                pol <- data[[pollutant]]
                bad <- is.na(pol)
                pol <- pol[!bad]
                vec <- c(vec, pol)
        }
        mean(vec)
}



complete <- function(directory, id = 1:322) {
        matr <- matrix(ncol = 2)
        dta <- data.frame()
        
        
        files <- list.files(path = directory)
        num = numeric()
        
        for(i in id) {
                data <- read.csv(paste(directory, files[i], sep = "/"))
                compVec <- complete.cases(data)
                num <- length(compVec[compVec == TRUE])
                dta <- rbind(dta, c(i, num))
        }
        names(dta) <- c("id", "nobs")
        dta
}

corr <- function(directory, threshold = 0) {
       comp <- complete(directory)
       goodDF <- comp[comp$nobs > threshold, ]
       
       filesNum <- goodDF$id
       
       corr <- numeric()
       
       files <- list.files(path = directory)
       
       for(i in filesNum) {
               data <- read.csv(paste(directory, files[i], sep = "/"))
               compVec <- complete.cases(data)
               sulfGood <- data$sulfate[compVec]
               nitrGood <- data$nitrate[compVec]
               c <- cor(sulfGood, nitrGood)
               corr <- c(corr, c)
       }
       
       corr
}