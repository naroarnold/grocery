library(plyr)

heatmapTable <- function(intable) {
  #convert department names to factor (in order to operate by department)
  intable$product_department <- as.factor(intable$product_department)
  
  #create a table that assigns a weight to each department's total forecast
  heattable <- ddply(intable, "product_department", summarize, 
                     traffic = sum(raw_forecast)/sum(mean_observed))
  
  return(heattable)
}


