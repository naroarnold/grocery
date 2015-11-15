var npm = {
  rserve_client:Npm.require('rserve-client')
};

// Global object to serve as a namespace for the exported functions.
rserve_client = {
  /**
   * Connects to a specified Rserve server and returns a connection object.
   * @param {string} options.host - The host of the server to connect to.
   * @param {string} options.port - The port the server is listening on.
   * @return {object} The connection object. Has evaluate() and end() methods.
   * @throws Will throw if the server doesn't respond or declines the connection.
   */
  connect: function(options) {
    var port = options.port;
    var host = options.host;
    var connection = Meteor.wrapAsync(npm.rserve_client.connect, npm.rserve_client)(host, port);
    connection.evaluate = Meteor.wrapAsync(connection.evaluate);
    return connection;
  }
};
