require(tseries)
require(astsa)
require(ggplot2)
require(forecast)

#############################################################function

plotForecastErrors <- function(forecasterrors)
{
  # make a histogram of the forecast errors:
  mybinsize <- IQR(forecasterrors, na.rm = TRUE)/4
  mysd   <- sd(forecasterrors, na.rm = TRUE)
  mymin  <- min(forecasterrors, na.rm = TRUE) - mysd*5
  mymax  <- max(forecasterrors, na.rm = TRUE) + mysd*3
  # generate normally distributed data with mean 0 and standard deviation mysd
  mynorm <- rnorm(10000, mean=0, sd=mysd)
  mymin2 <- min(mynorm, na.rm = TRUE)
  mymax2 <- max(mynorm, na.rm = TRUE)
  if (mymin2 < mymin ) { mymin <- mymin2}
  if (mymax2 > mymax) { mymax <- mymax2}
  # make a red histogram of the forecast errors, with the normally distributed data overlaid:
  mybins <- seq(mymin, mymax, mybinsize)
  hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
  # freq=FALSE ensures the area under the histogram = 1
  # generate normally distributed data with mean 0 and standard deviation mysd
  myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
  # plot the normal curve as a blue line on top of the histogram of forecast errors:
  points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
}


#############################################################


a=read.csv("best50.csv")
a$names<-as.character(a$names)

for(i in 1:50){
  data=read.csv(paste0(a$names[i],".csv"))
  data$DATE=as.character(data$DATE)
  all_year=substr(data$DATE,start=1,stop=5)
  all_month=substr(data$DATE,start=6,stop=7)
  all_month=as.numeric(all_month)
  all_season=as.character((all_month-1)%/%3)
  all_date=paste0(all_year,all_season)
  unique.date=unique(all_date)
  length_season=length(unique.date)
  meanseason=rep(0,length_season)
  for(i in 1:length_season){
    meanseason[i]=mean(data$PRCP[all_date==unique.date[i]],na.rm=T)
  }
  final1=data.frame(unique.date,meanseason)
  final1$unique.date=as.character(final1$unique.date)
  dta=ts(final1$meanseason,frequency = 4)
  fit=auto.arima(dta)
  plot(dta)
  #time series plot
  plotForecastErrors(fit$residuals)
  #Error plots
  forecast(dta,h=5,level=c(99.5))
  plot(forecast(dta,h=1,level=c(95)))
  #Forecast
  acf(dta,lag.max=100) #plot a correlogram
  acf(dta,lag.max=100,plot=FALSE) # get the autocorrelation values
  pacf(dta,lag.max=100) #plot a partial correlogram
  #acf and pcf plots
  
  adf.test(dta,k = 0)
  #Residual QQ plot?
  qqnorm(fit$residuals)
  qqline(fit$residuals)
  #qqplot
  ####holtwinter
  rainseriesforecasts <- HoltWinters(dta, beta=FALSE, gamma=T)
  rainseriesforecasts
  rainseriesforecasts$fitted
  plot(rainseriesforecasts)
}