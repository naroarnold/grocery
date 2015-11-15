sales_by_product <- function(con,prod_id)
{

	query <- paste("SELECT* FROM sales_fact_1997 WHERE product_id = '",prod_id,"'")	

	data <- dbGetQuery(con,query)

	sales_model <- lm(store_sales ~ time_id + promotion_id, data=data)

	return (sales_model)

}
