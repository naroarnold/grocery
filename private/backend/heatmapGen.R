heatmapGen <- function(heattable) {
  
  #z variable is an imitation of a static variable. 
    #It accumulates every time this function is called
  z <- attr(heatmapGen, "name")
  if(is.null(z)) {z<-0}
  z <- z+1
  
  #convert the factor value from the input table back to a character
  heattable[[1]] <- lapply(heattable[[1]], as.character)
  
  #input floor plan
  #this must be set to the specific floor plan for this iteration of the module
  # filename <- "~/uky 15-16/CS499/project_code/FloorPlan.csv"
  filename <- file.path(mw.directory, "FloorPlan.csv")
  floorplan <- read.csv(file=filename, stringsAsFactors=FALSE)
  
  floorplan <- floorplan[rev(rownames(floorplan)),]
  rownames(floorplan) <- 1:length(rownames(floorplan))
  
  
  ##map department weight to department location in store
  floorweight <- as.matrix(as.data.frame(lapply(floorplan, FUN=function(x,y) {
    sapply(x, FUN=function(x,y) {y [y[[1]]==x, 2]}, y)
  }, heattable)))
  
  img_filename <- gettextf("heatmap_%d.jpg", z);
  
  #create heatmap
    #open file location
  jpeg(file = file.path(mw.imgDirectory, img_filename))
    #establish the heatmap
  store_heatmap <- heatmap(floorweight, Rowv = NA, Colv = NA,
                           col=rainbow(128, start=4/6, end=0),
                           scale = "none", margins = c(5,5))
    #close file connection
  dev.off()
  
  #save z, the "static" variable
  attr(heatmapGen, "name") <<- z
  
  return (img_filename);
}
