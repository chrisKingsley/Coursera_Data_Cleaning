library(dplyr)
library(jpeg)
library(Hmisc)

# Question 1
housing <- read.csv("getdata_data_ss06hid.csv")
head(which(housing$ACR==3 & housing$AGS==6))


# Question 2
image <- readJPEG("getdata_jeff.jpg", native=T)
quantile(image, probs=c(0.3, 0.8))


# Question 3, 4, 5
eduData <- read.csv("getdata_data_EDSTATS_Country.csv", stringsAsFactors=F)
gdpData <- read.csv("getdata_data_GDP.csv", skip=5, nrow=190, header=F,
                    stringsAsFactors=F)[,c(1,2,4,5)]
colnames(gdpData) <- c("CountryCode","rank", "countryName", "GDP")
gdpData$GDP <- as.numeric(gsub(",", "", gdpData$GDP))

mergedData <- inner_join(eduData, gdpData, by="CountryCode") %>%
    select(CountryCode, rank, countryName, GDP, Income.Group) %>%
    arrange(desc(rank)) %>%
    mutate(rankQUantile = cut2(rank, g=5))

nrow(mergedData)
mergedData[13, ]

group_by(mergedData, Income.Group) %>%
    summarise(meanGDP_rank = mean(rank))

table(mergedData$Income.Group, mergedData$rankQUantile)
