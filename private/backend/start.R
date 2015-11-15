# This starts Rserve with the proper configuration.

## check that RCloud is properly installed
##installed <- gsub(".*/([^/]+)/DESCRIPTION$","\\1",Sys.glob(paste0(.libPaths(),"/*/DESCRIPTION")))

setwd('mw')
debug <- FALSE # isTRUE(nzchar(Sys.getenv("DEBUG")))
Rserve::Rserve(debug, args=c("--RS-conf", "rserve.conf", "--vanilla", "--no-save"))
