add2 <- function(x, y) {
  x + y
}

above10 <- function(x) {
  use <- x > 10
  x[use]
}

above <- function(x, n = 10) {
  use <- x > n
  x[use]
}

columnMean <- function(x, removeNA = TRUE) {
  n <- ncol(x)
  means <- numeric(n)

  for(i in 1:n) {
    means[i] <- mean(x[, i], na.rm = removeNA)
  }
  means
}
