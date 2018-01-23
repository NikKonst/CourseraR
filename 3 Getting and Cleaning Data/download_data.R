#Download file
fileURL <- "https://data.baltimorecity.gov/api/views/aqgr-xx9h/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = ".\\data\\cameras.csv") #method = "curl" for MAC if HTTPS

list.files(".\\data")

#Date of dowloading
downloadingDate <- date()
downloadingDate 

#read.table
table <- read.table(".\\data\\cameras.csv", sep = ",", header = TRUE)
head(table)

#Read CSV
data <- read.csv(".\\data\\cameras.csv")
head(data)

#Download Excel
library(xlsx)
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileURL, destfile = ".\\data\\cameras.xlsx")

list.files(".\\data")

colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./test_files/dq1.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
dat
sum(dat$Zip*dat$Ext,na.rm=T)

#Download XML
library(XML)
fileURL <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileURL, isURL = TRUE, useInternalNodes = TRUE)
dat <- xmlTreeParse("./test_files/xmlq1.xml", useInternalNodes = TRUE)
xmlName(doc)
rooteNode <- xmlRoot(dat)
zipcodes <- xpathSApply(rooteNode, "//zipcode", xmlValue)
length(zipcodes[zipcodes == "21231"])

#JSON
library(jsonlite)
url <- "https://api.github.com/users/nikkonst/repos"
jsonData <- fromJSON(url)
names(jsonData)

library(jsonlite)
j <- toJSON(iris, pretty = T)
cat(j)

iris2 <- fromJSON(j)
head(iris2)

#MySQL
#install.packages("RMySQL")
library(RMySQL)
dbConn <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(dbConn, "show databases;")
dbDisconnect(dbConn)