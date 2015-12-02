heatmapGen <- function(heattable, outname) {
  
  
  #convert the factor value from the input table back to a character
  heattable[[1]] <- lapply(heattable[[1]], as.character)
  
  #input floor plan
  #this must be set to the specific floor plan for this iteration of the module

  filename <- file.path(mw.directory, "FloorPlan.csv")
  floorplan <- read.csv(file=filename, stringsAsFactors=FALSE)
  floorplan <- floorplan[rev(rownames(floorplan)),]
  rownames(floorplan) <- 1:length(rownames(floorplan))
  
  ##map department weight to department location in store
  floorweight <- as.matrix(as.data.frame(lapply(floorplan, FUN=function(x,y) {
    sapply(x, FUN=function(x,y) {y [y[[1]]==x, 2]}, y)
  }, heattable)))
  
  
  #create heatmap
    #open file location
  jpeg(file = file.path(mw.imgDirectory, outname))
    #establish the heatmap
  store_heatmap <- heatmap(floorweight, Rowv = NA, Colv = NA,
                           col=rainbow(128, start=4/6, end=0),
                           scale = "none", margins = c(5,5))
    #close file connection
  dev.off()
  
}
