heatmapInterpreter <- function (conn, time_id, promotion_id=0) {
  
  #query database for product id and product class id
  dat <- dbGetQuery(conn, "SELECT product_id,product_class_id FROM product")
  dat <- head(dat, -1)
  
  #use product class id to map to product department, stored as a vector
  pdepartment <- unlist(lapply(dat$product_class_id, FUN=function(x,y) {
    dbGetQuery(y, paste("SELECT product_department FROM product_class WHERE product_class_id=", x))
  }, conn))
  
  #find overall mean of each product's sales, stored as a vector
  means <- unlist(lapply(dat$product_id, get_p_daily_sales_avg, conn))
  
  #find forecast of sales for time_id per product, stored as a vector
  rforecast <- unlist(lapply(dat$product_id, FUN=function (x, conn, t, p) {
    model <- sales_by_product(conn, x)
    predi <- predict(model, data.frame(time_id=t, promotion_id=p))
    return(predi[1])
  }, conn, time_id, promotion_id))
  
  #combine product id, department name, means, and forecast into a data frame
  interpretable <- data.frame(product_id = dat$product_id, product_department = pdepartment,
                              mean_observed = means, raw_forecast = rforecast)
  
  return(interpretable)
}
