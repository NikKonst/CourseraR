library(data.table)

DF = data.frame(a = rnorm(9), b = rep(c("a", "b", "c"), each = 3), c = rnorm(9))

head(DF)

DT = data.table(a = rnorm(9), b = rep(c("a", "b", "c"), each = 3), c = rnorm(9))

head(DT)

DT[2,]

DT[DT$b == "b", ]

head(DT)

DT[c(2, 3)] #Row subset (2 and 3 rows)

##COLUMN SUBSET

DT[, list(mean(a), sum(c))]

##Add new column
DT[, w:=c^2]
head(DT)

#???? ??????????? ?????? ?????????? ?? ???????? ???!!!
#??? ?????????
DT2 <- DT
DT[, b := 2]

head(DT)
head(DT2)

##Functions
DT[, m:={tmp <- a+c; log2(tmp+5)}]
head(DT)

DT[, x:=a>2]
head(DT)

DT[, me := mean(a + c), by=x]
head(DT)

###
DT <- data.table(x=sample(letters[1:3], 1E5, T))
DT[, .N, by=x]

#KEYS
DT <- data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
setkey(DT, x)
DT['a']

DT[,mean(pwgtp15),by=SEX]
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
sapply(split(DT$pwgtp15,DT$SEX),mean)
tapply(DT$pwgtp15,DT$SEX,mean)
