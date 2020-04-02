

conf=read.csv("time_series_covid19_confirmed_global.csv")
death=read.csv("time_series_covid19_deaths_global.csv")
recov=read.csv("time_series_covid19_recovered_global.csv")

country=unique(conf$Country.Region)
country=as.character(country)
n=ncol(conf)
c=c()
d=c()
r=c()
for( i in country)
  {
    temp=conf[conf$Country.Region==i,]
     c[i]=sum(temp[,n])
}

for( i in country)
{
  temp=death[death$Country.Region==i,]
  d[i]=sum(temp[,n])
}

for( i in country)
{
  temp=recov[recov$Country.Region==i,]
  r[i]=sum(temp[,n])
}

df=cbind.data.frame(country,c,d,r)
colnames(df)=c("Country","Confirmed","Deaths","Recovered")
rownames(df)=c()
write.table(df,"countrywise data.csv",sep=",",row.names = F)
