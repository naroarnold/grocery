# Other R files should treat everything here as pre-defined
# i.e. don't source() it

mw.rootDirectory <- normalizePath(file.path(getwd(), '..', '..', '..'));
mw.directory <- file.path(mw.rootDirectory, 'private', 'backend');
mw.imgDirectory <- file.path(mw.rootDirectory, 'private', 'img');

DRIVER <- dbDriver('MySQL');

# Note: Uses IIFE.
# mw.conn is not a function, merely being set as the return value of one.
# This is done to avoid leaking the db configuration from db.cfg.R.
mw.conn <- (function() {
  source(file.path(mw.directory, 'mw', 'db.cfg.R'), local=TRUE);
  conn <- dbConnect(DRIVER, host=host, password=pass, user=user, dbname=name);
  return (conn);
})();
