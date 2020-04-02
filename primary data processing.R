data1=read.csv("time_series_covid19_confirmed_global.csv")
data2=read.csv("time_series_covid19_deaths_global.csv")
data3=read.csv("time_series_covid19_recovered_global.csv")
conf=c()
death=c()
recov=c()
for (i in 5:ncol(data1))
{
  conf[i]=sum(data1[,i])
}

conf=conf[-c(1:4)]

for (i in 5:ncol(data2))
{
  death[i]=sum(data2[,i])
}

death=death[-c(1:4)]

for (i in 5:ncol(data3))
{
  recov[i]=sum(data3[,i])
}

recov=recov[-c(1:4)]

cum_data=data.frame(cbind(seq(1,ncol(data1)-4),conf,death,recov,conf-death-recov))
colnames(cum_data)=c("Days","Confirmed","Deaths","Recoveries","Active")
write.table(cum_data,"time_series_covid19_cumudf_global.csv",sep=",",row.names = F)


for (i in 2:length(conf)-1)
{
  conf[i]=conf[i+1]-conf[i]
}


for (i in 2:length(death)-1)
{
  death[i]=death[i+1]-death[i]
}



for (i in 2:length(recov)-1)
{
  recov[i]=recov[i+1]-recov[i]
}

n=length(recov)
daily_data=data.frame(cbind(seq(1,n-1),conf[-n],death[-n],recov[-n]))
colnames(daily_data)=c("Days","Confirmed","Deaths","Recovered")
write.table(daily_data,"time_series_covid19_dailydf_global.csv",sep=",",row.names = F)


