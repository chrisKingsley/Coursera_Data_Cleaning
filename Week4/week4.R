library(dplyr)

# Question 4.1
housingData <- read.csv("getdata_data_ss06hid.csv", stringsAsFactors=F)
splitNames <- strsplit(names(housingData), split="wgtp")
splitNames[123]


# Question 4.2, 4.3, 4.4
gdpData <- read.csv("getdata_data_GDP.csv", skip=5, nrow=190, header=F,
                    stringsAsFactors=F)[,c(1,2,4,5)]
colnames(gdpData) <- c("CountryCode","rank", "countryName", "GDP")
gdpData$GDP <- as.numeric(gsub(",", "", gdpData$GDP))
mean(gdpData$GDP)

eduData <- read.csv("getdata_data_EDSTATS_Country.csv", stringsAsFactors=F)

mergedData <- inner_join(eduData, gdpData, by="CountryCode") %>%
    select(CountryCode, GDP, Special.Notes)
grep("Fiscal year end: June", mergedData$Special.Notes, value=T)


# Question 4.5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sum(grepl("^2012", sampleTimes))
sum(grepl("^2012", sampleTimes) & grepl("Monday", weekdays(sampleTimes)))
