get_p_daily_sales_avg <- function(product_id,con)
{
	query <- paste("SELECT store_sales,day_of_month,month_of_year FROM sales_fact_dec_1998_p,time_by_day WHERE product_id = ",product_id,"AND sales_fact_dec_1998_p.time_id = time_by_day.time_id;")
	data <- dbGetQuery(con,query)

	result <- mean(data$store_sales)
	return (result)
}
