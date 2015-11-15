# this sets up Rserve for use with Meteor.
# don't attempt to source() it

source('includes.R');

vectorizedQuery = function(query) {
  ans <- dbGetQuery(mw.conn, query);
  return (unlist(ans));
}

mw.getDepartments <- function() {
  query <- "SELECT DISTINCT product_department from product_class;"
  return (vectorizedQuery(query))
}

mw.getItemsFromDepartment <- function(dept) {
  query <- paste("SELECT DISTINCT p.product_name FROM product p, product_class pc WHERE p.product_class_id = pc. product_class_id and pc.product_Department = '", dept, "';", sep="")
  return (vectorizedQuery(query))
}

mw.heatmapForDate <- function(date) {
  q <- gettextf("SELECT time_id FROM time_by_day WHERE the_date=STR_TO_DATE('%s', '%s');", date, "%Y-%m-%d")
  time_id =  vectorizedQuery(q);
  return (heatmapGen(heatmapTable(heatmapInterpreter(mw.conn, time_id))));
}
