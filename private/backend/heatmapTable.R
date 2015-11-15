library(plyr)

####TO DO: CREATE DATA TABLE FOR INPUT TO THIS FUNCTION
####COLUMN 1: Product ID
####COLUMN 2: Product department as factor
####COLUMN 3: Projected sales for product (raw)
####COLUMN 4: Projected sales for product (proportionate to mean)

##column names: product_id, product_department, raw_sales, prop_sales
#column names tentative
heatmapTable <- function(intable) {
  intable$product_department <- as.factor(intable$product_department)
  heattable <- ddply(intable, "product_department", summarize, 
                     traffic = sum(raw_forecast)/sum(mean_observed))
  
  return(heattable)
}


