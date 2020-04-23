full_country_Data=function(){
  conf=read.csv("https://raw.githubusercontent.com/sahasuman343/COVID-19-usefull-data/master/time_series_covid19_confirmed_global.csv")
  conf["new_cases"]=conf[,ncol(conf)]-conf[,ncol(conf)-1]
  conf=conf[,-c(3:(ncol(conf)-2))]
  
  death=read.csv("https://raw.githubusercontent.com/sahasuman343/COVID-19-usefull-data/master/time_series_covid19_deaths_global.csv")
  death["new_cases"]=death[,ncol(death)]-death[,ncol(death)-1]
  death=death[,-c(3:(ncol(death)-2))]
  
  recov=read.csv("https://raw.githubusercontent.com/sahasuman343/COVID-19-usefull-data/master/time_series_covid19_recovered_global.csv")
  recov["new_cases"]=recov[,ncol(recov)]-recov[,ncol(recov)-1]
  recov=recov[,-c(3:(ncol(recov)-2))]
  
  #population_data=read.csv("data/population_by_country_2020.csv")
  country=unique(conf$Country.Region)
  a=b=c=d=e=f=mort=recovery=c()
 
  for (i in country){
    temp1=conf[conf$Country.Region==i,]
    a[i]=sum(temp1[,3])
    b[i]=sum(temp1[,4])
    
    temp2=death[death$Country.Region==i,]
    c[i]=sum(temp2[,3])
    d[i]=sum(temp2[,4])
    
    temp3=recov[recov$Country.Region==i,]
    e[i]=sum(temp3[,3])
    f[i]=sum(temp3[,4])
    
    #Population[i]=subset(population_data,population_data$Country..or.dependency.==i)$Population..2020.
   # population_Density[i]=subset(population_data,population_data$Country..or.dependency.==i)$Density..P.KmÂ²
    #fertility_rate[i]=subset(population_data,population_data$Country..or.dependency.==i)$Fert..Rate
    
    mort[i]=round(c[i]/a[i],2)
    recovery[i]=round(e[i]/a[i],2)
  }
  
  df=cbind.data.frame(country,a,b,c,d,e,f,a-c-e,mort,recovery)
  colnames(df)=c("Country","Confirmed","New Cases","Deaths","New Deaths","Recovered","New Recovered","Active","Mortality Rate","Recovery Rate")
  rownames(df)=c()
  
  return(df)
}

df=full_country_Data()

write.csv(df, file = "Full_Country_data.csv", append = FALSE, quote = TRUE, sep = " ,")
