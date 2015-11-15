var npm = {
  util:Npm.require('util'),
  path:Npm.require('path')
};

var rootDirectory = npm.path.normalize(process.cwd().split('.meteor')[0]);

/**
 * Evaluates a string of R code.e.
 * @param {string} cmd - The R code to execute.
 * @return The result of evaluating the code.
 * @throws Will throw if the Rserve server doesn't respond or if the R code throws while executing.
 */
function r_eval(cmd) {
  var cfg = Npm.require(npm.path.resolve(rootDirectory, 'packages', 'grocery-mw', 'rserve.cfg.js'));
  var client = rserve_client.connect(cfg);

  try {
    return client.evaluate(cmd);
  } finally {
    client.end();
  }
}

/**
 * Function decorator. The decorated function will intercept any thrown exception and replace it with a Meteor.Error.
 * @param {function} fn - The function to decorate.
 * @param {object} contect - The object to invoke the function on.
 * @return {function} The decorated function.
 * @throws A Meteor.Error if the wrapped function throws an exception.
 */
function wrap(fn, context) {
  return function() {
    try {
      return fn.apply(context || global, arguments);
    } catch(x) {
      throw new Meteor.Error("grocery-mw", "Encountered an error when calling function.");
    }
  };

}
// A global object to work as a namespace for the exported functions.
grocery_mw = {
  /**
   * Queries the database for the list of departments.
   * @return {[String]} An array of strings for the departments.
   * @throws Will throw if the server doesn't respond.
   */
  getDepartments: function() {
      return r_eval('mw.getDepartments()');
  },

  /**
   * Queries the database for the list of products in a department.
   * @param {string} dept - The department to get the products for.
   * @return {[String]} An array of strings of the product names.
   * @throws Will throw if the server doesn't respond.
   */
  getItemsFromDepartment: function(dept) {
    return r_eval(npm.util.format('mw.getItemsFromDepartment("%s");', dept));
  },

  /**
  * Creates a heatmap for a date specified as three integers or as a formatted string.
  * @param {int} y - The year of the date.
  * @param {int} m - The month of the date.
  * @param {int} d - The day of the date.
  * @param {string} date - Uses format "%d-%d-%d" as only parameter as the date.
  * @return {string} - Absolute path to the generated image.
  * @throws Will throw if the server doesn't respond.
  */
  heatmapForDate: function(y, m, d) {
    var date;
    if(m === undefined && d === undefined) {
      date = y.toString();
    } else {
      date = y + '-' + m + '-' + d;
    }
    var relative_path = r_eval(npm.util.format('mw.heatmapForDate(%s);', date));
    return npm.path.resolve(rootDirectory, "private", "img", relative_path);
  }

};

// Registers wrapped versions of the functions in grocery_mw as Meteor methods.
Meteor.methods({
  getDepartments: wrap(grocery_mw.getDepartments, grocery_mw),
  getItemsFromDepartment: wrap(grocery_mw.getItemsFromDepartment, grocery_mw),
  heatmapForDate: wrap(grocery_mw.heatmapForDate, grocery_mw)
});
