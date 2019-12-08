a=read.csv("best50.csv")
a$names<-as.character(a$names)
library(HelpersMG)
for(i in 1:50){
  wget(paste0("https://www.ncei.noaa.gov/data/global-historical-climatology-network-daily/access/",a$names[i],".csv"))
}