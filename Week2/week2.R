library(sqldf)
library(httr)


# Question 1
oauth_endpoints("github")
myapp <- oauth_app("github",
                   key = "bcbe57dc7ef639fc4890",
                   secret = "420cf29fd65a51aed5c57574bc07ee5d7eed9653")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
req <- with_config(github_token, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)


# Question 2 & 3
acs <- read.csv("getdata_data_ss06pid.csv", stringsAsFactors=F)
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")


# Question 4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
as.numeric(sapply(htmlCode[c(10,20,30,100)], nchar))


# Question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url, "getdata_wksst8110.for")
contents <- read.fwf("getdata_wksst8110.for", widths=c(15,4,4,9), skip=4)
sum(contents[[4]])
