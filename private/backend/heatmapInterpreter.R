heatmapInterpreter <- function (conn, time_id, promotion_id=0) {

  dat <- dbGetQuery(conn, "SELECT product_id,product_class_id FROM product")
  dat <- head(dat, -1)

  pdepartment <- unlist(lapply(dat$product_class_id, FUN=function(x,y) {
    dbGetQuery(y, paste("SELECT product_department FROM product_class WHERE product_class_id=", x))
  }, conn))

  means <- unlist(lapply(dat$product_id, get_p_daily_sales_avg, conn))

  rforecast <- unlist(lapply(dat$product_id, FUN=function (x, conn, t, p) {
    model <- sales_by_product(conn, x)
    predi <- predict(model, data.frame(time_id=t, promotion_id=p))
    return(predi[1])
  }, conn, time_id, promotion_id))

  interpretable <- data.frame(product_id = dat$product_id, product_department = pdepartment,
                              mean_observed = means, raw_forecast = rforecast)

  return(interpretable)
}
