library(plyr)
library(ggplot2)
## Load datasets that are already in the working directory
popdata<-read.csv("Population Data.csv",skip=4,stringsAsFactors=FALSE,nrows=54,)  
ethnicdata<-read.csv("Divorce Ethnic.csv",stringsAsFactors=FALSE)
ethnicdf<-data.frame(ethnicdata)
ethnicdf[,3]<-as.numeric(gsub(",","",ethnicdf[,3]))  
ethnicdf[,2]<-as.numeric(gsub(",","",ethnicdf[,2])) 
names(ethnicdf)[6]<-"Inter.Ethnic"

shinyServer(
  function(input, output) {
    
## Divorce rate plot changes as different Ethnic group is chosen from UI.    
    output$plot <- renderPlot({
      
      switch(input$var, 
                     "Chinese" = 
                       ggplot(ethnicdf,aes(x=Year,y=Chinese))+
                       ggtitle("Yearly Divorce Numbers")+
                       geom_smooth(aes(colour="Chinese"))+
                       geom_path(aes(x=Year,y=Total.,colour="Nation Wide")),
                     
                     "Indians" = ggplot(ethnicdf,aes(x=Year,y=Indians))+
                       ggtitle("Yearly Divorce Numbers")+
                       geom_smooth(aes(colour="Indians"))+
                       geom_path(aes(x=Year,y=Total.,colour="Nation Wide")),
                     
                     "Others" = ggplot(ethnicdf,aes(x=Year,y=Others))+
                        ggtitle("Yearly Divorce Numbers")+
                       geom_smooth(aes(colour="Others"))+
                      geom_path(aes(x=Year,y=Total.,colour="Nation Wide")),
                     
                     "Inter-Ethnic" = ggplot(ethnicdf,aes(x=Year,y=Inter.Ethnic))+
                       ggtitle("Yearly Divorce Numbers")+
                       geom_smooth(aes(colour="Inter-Ethnic"))+
                       geom_path(aes(x=Year,y=Total.,colour="Nation Wide"))
                     )
      
          })
    
## The loops below basically merge the population and divorce datasets together using year as the comparision key.
    for(i in 1:nrow(ethnicdf)){
      for( j in 1:nrow(popdata)){
        if (ethnicdf[i,1]==popdata[j,1]) { 
          popdata[j,19] <- ethnicdf[i,2]
          popdata[j,20] <- ethnicdf[i,3]
          popdata[j,21] <- ethnicdf[i,4]
          popdata[j,22] <- ethnicdf[i,5]
        }
      }
    }
    
## Rename some of the columns for ease of reference

    names(popdata)[9]<-"Populaton.Density"    
    names(popdata)[11]<- "Median.Age"
    names(popdata)[12]<-"Elderly.Support.Ratio"
    names(popdata)[14]<-"Dependency.Ratio"
    
    names(popdata)[19]<-"Total.Divorce"
    names(popdata)[20]<-"Chinese.Divorce"
    names(popdata)[21]<-"Indians.Divorce"
    names(popdata)[22]<-"Other.Divorce"

## Select only records from the year 1980 onward as there were no divorce data before that.
    popdata2<-subset(popdata,popdata$Time>1979)
    apply(na.omit(popdata),2,max)
    popdata2<-popdata2[complete.cases(popdata2),]
    
    popdata2[,9]<-as.numeric(gsub(",","",popdata2[,9]))
    popdata2[,19]<-as.numeric(gsub(",","",popdata2[,19]))
    popdata2[,20]<-as.numeric(gsub(",","",popdata2[,20]))
    popdata2[,21]<-as.numeric(gsub(",","",popdata2[,21]))
    popdata2[,22]<-as.numeric(gsub(",","",popdata2[,22]))
    
   
## Fit a linear model using Total Divorce as the results and predictors selected by the user. 
    predictors<-c("Median.Age","Elderly.Support.Ratio","Dependency.Ratio")
    selected<-reactive({predictors[(as.numeric(input$var2))]})
    fmla <- reactive({as.formula(paste("Total.Divorce ~ ", paste(selected(), collapse= "+")))})
    fit<-reactive({lm(fmla(),data=popdata2)})   

    output$plot2 <-renderPlot({ 
            plot(fit(),height = 400, width = 600)
          })
     
    output$summary<- renderPrint({print(summary(fit()))})
  

  }
)

