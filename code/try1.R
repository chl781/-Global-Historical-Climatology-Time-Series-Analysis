rm(list=ls())

args = (commandArgs(trailingOnly=TRUE))
if(length(args) == 1){
  name = args[1]
} else {
  cat('usage: Rscript regression_simplified.R <filenames>\n', file=stderr())
  stop()
}

require(tseries)
require(astsa)
require(ggplot2)
require(forecast)
filename=name
data=read.csv(paste0(filename,".csv"))
data$DATE=as.character(data$DATE)
all_date=substr(data$DATE,start=1,stop=7)
unique.date=unique(all_date)
length_month=length(unique.date)
meanmonth=rep(0,length_month)
for(i in 1:length_month){
  meanmonth[i]=mean(data$PRCP[all_date==unique.date[i]],na.rm=T)
}
final1=data.frame(unique.date,meanmonth)
dta=ts(final1$meanmonth,frequency = 12)
fit=auto.arima(dta)
coeff=data.frame("names"=filename,"fit_aic"=fit$aic)
write.csv(coeff,file=paste0("out",filename,".csv"))


