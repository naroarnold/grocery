heatmapGen <- function(heattable) {
  y <- attr(heatmapGen, "name")
  if(is.null(y)) {y<-0}
  y <- y+1

  heattable[[1]] <- lapply(heattable[[1]], as.character)

  #input floor plan
  #this must be set to the specific floor plan for this iteration of the module
  # filename <- "~/uky 15-16/CS499/project_code/FloorPlan.csv"
  filename <- file.path(mw.directory, "FloorPlan.csv")
  floorplan <- read.csv(file=filename, stringsAsFactors=FALSE)


  ##map department weight to department location in store
  floorweight <- as.matrix(as.data.frame(lapply(floorplan, FUN=function(x,y) {
    sapply(x, FUN=function(x,y) {y [y[[1]]==x, 2]}, y)
  }, heattable)))

  img_filename <- gettextf("heatmap_%d.jpg", y);

  #create heatmap
  # jpeg(file = paste("heatmap_", y, ".jpg", sep=""))
  jpeg(file = file.path(mw.imgDirectory, img_filename))
  store_heatmap <- heatmap(floorweight, Rowv = NA, Colv = NA,
                           col=rainbow(128, start=0, end=4/6),
                           scale = "none", margins = c(5,5))
  dev.off()
  attr(heatmapGen, "name") <<- y

  return (img_filename);
}
