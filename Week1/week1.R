library(xlsx)
library(XML)
library(data.table)

# question 1
if(!file.exists("housingData.csv")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(url, "housingData.csv")
}

gasData <- read.xlsx("housingData.csv")


sum(housingData$VAL==24, na.rm=T)


# question 3
if(!file.exists("Data.gov_NGAP.xlsx")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
    download.file(url, "Data.gov_NGAP.xlsx", mode="wb")
}

dat <- read.xlsx("Data.gov_NGAP.xlsx", sheetIndex=1, rowIndex=18:23, colIndex=7:15)
sum(dat$Zip*dat$Ext,na.rm=T)


# question 4
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(url, useInternalNodes=T)
rootNode <- xmlRoot(doc)
zips <- xpathSApply(rootNode, "//zipcode", xmlValue)
sum(zips==21231)

# question 5
if(!file.exists("ss06pid.csv")) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(url, "ss06pid.csv")
}

DT <- fread("ss06pid.csv", sep=",", header=T)


mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)     		
mean(DT$pwgtp15,by=DT$SEX) 	# wrong answer		
tapply(DT$pwgtp15,DT$SEX,mean) 			
DT[,mean(pwgtp15),by=SEX] 
sapply(split(DT$pwgtp15,DT$SEX),mean) 			
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]  # intentional error


system.time(replicate(100, mean(DT[DT$SEX==1,]$pwgtp15) + 
                mean(DT[DT$SEX==2,]$pwgtp15)))
system.time(replicate(1000, tapply(DT$pwgtp15,DT$SEX,mean)))
system.time(replicate(1000, DT[,mean(pwgtp15),by=SEX]))
system.time(replicate(1000, sapply(split(DT$pwgtp15,DT$SEX),mean)))




